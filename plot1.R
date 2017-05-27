# get data
source('powerconsumption.R')

# open device
png(filename='plot1.png',width=480,height=480,units='px')

# plot data
hist(power.consumption$GlobalActivePower,main='Global Active Power',xlab='Global Active Power (kilowatts)',col='red')

# close device
x<-dev.off()
