## File plot4.R Assignment 2 Exploratory Data Analysis November, 2014.
## Dave Kenny

## Plot the PM_2.5 totals for coal sources over each sample year using the
## basic plotting system.
## Problem: the indicator that a particulate matter source is coal is buried in
## four different columns of the SCC data description.

source("loadData.R")  ## Source the utility file that downloads, unzips, and
                      ## reads in the data as needed.
targFile="plot4.png"
years <- unique(NEI$year)                   ## Sample date-years

coalObs <- sort( unique( c( as.numeric(     ## Build an index of SCC numbers
               array( SCC[(grepl("coal",    ## for observations that contain
                         SCC[,3],           ## some sort of reference to
                         ignore.case=TRUE)),## PM_2.5 coming from coal.
                         1])),
        as.numeric( array( SCC[( grepl( "coal", 
           SCC[,4],ignore.case=TRUE)), 1])),
        as.numeric( array(SCC[(grepl("coal", 
           SCC[,9],ignore.case=TRUE)),1])),
        as.numeric( array(SCC[(grepl("coal",
           SCC[,10],ignore.case=TRUE)),1])))))

getSum <-                                   ## Function to return the sum of
  function(y){                              ## sensor data for each year-group
    return(sum(NEI[NEI$year==y              ## and the Baltimore City zip code.
                 & NEI$SCC %in% coalObs, 4]))}

totals <- as.numeric(
  sapply(years, getSum)/1000)

par(pin = c(6, 4),lab=c(12, 4, 7),          ## Size of the plot and other
    lwd=2, mar=c(4,5,4,2))                  ## aesthetics

plot(data.frame(                            ## Draw plot using data frame made
     Year=years, Total=as.numeric(totals)), ## from years and the sum of each
     type="l", ylab="Tons (x 1000)",        ## sample year emissions.
     main="Coal Source FPM Emissions for USA")

dev.copy(png, width=600, height=480,        ## Print plot to file.
         file=targFile)

dev.off()                                   ## Close the file.

rm(years, totals, targFile, coalObs, getSum)## Clean up environment.