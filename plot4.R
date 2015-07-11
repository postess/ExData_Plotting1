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

## plot the four graphs from plot 4
png(file = "plot4.png", width = 480, height = 480)

par(mfrow = c(2,2), mar = rep(4,4), oma = c(4, 4, 0, 0))
with(energyDF, {
        plot(DateTime, Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")
        plot(DateTime, Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
        {
        plot(x = DateTime, y = Sub_metering_1, type = "l", ylab= "Energy sub metering", xlab = "")
                lines(DateTime, Sub_metering_2, col ="red")
                lines(DateTime, Sub_metering_3, col ="blue")
                legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), bty = "n", cex = .65)
}
        plot(DateTime, Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")
})

dev.off()
