#Set working directory
setwd("/Users/danliebermann/Documents/Coursera/Exploratory Data Analysis")
#Read CSV file
powerData<-read.csv2("household_power_consumption.txt")
##Combine and convert dates, then add to dataframe
Date_time<-paste(powerData$Date, powerData$Time)
powerData<-cbind(powerData,Date_time)
#Convert Date column to dates, Convert Time colum to time, Convert Global Active Power to numeric
#Convert Date_Time to time
powerData$Date<-as.Date(powerData$Date, "%d/%m/%Y")
powerData$Time<-strptime(powerData$Time, "%H:%M:%S")
powerData$Global_active_power<-as.numeric(as.character(powerData$Global_active_power))
powerData$Date_time<-strptime(powerData$Date_time, "%d/%m/%Y %H:%M:%S")
#Create dataframe for shorter timeframe
graphData<-subset(powerData, Date ==  "2007-02-01" | Date == "2007-02-02")
#Add weekdays to dataframe
Weekdays<-weekdays(graphData$Date)
graphData<-cbind(graphData,Weekdays)
#Create 480X480 PNG File
png(file = "Plot2.png", width = 480, height = 480)
#Plot graph
with(graphData, plot(Date_time, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()
