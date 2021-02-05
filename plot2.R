# download and unzip original file
original_file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(original_file_url, "compressed_input_file.zip")
unzip("compressed_input_file.zip")
file_name = "household_power_consumption.txt"

# all lines from the .csv are read, separator is ";"
my_df <- read.csv(file_name, sep=";")
my_df_original <- my_df

# date column is converted as R date. Then only rows where the month is 02 (= February) are kept
my_df$Date_full <- strptime(paste(my_df$Date, my_df$Time), "%d/%m/%Y %H:%M:%S")
#my_df$Date <- strptime(my_df$Date, "%d/%m/%Y" )
my_df <- my_df[as.Date(my_df$Date_full) >= as.Date("2007-02-01") & as.Date(my_df$Date_full) <= as.Date("2007-02-02"),]

# format fixing, everything is converted to numeric for third to ninth column
my_df[,3:9] <- sapply(my_df[,3:9], as.numeric)


# second plot
png("plot2.png")
plot(my_df$Date_full, my_df$Global_active_power, type="S", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
