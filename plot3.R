#Downloading dataset
if(!file.exists("exdata_data_household_power_consumption.zip")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip")
}
if(!file.exists("household_power_consumption.txt")){
  unzip("exdata_data_household_power_consumption.zip")
}

#Reading Dataset
library(data.table)
pdata <- data.table::fread("household_power_consumption.txt", sep = ";", na.strings = "?", skip = 1)

#Naming and Subsetting Dataset
names(pdata)<-c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
pdata <- pdata[(pdata$Date=="2/2/2007"|pdata$Date=="1/2/2007"),]

#Transforming Date and Time variables
datetime<-paste(pdata$Date, pdata$Time)
pdata$Date <- as.Date(pdata$Date, format = "%d/%m/%Y")
DateTime <- as.POSIXct(datetime, format = "%d/%m/%Y %H:%M:%S")
pdata$Datetime <- DateTime

#Constructing basic plot
plot(pdata$Datetime, pdata$Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "n")
lines(pdata$Sub_metering_1~pdata$Datetime)
lines(pdata$Sub_metering_2~pdata$Datetime, col= "red")
lines(pdata$Sub_metering_3~pdata$Datetime, col= "blue")
legend("topright", lty = 1, lwd = 2, col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#Copying Plot in png file device
dev.copy(png, file = "plot3.png", height= 480, width = 480)
dev.off()