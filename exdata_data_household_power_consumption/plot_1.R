
data = read.table("C:/Users/ZJH_8/Desktop/exdata_data_household_power_consumption/household_power_consumption.txt",header= TRUE, sep = ";", 
                  stringsAsFactors=FALSE, dec=".")

## description of data
summary(data)

## select date
subdata = data[data$Date %in% c("1/2/2007", "2/2/2007"),]

## translate data into numeric
global_active_power = as.numeric(subdata$Global_active_power)
global_reactive_power = as.numeric(subdata$Global_reactive_power)
voltage  = as.numeric(subdata$Voltage)
global_intensity = as.numeric(subdata$Global_intensity)
sub_metering_1 = as.numeric(subdata$Sub_metering_1)

## create image
png(filename="plot1.png" )
hist(global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

dev.off()
