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
   
#6. create chart
   png(file="plot1.png",width=480,height=480)
   hist(power$Global_active_power, col = "red", main = "Global Active Power",xlab = "Global Active Power (kilowatts)")
   dev.off()