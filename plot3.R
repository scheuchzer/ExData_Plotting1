library(dplyr)
library(lubridate)

raw <- read.csv(
    "household_power_consumption.txt", 
    sep = ";",
    header = TRUE, 
    na.strings = "?",
    stringsAsFactors = FALSE,
    colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

allData <- tbl_df(raw)

relevantData <- allData %>%
    mutate(DateTime = dmy_hms(paste(Date,  Time))) %>%
    filter(grepl("2007-02-(01|02)", DateTime))
   
png("plot3.png")
with(
    relevantData, {
        plot(
            DateTime, Sub_metering_1, 
            xlab = "", 
            ylab = "Energy sub metering", 
            type = "n")
        lines(DateTime, Sub_metering_1)
        lines(DateTime, Sub_metering_2, col = "red")
        lines(DateTime, Sub_metering_3, col = "blue")
        legend("topright", 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               col = c("black", "red", "blue"),
               lty = 1
               )
    })

dev.off()
