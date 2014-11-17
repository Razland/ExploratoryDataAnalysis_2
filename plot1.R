## File plot1.R Assignment 2 Exploratory Data Analysis November, 2014.
## Dave Kenny

## Plot the PM_2.5 totals for all sources over each sample year using the
## basic plotting system.

source("loadData.R")  ## Source the utility file that downloads, unzips, and
## reads in the data as needed.
targFile="plot1.png"

Years <- unique(NEI$year)  ## sample years
p1Data <- data.frame()     ## small storage structure for subset of data
for( i in 1:length(Years)){                            ## load in data and 
  p1Data[i,1] <- Years[i]
  p1Data[i, 2] <- sum(NEI[NEI$year==Years[i], 4])      ## Get the NEI totals 
  }

colnames(p1Data) <- c("Year", "Total")
par(pin = c(6, 4),                                     ## Size of plot and 
    lab=c(12, 4, 7),                                   ## other aesthetics
    lwd=2,
    mar=c(4,5,4,2)) 
plot(p1Data$Year,                                      ## Plot
     p1Data$Total/1000, 
     type="l", 
     ylab="tons (x 1000)", 
     xlab="year", 
     main="Fine Particulate Matter Annual Emissions")
dev.copy(png, width=600, height=480, file = targFile)  ## output to file
dev.off()
rm(p1Data, Years, targFile, i)                         ## Cleanup