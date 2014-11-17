## File plot4.R Assignment 2 Exploratory Data Analysis November, 2014.
## Dave Kenny

## Plot the PM_2.5 totals for coal sources over each sample year using the
## basic plotting system.

source("loadData.R")  ## Source the utility file that downloads, unzips, and
                      ## reads in the data as needed.

targFile="plot4.png"
## Problem: the indicator that a particulate matter source is coal is buried
## in four different columns of the SCC data description.

coalObs<-                                   ## Build an index of SCC numbers 
  sort(                                     ## for observations that contain
    unique(                                 ## some sort of reference to  
      c(                                    ## PM_2.5 coming from coal.
        as.numeric(                  
          array(SCC[(grepl("coal",
                    SCC[,3], 
                    ignore.case=TRUE )),
                    1])),
        as.numeric(
          array(SCC[(grepl("coal",
                    SCC[,4], 
                    ignore.case=TRUE)),1])),
        as.numeric(
          array(SCC[(grepl("coal",
                    SCC[,9], 
                    ignore.case=TRUE)),1])),
        as.numeric(
          array(SCC[(grepl("coal",
                    SCC[,10], 
                    ignore.case=TRUE)),1]))
        )
      )
    )

Years <- unique(NEI$year)                   ## Sample date-years
p4Data <- data.frame()                      ## Small data storage structure for
                                            ## a subset of the data
for( i in 1:length(Years)){                 
  p4Data[i,1] <- Years[i]                   ## Load years to data frame.
  p4Data[i, 2] <-                           ## Get only the NEI totals for the
    sum(NEI[NEI$year==Years[i]              ## SCC source index of coal sources
           & NEI$SCC %in% coalObs,
           4])                     
  }
colnames(p4Data) <- c("Year", "Total")      ## Name the columns.

par(pin = c(6, 4),                          ## Size of the plot and
    lab=c(12, 4, 7),                        ## other aesthetics
    lwd=2,
    mar=c(4,5,4,2)) 
plot(p4Data$Year,                           ## Draw the plot
     p4Data$Total/1000, 
     type="l", 
     ylab="tons (x 1000)", 
     xlab="year", 
     main="Coal Source FPM Emissions for USA")
dev.copy(png,                               ## Print plot to file.
         width=600, 
         height=480, 
         file=targFile)  
dev.off()                                   ## Close the file
rm(p4Data, Years, targFile, i, coalObs)     ## Clean up environment.