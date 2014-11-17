## File plot4.R Assignment 2 Exploratory Data Analysis November, 2014.
## Dave Kenny

## Plot the PM_2.5 totals for coal sources over each sample year using the
## basic plotting system.

source("loadData.R")  ## Source the utility file that downloads, unzips, and
                      ## reads in the data as needed.

targFile="plot4.png"
## Problem: the indicator that a particulate matter source is coal is buried
## in four different columns of the SCC data description.
coalObs<- sort(unique(                            ## Build a vector of SCC 
                   c(as.numeric(                  ## numbers dealing with coal
                         array(SCC[(grepl("coal",
                                          SCC[,3], 
                                          ignore.case=TRUE )),1])),
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


Years <- unique(NEI$year)  ## sample years
p4Data <- data.frame()     ## small storage structure for subset of data
for( i in 1:length(Years)){                       ## load in data and 
  p4Data[i,1] <- Years[i]
  p4Data[i, 2] <- sum(NEI[NEI$year==Years[i] &    ## Get only the NEI totals
                            NEI$SCC %in% coalObs, ## for SCC source is coal
                          4])                     
  }
colnames(p4Data) <- c("Year", "Total")

par(pin = c(6, 4),                                     ## Size of plot and
    lab=c(12, 4, 7),                                   ## other aesthetics
    lwd=2,
    mar=c(4,5,4,2)) 
plot(p4Data$Year,                                      ## Plot
     p4Data$Total/1000, 
     type="l", 
     ylab="tons (x 1000)", 
     xlab="year", 
     main="Coal Source FPM Emissions for USA")
dev.copy(png, width=600, height=480, file = targFile)  ## output to file
dev.off()
rm(p4Data, Years, targFile, i, coalObs)  ## cleanup