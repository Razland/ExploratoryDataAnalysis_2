#! /usr/bin/R -f
## File plot1.R Assignment 2 Exploratory Data Analysis November, 2014.
## Dave Kenny

## Plot the PM_2.5 totals for all sources over each sample year using the
## basic plotting system.

source("loadData.R")                        ## Source the utility file that
                                            ## downloads, unzips, and reads in
                                            ## the data as needed.
targFile="plot1.png"

getSum <-                                   ## Function to return the sum
  function(y){                              ## for each year-group of sensor
    return(sum(NEI[NEI$year==y, 4]))}       ## data

plotTitle <- paste0("Fine Particulate Matter",
                    "\nAnnual Emissions")
years <- unique(NEI$year)                   ## Load sample date-years
totals <- as.numeric(
            sapply(
              years, getSum)/1000)

par(pin = c(6, 4),lab=c(12, 4, 7),          ## Size of the plot and other
    lwd=2, mar=c(4,5,4,2))                  ## aesthetics

plot(                                       ## Draw plot using data frame made
     data.frame(                            ## from years and the sum of each
        Year=years,                         ## sample year emissions.
        Total=as.numeric(totals)),
     type="l", 
     ylab="Tons (x 1000)", 
     main=plotTitle)

dev.copy(png,                               ## Write to file 
         width=600, 
         height=480, 
         file=targFile)

dev.off()                                   ## Close the file

rm(years, totals, targFile, getSum )        ## Clean up environment