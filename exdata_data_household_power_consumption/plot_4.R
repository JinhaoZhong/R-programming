data = read.table("C:/Users/ZJH_8/Desktop/exdata_data_household_power_consumption/household_power_consumption.txt",header= TRUE, sep = ";", 
                  stringsAsFactors=FALSE, dec=".")

## select date
subdata = data[data$Date %in% c("1/2/2007", "2/2/2007"),]

## translate data into numeric
global_active_power = as.numeric(subdata$Global_active_power)
global_reactive_power = as.numeric(subdata$Global_reactive_power)
voltage  = as.numeric(subdata$Voltage)
global_intensity = as.numeric(subdata$Global_intensity)
sub_metering_1 = as.numeric(subdata$Sub_metering_1)
sub_metering_2 = as.numeric(subdata$Sub_metering_2)
sub_metering_3 = as.numeric(subdata$Sub_metering_3)



## create image
png(filename="plot4.png" )
par(mfrow = c(2, 2)) 

# First plot
plot(datetime, global_active_power, type="l", xlab="", ylab="Global Active Power")

# Second plot
plot(datetime, voltage, type="l", xlab="datetime", ylab="Voltage")

# Third plot
plot(datetime, sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, sub_metering_2, type="l", col="red")
lines(datetime, sub_metering_3, type="l", col="blue")
legend("topright", c("sub_metering_1", "sub_metering_2", "sub_metering_3"), lty=, lwd=2, col=c("black", "red", "blue"), bty="o")

# Fourth plot
plot(datetime, global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power",)
dev.off()