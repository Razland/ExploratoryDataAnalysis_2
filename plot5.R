## File plot5.R Assignment 2 Exploratory Data Analysis November, 2014.
## Dave Kenny

## Plot the PM_2.5 totals for motor vehicle sources in Baltimore City over each
## sample year using the basic plotting system.

source("loadData.R")  ## Source the utility file that downloads, unzips, and
                      ## reads in the data as needed.
targFile="plot5.png"
years <- unique(NEI$year)                   ## Load sample date-years
zipCode <- "24510"                          ## Zip code
plotTitle <- paste0("Motor Vehicle",
                    "Emissions\nfor",
                    "Baltimore City")

getSum <-                                   ## Function to return the sum of
  function(y){                              ## sensor data for each year-group
                                            ## and the Baltimore City zip code.
    roadIndex <- sort( unique(              ## Build an index of automotive 
      SCC[grepl("road", SCC$Data.Category,  ## SCC numbers using on and off-
                ignore.case=TRUE),  1]))    ## road sources from Data.Category.
    return( sum( NEI[     
                     NEI$year==y 
                   & NEI$fips==zipCode 
                   & NEI$SCC %in% roadIndex,
                   4]))}

totals <- as.numeric(
  sapply(years, getSum)/1000)

par(pin = c(6, 4),lab=c(12, 4, 7),          ## Size of the plot and other
    lwd=2, mar=c(4,5,4,2))                  ## aesthetics

plot(data.frame(                            ## Draw plot using data frame made
  Year=years, Total=as.numeric(totals)),    ## from years and the sum of each
  type="l", ylab="Tons",                    ## sample year emissions.
  main=plotTitle)

dev.copy(png, width=600, height=480,        ## Write plot to file.
         file=targFile)

dev.off()                                   ## Close output device.
rm(years, targFile, zipCode, totals,        ## Clean up environment.
   plotTitle, getSum)