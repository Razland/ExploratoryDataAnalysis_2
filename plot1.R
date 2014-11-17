## File plot1.R Assignment 2 Exploratory Data Analysis November, 2014.
## Dave Kenny

## Plot the PM_2.5 totals for all sources over each sample year using the
## basic plotting system.

source("loadData.R")                        ## Source the utility file that
                                            ## downloads, unzips, and reads in
                                            ## the data as needed.
targFile="plot1.png"

Years <- unique(NEI$year)                   ## Load sample date-years
p1Data <- data.frame()                      ## Data structure for data subset
for( i in 1:length(Years)){                 ## Load in sample dates data and 
  p1Data[i,1] <- Years[i]                   ## the total emissions.
  p1Data[i, 2] <- 
    sum(NEI[NEI$year==Years[i], 
            4])       
  }

colnames(p1Data) <- c("Year", "Total")      ## Add names to data columns
par(pin=c(6, 4),                            ## Size of plot and 
    lab=c(12, 4, 7),                        ## other aesthetics
    lwd=2,
    mar=c(4,5,4,2)) 
plot(p1Data$Year,                           ## Draw the plot
     p1Data$Total/1000, 
     type="l", 
     ylab="tons (x 1000)", 
     xlab="year", 
     main="Fine Particulate Matter\nAnnual Emissions")
dev.copy(png,                               ## Write to file 
         width=600, 
         height=480, 
         file=targFile)
dev.off()                                   ## Close the file
rm(p1Data, Years, targFile, i)              ## Clean up environment