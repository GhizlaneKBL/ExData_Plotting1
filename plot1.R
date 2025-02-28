# 1- Download and load the dataset:
setwd("C:/Users/dell/OneDrive/Bureau/Coursera/Johns_Hopkins_university/C4_Exploratory Data Analysis/Semaine 1/Course_Project/ExData_Plotting1")
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

#Plot1
hist(data2$Global_active_power, col="red", xlab ="Global Active Power (Kilowatts)", main="Global Active Power")
dev.copy(png, file="Plot1.png", width=480, height=480, units="px")
dev.off()