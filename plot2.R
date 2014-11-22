## File plot2.R Assignment 2 Exploratory Data Analysis November, 2014.
## Dave Kenny

## Plot the PM_2.5 totals for all sources for Baltimore City over each sample
## year using the basic plotting system.

source("loadData.R")                        ## Source the utility file that 
                                            ## downloads, unzips, and reads in
                                            ## the data as needed.
targFile="plot2.png"
zipCode <- "24510"                          ## Zip code

getSum <-                                   ## Function to return the sum
  function(y){                              ## of sensor data for each year-
    return(sum(NEI[NEI$year==y              ## group and the Baltimore City zip
                & NEI$fips==zipCode, 4]))}  ## code

years <- unique(NEI$year)                   ## Load sample date-years
totals <- as.numeric(
  sapply(years, getSum)/1000)

par(pin = c(6, 4),lab=c(12, 4, 7),          ## Size of the plot and other
    lwd=2, mar=c(4,5,4,2))                  ## aesthetics

plot(                                       ## Draw plot using data frame made
  data.frame(                               ## from years and the sum of each
    Year=years, Total=as.numeric(totals)),  ## sample year emissions.
  type="l", ylab="Tons (x 1000)",
  main=paste0("FPM Annual Emissions",
              "\nfor Baltimore City"))

dev.copy(png, width=600, height=480,        ## Write plot to file
         file=targFile)                    

dev.off()                                   ## Close file.

rm(years, totals, targFile, getSum)         ## Cleanup