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
   
png("plot2.png")
with(
    relevantData, 
    plot(
        DateTime, Global_active_power, 
        xlab = "", 
        ylab = "Global Active Power (kilowatts)", 
        type = "l")
    )
dev.off()
