library(dplyr)
library(lubridate)

raw <- read.csv(
    "household_power_consumption.txt", 
    sep = ";",
    header = TRUE, 
    na.strings = "?",
    colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

allData <- tbl_df(raw)

relevantData <- allData %>%
    mutate(Date = dmy(Date)) %>%
    filter(grepl("2007-02-(01|02)", Date))
   
png("plot1.png")
with(
    relevantData, 
    hist(Global_active_power, 
         main = "Global Activate Power",
         xlab = "Global Activate Power (kilowatts)",
         ylab = "Frequency",
         col = "red")
    )
dev.off()
