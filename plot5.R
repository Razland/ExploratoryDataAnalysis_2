## File plot5.R Assignment 2 Exploratory Data Analysis November, 2014.
## Dave Kenny

## Plot the PM_2.5 totals for motor vehicle sources in Baltimore City over each
## sample year using the basic plotting system.

source("loadData.R")  ## Source the utility file that downloads, unzips, and
                      ## reads in the data as needed.
targFile="plot5.png"
roadIndex <-                                ## Build an index of automotive 
  sort(                                     ## SCC numbers using on and off-
    unique(                                 ## road sources from Data.Category.
      SCC[grepl("road", 
                SCC$Data.Category, 
                ignore.case=TRUE), 
          1]))

Years <- unique(NEI$year)                   ## Sample years
p5Data <- data.frame()                      ## Small storage structure for 
                                            ## a subset of the data
for( i in 1:length(Years)){           
  p5Data[i,1] <- Years[i]                   ## Load sample-dates into frame c1.
  p5Data[i, 2] <-                           ## Load Baltimore totals by year,
    sum(NEI[NEI$fips=="24510"               ## using the roadIndex to determine
           & NEI$SCC %in% roadIndex         ## automotive sources.
           & NEI$year == Years[i], 
           4])
  }
colnames(p5Data) <- c("Year", "Total")      ## Name the data frame columns

par(pin = c(6, 4),                          ## Size of plot and
    lab=c(12, 4, 7),                        ## other aesthetics
    lwd=2,
    mar=c(4,5,4,2)) 
plot(p5Data$Year,                           ## Line plot data
     p5Data$Total, 
     type="l", 
     ylab="tons", 
     xlab="year", 
     main="Motor Vehicle Emissions\nfor Baltimore City")
dev.copy(png,                               ## Write plot to file.
         width=600, 
         height=480, 
         file=targFile)
dev.off()                                   ## Close output device.
rm(p5Data, Years, targFile, i)              ## Clean up environment.