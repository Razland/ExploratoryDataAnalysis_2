## File plot5.R Assignment 2 Exploratory Data Analysis November, 2014.
## Dave Kenny

## Plot the PM_2.5 totals for motor vehicle sources in Baltimore City over each
## sample year using the basic plotting system.

source("loadData.R")  ## Source the utility file that downloads, unzips, and
                      ## reads in the data as needed.
targFile="plot5.png"
roadIndex <- sort(unique(SCC[grepl("road", SCC$Data.Category, ignore.case=TRUE), 1]))

Years <- unique(NEI$year)  ## sample years
p5Data <- data.frame()     ## small storage structure for subset of data
for( i in 1:length(Years)){                       ## load in data and 
  p5Data[i,1] <- Years[i]
  p5Data[i, 2] <- sum(NEI[NEI$fips=="24510" & 
                          NEI$SCC %in% roadIndex &
                          NEI$year == Years[i], 
                          4])
  
  }
colnames(p5Data) <- c("Year", "Total")

par(pin = c(6, 4),                                     ## Size of plot and
    lab=c(12, 4, 7),                                   ## other aesthetics
    lwd=2,
    mar=c(4,5,4,2)) 
plot(p5Data$Year,                                      ## Plot
     p5Data$Total, 
     type="l", 
     ylab="tons", 
     xlab="year", 
     main="Motor Vehicle Emissions \nfor Baltimore City")
dev.copy(png, width=600, height=480, file = targFile)  ## output to file
dev.off()
rm(p5Data, Years, targFile, i)  ## cleanup