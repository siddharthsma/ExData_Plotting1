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
data_dt <- within(data, { timestamp=format(as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S") })
data_dt$timestamp <- strptime(data_dt$timestamp, format="%d/%m/%Y %H:%M:%S")

data_dt$Global_active_power <- as.numeric(as.character(data_dt$Global_active_power))

png(filename="plot2.png", width= 480, height= 480, units= "px")
plot(data_dt$timestamp, data_dt$Global_active_power, type='l', ylab='Global Active Power (kilowatts)', xlab="")

dev.off()
