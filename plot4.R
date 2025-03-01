# 1- Download and load the dataset:
fileurl <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, destfile = "./projectdataset.zip")
unzip("./projectdataset.zip")
data<- read.table("household_power_consumption.txt", sep=";", header = TRUE)
library(dplyr)
data2<-data %>%
  filter(Date %in% c("1/2/2007","2/2/2007"))
data2[,(3:9)]<-data.frame(sapply(data2[(3:9)], as.numeric))

# 2- Convert the Date and Time variables to Date/Time classes 
data2$DateTime<-paste(data2$Date, data2$Time)
data2$DateTime<-strptime(data2$DateTime, format="%d/%m/%Y %H:%M:%S")

#Plot4
par(mfrow = c(2, 2))
plot(data2$DateTime, data2$Global_active_power, type="l", xaxt= "n", xlab ="", ylab ="Global Active Power")
days<- as.POSIXct(c("1/2/2007","2/2/2007", "3/2/2007"), format= "%d/%m/%Y")
axis(1, at=days, labels = c("Thy", "Fri", "Sat"))

plot(data2$DateTime, data2$Voltage, type="l", xlab="datetime", xaxt= "n", ylab ="Voltage")
days<- as.POSIXct(c("1/2/2007","2/2/2007", "3/2/2007"), format= "%d/%m/%Y")
axis(1, at=days, labels = c("Thy", "Fri", "Sat"))

plot(data2$DateTime, data2$Sub_metering_1, type="l", col="black", xlab="", xaxt= "n", ylab ="Energy sub metering")
lines(data2$DateTime, data2$Sub_metering_2, col="red")
lines(data2$DateTime, data2$Sub_metering_3, col="blue")
days<- as.POSIXct(c("1/2/2007","2/2/2007", "3/2/2007"), format= "%d/%m/%Y")
axis(1, at=days, labels = c("Thy", "Fri", "Sat"))
legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex=0.5, lwd=1, bty="n")

plot(data2$DateTime, data2$Global_reactive_power, type="l", xaxt="n", xlab="datetime", ylab="Global_reactive_powe")
days<- as.POSIXct(c("1/2/2007","2/2/2007", "3/2/2007"), format= "%d/%m/%Y")
axis(1, at=days, labels = c("Thy", "Fri", "Sat"))

dev.copy(png, file="Plot4.png", width=480, height=480, units="px")
dev.off()
