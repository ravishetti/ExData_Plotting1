# set working directory
setwd("C:/ravi/DataScience/rwd/EDA")

# required packages
library(data.table)
library(lubridate)

# check to see if the existing tidy data set exists; if not create it.
if (!file.exists('power_consumption.txt')) {
  # download the zip file and unzip
  file.url<-'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
  download.file(file.url,destfile='power_consumption.zip')
  unzip('power_consumption.zip',exdir='C:/ravi/DataScience/rwd/EDA',overwrite=TRUE)
  # read the raw table and read the days required for this assignment
  variable.class<-c(rep('character',2),rep('numeric',7))
  power.consumption<-read.table('household_power_consumption.txt',header=TRUE,sep=';',na.strings='?',colClasses=variable.class)
  power.consumption<-power.consumption[power.consumption$Date=='1/2/2007' | power.consumption$Date=='2/2/2007',]
  # clean up the variable names and convert date/time fields
  cols<-c('Date','Time','GlobalActivePower','GlobalReactivePower','Voltage','GlobalIntensity','SubMetering1','SubMetering2','SubMetering3')
  colnames(power.consumption)<-cols
  power.consumption$DateTime<-dmy(power.consumption$Date)+hms(power.consumption$Time)
  power.consumption<-power.consumption[,c(10,3:9)]
  # write a clean data set to the directory
  write.table(power.consumption,file='power_consumption.txt',sep='|',row.names=FALSE)
} else {
  power.consumption<-read.table('power_consumption.txt',header=TRUE,sep='|')
  power.consumption$DateTime<-as.POSIXlt(power.consumption$DateTime)
}
