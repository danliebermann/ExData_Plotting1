#Set working directory
setwd("/Users/danliebermann/Documents/Coursera/Exploratory Data Analysis")
#Read CSV file
powerData<-read.csv2("household_power_consumption.txt")
##Combine and convert dates, then add to dataframe
Date_time<-paste(powerData$Date, powerData$Time)
powerData<-cbind(powerData,Date_time)
#Convert Date column to dates, Convert Time colum to time, Convert Global Active Power to numeric
#Convert Date_Time to time, convert Submetering variables to numeric
powerData$Date<-as.Date(powerData$Date, "%d/%m/%Y")
powerData$Time<-strptime(powerData$Time, "%H:%M:%S")
powerData$Global_active_power<-as.numeric(as.character(powerData$Global_active_power))
powerData$Global_reactive_power<-as.numeric(as.character(powerData$Global_reactive_power))
powerData$Sub_metering_1<-as.numeric(as.character(powerData$Sub_metering_1))
powerData$Sub_metering_2<-as.numeric(as.character(powerData$Sub_metering_2))
powerData$Sub_metering_3<-as.numeric(as.character(powerData$Sub_metering_3))
powerData$Voltage<-as.numeric(as.character(powerData$Voltage))
powerData$Date_time<-strptime(powerData$Date_time, "%d/%m/%Y %H:%M:%S")
#Create dataframe for shorter timeframe
graphData<-subset(powerData, Date ==  "2007-02-01" | Date == "2007-02-02")
#Add weekdays to dataframe
Weekdays<-weekdays(graphData$Date)
graphData<-cbind(graphData,Weekdays)
#Create 480X480 PNG File
png(file = "Plot4.png", width = 480, height = 480)
#Plot graph
par(mfrow=c(2,2))
with(graphData, plot(Date_time, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"))
with(graphData, plot(Date_time, Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))
with(graphData, plot(Date_time, Sub_metering_1, type = "l", xlab = "", col = "black", ylab = "Energy sub metering"))
with(graphData, points(Date_time, Sub_metering_2, type = "l", xlab = "", col = "red", ylab = "Energy sub metering"))
with(graphData, points(Date_time, Sub_metering_3, type = "l", xlab = "", col = "blue", ylab = "Energy sub metering"))
axis(2, at = c(10,20,30))
legend("topright", lty = c(1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
with(graphData, plot(Date_time, Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power"))
dev.off()
