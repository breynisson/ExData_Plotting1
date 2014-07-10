####################################################################
# Getting and cleaning Data
####################################################################

hpc<-read.table("household_power_consumption.txt", sep=";" , header=TRUE, na.strings="?")

# Convert Date column to Date-type:
hpc$Date<-as.Date(as.character(hpc$Date), "%d/%m/%Y")

first_date<-as.Date("2007-02-01")
hpc_fd<-hpc$Date==first_date
second_date<-as.Date("2007-02-02")
hpc_sd<-hpc$Date==second_date

date_values_first<-hpc[hpc_fd,]
date_values_second<-hpc[hpc_sd,]

# Date for plotting.
project_data<-rbind(date_values_first, date_values_second)

# Find classes of the data
cl<-lapply(project_data, class)

library("chron")
t<-times(as.character(project_data$Time))

project_data$Time<-t

# Remove temp variables
rm(hpc)
rm(hpc_fd)
rm(hpc_sd)
rm(date_values_first)
rm(date_values_second)
rm(first_date)
rm(second_date)
rm(t)



####################################################################
# Plotting
####################################################################
png("plot4.png")
par(mfcol=c(2,2))
plot(project_data$Global_active_power, type="l", ylab="Global Active Power", main="", xlab="", xaxt="n")
axis(1, at=c(1,1441,2882),labels=c("Thu", "Fri","Sat"))

plot(project_data$Sub_metering_1, ylab="Energy sub metering", main="", xlab="", xaxt="n", type="n")
axis(1, at=c(1,1441,2882),labels=c("Thu", "Fri","Sat"))
points(project_data$Sub_metering_1, type="l")
points(project_data$Sub_metering_2, type="l", col="red")
points(project_data$Sub_metering_3, type="l", col="blue")
legend("topright", lwd=1, col=c("black","red","blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(project_data$Voltage, type="l", ylab="Voltage", main="", xlab="datetime", xaxt="n")
axis(1, at=c(1,1441,2882),labels=c("Thu", "Fri","Sat"))

with(project_data, plot(Global_reactive_power, type="l", main="", xlab="datetime", xaxt="n"))
axis(1, at=c(1,1441,2882),labels=c("Thu", "Fri","Sat"))
dev.off()


