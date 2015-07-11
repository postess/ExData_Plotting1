par(mfrow = c(2,2), mar = rep(4,4), oma = c(4, 4, 0, 0))
with(energyDF, {
        plot(DateTime, Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")
        plot(DateTime, Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
        {
        plot(x = DateTime, y = Sub_metering_1, type = "l", ylab= "Energy sub metering", xlab = "")
                lines(DateTime, Sub_metering_2, col ="red")
                lines(DateTime, Sub_metering_3, col ="blue")
                legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), bty = "n", cex = .35)
}
        plot(DateTime, Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")
})