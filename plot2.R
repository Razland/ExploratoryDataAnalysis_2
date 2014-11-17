## File plot2.R Assignment 2 Exploratory Data Analysis November, 2014.
## Dave Kenny

## Plot the PM_2.5 totals for all sources for Baltimore City over each sample
## year using the basic plotting system.

source("loadData.R")                        ## Source the utility file that 
                                            ## downloads, unzips, and reads in
                                            ## the data as needed.
targFile="plot2.png"

Years <- unique(NEI$year)                   ## Read sample date-years
p2Data <- data.frame()                      ## Data structure for data subset

for( i in 1:length(Years)){                 ## Load years and total data into
  p2Data[i,1] <- Years[i]                   ## data structure.
  p2Data[i, 2] <- 
    sum(NEI[NEI$year==Years[i] 
            & NEI$fips=="24510", 
            4])
  }

colnames(p2Data) <- c("Year", "Total")      ## Add column labels.

par(pin=c(6, 4),                            ## Size of plot and
    lab=c(12, 4, 7),                        ## other aesthetics
    lwd=2,
    mar=c(4,5,4,2)) 
plot(p2Data$Year,                           ## Plot data
     p2Data$Total/1000, 
     type="l", 
     ylab="tons (x 1000)", 
     xlab="year", 
     main="FPM Annual Emissions\nfor Baltimore City")
dev.copy(png,                               ## Write plot to file
         width=600, 
         height=480, 
         file=targFile)  ## output to file
dev.off()                                   ## Close file.
rm(p2Data, Years, targFile, i)              ## Cleanup