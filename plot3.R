##
##  Filename: plot3.R
##  Purpose: Plot 3 of Project 1 in the course 'Exploratory Data Analysis' 
##  Author: Jennting Timothy Hsu
##  Last Modified:  July 12, 2014
##  Version:      1.0
##
##  Dataset:
##      Electric power consumption 
##      (https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip) [20Mb]
##  Description:  
##      Measurements of electric power consumption in one household with a one-minute sampling rate over a period of almost 4 years. 
##      Different electrical quantities and some sub- metering values are available.
##
##  The following descriptions of the 9 variables in the dataset are taken from the UCI web site 
##  (https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption):
##      1. Date: Date in format dd/mm/yyyy
##      2. Time: time in format hh:mm:ss
##      3. Global_active_power: household global minute-averaged active power (in kilowatt)
##      4. Global_reactive_power: household global minute-averaged reactive power (in kilowatt) 
##      5. Voltage: minute-averaged voltage (in volt)
##      6. Global_intensity: household global minute-averaged current intensity (in ampere)
##      7. Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). 
##          It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
##      8. Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). 
##          It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
##      9. Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). 
##          It corresponds to an electric water-heater and an air-conditioner.
##  Loading the data:
##    When loading the dataset into R, please consider the following:
##      * The dataset has 2,075,259 rows and 9 columns. 
##        First calculate a rough estimate of how much memory the dataset will require in memory before reading into R. 
##        Make sure your computer has enough memory (most modern computers should be fine).
##      * We will only be using data from the dates 2007-02-01 and 2007-02-02. 
##        One alternative is to read the data from just those dates rather than reading in the entire dataset and subsetting to those dates.
##      * You may find it useful to convert the Date and Time variables to Date/Time classes in R using the strptime() and as.Date() functions.
##      * Note that in this dataset missing values are coded as ? .
##  Making Plots:
##    Our overall goal here is simply to examine how household energy usage varies over a 2-day period in February, 2007. 
##    Your task is to reconstruct the following plots below, all of which were constructed using the base plotting system.
##
##    First you will need to fork and clone the following GitHub repository: 
##    https://github.com/rdpeng/ExData_Plotting1 (https://github.com/rdpeng/ExData_Plotting1)
##
##    For each plot you should
##      * Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels. 
##      * Name each of the plot files as plot1.png , plot2.png , etc.
##      * Create a separate R code file ( plot1.R , plot2.R , etc.) that constructs the corresponding plot, i.e. code in plot1.R constructs the plot1.png plot. 
##        Your code file should include code for reading the data so that the plot can be fully reproduced. 
##        You should also include the code that creates the PNG file.
##      * Add the PNG file and R code file to your git repository
##
##    When you are finished with the assignment, push your git repository to GitHub so that the GitHub version of your repository is up to date. 
##    There should be four PNG files and four R code files.
##

library(datasets)
library(data.table)

if (!file.exists("Data")){
  dir.create("Data")
}

fileUrl <- "https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption"
download.file(fileUrl, destfile = "./Data/household_power_consumption.txt", method = "curl")
# list.files("./Data")

data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
data_subset <- data[data.matrix(data$Date) == "1/2/2007" | data.matrix(data$Date) == "2/2/2007" , ]

# data_gap <- as.numeric(data.matrix(data_subset$Global_active_power))  # Extract column of 'Global Active Power'
data_sub_metering_1 <- as.numeric(data.matrix(data_subset$Sub_metering_1))  # Extract column of 'Sub-metering_1'
data_sub_metering_2 <- as.numeric(data.matrix(data_subset$Sub_metering_2))  # Extract column of 'Sub-metering_2'
data_sub_metering_3 <- as.numeric(data.matrix(data_subset$Sub_metering_3))  # Extract column of 'Sub-metering_3'
# data_date <- data.matrix(data_subset$Date)                            # Extract column of 'Date'

#--- Plot 3 ---
png(filename = "plot3.png", height = 480, width = 480, bg = "white")

g_range <- range(0, data_sub_metering_1, data_sub_metering_2, data_sub_metering_3)  # Calculate range from 0 to max value of above three sub meterings

plot(data_sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", 
     xaxt = 'n', col = "black", ylim = g_range)
par(new = TRUE)
plot(data_sub_metering_2, type = "l", xlab = "", ylab = "", 
     xaxt = 'n', col = "red", ylim = g_range)
par(new = TRUE)
plot(data_sub_metering_3, type = "l", xlab = "", ylab = "", 
     xaxt = 'n', col = "blue", ylim = g_range)

axis(1, tick = TRUE, 
     at = c(1, nrow(data[data.matrix(data$Date) == "1/2/2007", ])+1, nrow(data_subset)), 
     lab = c("Thu", "Fri", "Sat"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"),
       cex = 0.9, lty = 1)

dev.off()

