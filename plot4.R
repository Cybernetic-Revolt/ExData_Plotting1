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
png("plot4.png", width=480, height=480)

##Adjust the margins and make space for 4 chars
par(mar=c(4,4,2,2),mfrow = c(2,2))

## Start Plotting all the charts
with(mydata, {
     ##Chart Plot 1 - Top left
     plot(mydata$Time,mydata$Global_active_power, ylab="Global Active Power", xlab="", type='l')         
     ##Chart Plot 2 - Top Right
     plot(mydata$Time,mydata$Voltage, ylab="Voltage", xlab="datetime", type='s', col="black")  
     ##Chart Plot 3 - Bottom Left
     plot(mydata$Time,mydata$Sub_metering_1, ylab="Energy Sub metering", xlab="", type='s', col="black")  
     lines(mydata$Time,mydata$Sub_metering_2, type='s', col="red")
     lines(mydata$Time,mydata$Sub_metering_3, type='s', col="blue")
     legend("topright", lwd=1, 
            col=c("black", "red", "blue"), 
            legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n", cex=0.7)
     ##Chart Plot 4 - Bottom Right
     plot(mydata$Time,mydata$Global_reactive_power, ylab="Global_reactive_power ", xlab="datetime", type='l')       
  
     
})


## Close the device
dev.off()
