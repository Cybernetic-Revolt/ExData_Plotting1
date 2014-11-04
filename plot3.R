##Set the working Directory
setwd("D:/R")

## Read the file household_power_consumtion.txt and load it into variable mydata
mydata = read.table("household_power_consumption.txt", sep=";", header=TRUE, na.string="?", stringsAsFactors = FALSE, )

## Convert the Date field to a date.
mydata$Date <- as.Date(mydata$Date, format="%d/%m/%Y")

## subset the data to only include the desired dates
mydata <- mydata[which(mydata$Date == '2007-02-01' | mydata$Date == '2007-02-02'),]

## Add the date field to the Time field
mydata$Time <- paste(mydata$Date, mydata$Time, sep = " ")

## Convert to PSIXlt
mydata$Time <- strptime(mydata$Time, "%Y-%m-%d %H:%M:%S")

##Open the device
png("plot3.png", width=480, height=480)

##Adjust the margins
par(mar=c(5,5,4,4))

##Create a plot 
plot(mydata$Time,mydata$Sub_metering_1, ylab="Energy Sub metering", xlab="", type='s', col="black")
lines(mydata$Time,mydata$Sub_metering_2, type='s', col="red")
lines(mydata$Time,mydata$Sub_metering_3, type='s', col="blue")

##Add the legend
legend("topright", lwd=1, cex=1, 
       col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Close the device
dev.off()

type = "l",