#1. load package(s) into R
   library(tidyverse)
   library(lubridate)

#2. download and unzip file(s) to local directory
   power_url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
   download.file(power_url,"power.zip")
   unzip("power.zip")
   power_txt <- "household_power_consumption.txt"
   
#3. upload the file to R
   power <- read_delim(power_txt, delim= ";", na = "?")

#4. clean up date format
   power$Date <- dmy(power$Date)
   power$DateTime <- ymd_hms(paste(power$Date, power$Time))
   select (power, DateTime, everything())
   
#5. filter on required dates
   power <- filter(power, Date >= "2007-02-01" & Date <= "2007-02-02")

#6a. create charting environment
   par(mfrow=c(2,2), pin = c(2,1.5))
   
#6b. create chart #1
   plot(power$DateTime,power$Global_active_power,
        type = "l",
        xlab = "",
        ylab = "Global Active Power (kilowatts)")

#6b. create chart #2
   plot(power$DateTime,power$Voltage,
        type = "l",
        xlab = "datetime",
        ylab = "Voltage")
     
#6c.  create chart#3
   plot(power$DateTime, power$Sub_metering_1,
        type = "l",
        xlab = "",
        ylab = "Energy sub metering",
        col = "black")
   lines(power$DateTime, power$Sub_metering_2,
         type = "l",
         col = "red")
   lines(power$DateTime, power$Sub_metering_3,
         type = "l",
         col = "blue")
   legend('topright',
          legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
          col=c("black","red", "blue"),
          lty =c(1,1,1),
          ncol=1)
   
#6b. create chart #4
   plot(power$DateTime,power$Global_reactive_power,
        type = "l",
        xlab = "datetime",
        ylab = "Global_reactive_power")

#6e. save charts
   dev.copy(png,'plot4.png')
   dev.off()
   
   