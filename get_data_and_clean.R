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