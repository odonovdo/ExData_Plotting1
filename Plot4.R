if(!file.exists(a <- "household_power_consumption.txt")){
      
      URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      
      temp <- tempfile()
      download.file(URL,temp)
      
      HousePower1 <- read.table(unzip(temp,a),header = TRUE,sep = ";")
}else{
      HousePower1 <- read.table(a,header = TRUE,sep = ";")
}

CleanFormate <- function(x){
      x$Date <- as.Date(x$Date,format = "%d/%m/%Y")
      x$Time <- strptime(paste(x$Date,x$Time),format = "%Y-%m-%d %H:%M:%S")
      y <- x[ x$Date >= as.Date("2007-02-01") & x$Date <= as.Date("2007-02-02"),] 
      y[,c(3:8)] <- lapply(y[,c(3:8)],function(x)as.numeric(as.character(x)))
      y
}
DataHouse <- CleanFormate(HousePower1)

png(filename = "plot4.png",width = 480, height = 480,units = "px")
par(mfrow =c(2,2))

plot(y=DataHouse$Global_active_power,x=DataHouse$Time,type = "l",xlab = "",ylab = "Global Active Power (kilowatts)")

plot(y=DataHouse$Voltage,x=DataHouse$Time,type = "l",xlab = "Datetime",ylab = "Voltage")

plot(DataHouse$Time,DataHouse$Sub_metering_1,type = "n",xlab = "",ylab = "Energy sub metering")
points(DataHouse$Time,DataHouse$Sub_metering_1,type="l",col="black")
points(DataHouse$Time,DataHouse$Sub_metering_2,type="l",col="red")
points(DataHouse$Time,DataHouse$Sub_metering_3,type="l",col="blue")
legend("topright",c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), lty = c(1),col=c("black","red","blue"),cex = 0.75,bty = "n")

plot(y=DataHouse$Global_reactive_power,x=DataHouse$Time,type = "l",xlab = "Datetime",ylab = "Global_reactive_power")

dev.off()




