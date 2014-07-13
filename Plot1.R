#Set working directory
setwd("/Users/danliebermann/Documents/Coursera/Exploratory Data Analysis")
#Read CSV file
powerData<-read.csv2("household_power_consumption.txt")
#Convert Date column to dates, Convert Time colum to time, Convert Global Active Power to numeric
powerData$Date<-as.Date(powerData$Date, "%d/%m/%Y")
powerData$Time<-strptime(powerData$Time, "%H:%M:%S")
powerData$Global_active_power<-as.numeric(as.character(powerData$Global_active_power))
#Create dataframe for shorter timeframe
graphData<-subset(powerData, Date ==  "2007-02-01" | Date == "2007-02-02")
#Create 480X480 PNG File
png(file = "Plot1.png", width = 480, height = 480)
#Plot graph
hist(graphData$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
axis(2, at = c(200,400,600,800,1000,1200))
dev.off()
