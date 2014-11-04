##Set the working Directory
setwd("D:/R")

## Read the file household_power_consumtion.txt and load it into variable mydata
mydata = read.table("household_power_consumption.txt", sep=";", header=TRUE, na.string="?", stringsAsFactors = FALSE, )

## Convert the Date field to a date.
mydata$Date <- as.Date(mydata$Date, format="%d/%m/%Y")

## subset the data to only include the desired dates
mydata <- mydata[which(mydata$Date == '2007-02-01' | mydata$Date == '2007-02-02'),]

##Open the device
png("plot1.png", width=480, height=480)

##Adjust the margins
par(mar=c(5,3,2,1))

##Now create a histogram chart
hist(mydata$Global_active_power, col="Red", xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power")

## Close the device
dev.off()
