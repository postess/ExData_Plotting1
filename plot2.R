## load data only for February 1 & 2, 2007
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destination <-"./data/household_power_consumption.zip"
download.file(url, destination, method = "curl")
energyDF <- read.table(unz(destination, "household_power_consumption.txt"), sep = ";", na.strings = "?", skip = 66637, nrows = 2880)
## from Astrego on How to read zipped data from the Coursera discussion forum thread

## skipped headers when loading, so add back column header names
colHeadings <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
colnames(energyDF) <- colHeadings

## change date and time classes and create one DateTime column
library(lubridate)
dt <- paste(energyDF$Date, energyDF$Time, sep = " ")
dtCol <- dmy_hms(dt)

energyDF$DateTime <- dtCol

## Plot 2 global active power by minute between February 1 and 2, 2007
plot2 <- with(energyDF, (plot(DateTime, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")))

## save as PNG
dev.copy(png, file = "plot2.png")
dev.off()
