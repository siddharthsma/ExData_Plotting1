# Download and load data into R

setwd("~/code/coursera/exploratory_analysis/ExData_Plotting1")
filename <- 'household_power_consumption.txt'

if (!file.exists(filename)) {
  temp <- tempfile()
  download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', temp, mode='wb', method='curl')
  unzip(temp, filename )
}

all_data <- read.table(filename, sep=';', header=TRUE)
all_data$Date <- as.Date(all_data$Date, format="%d/%m/%Y")

# filter the data

start_date <- as.Date("2007-02-01")
end_date <- as.Date("2007-02-02")

data <- subset(all_data, Date >= start_date & Date <= end_date)

# Plot

data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
hist((data$Global_active_power), col='red', xlab='Global Active Power (kilowatts)', main="Global Active Power")

dev.copy(png, file="plot1.png")
dev.off()

