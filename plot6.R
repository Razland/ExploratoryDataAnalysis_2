## File plot6.R Assignment 2 Exploratory Data Analysis November, 2014.
## Dave Kenny

## Plot the PM_2.5 totals for motor vehicle sources in Baltimore City and 
## Los Angeles over each sample year using the ggplot2 plotting system.

source("loadData.R")  ## Source the utility file that downloads, unzips, and
                      ## reads in the data as needed.
targFile="plot6.png"
library(ggplot2 )

roadIndex <- sort(unique(SCC[grepl("road", SCC$Data.Category, ignore.case=TRUE), 1]))

Years <- unique(NEI$year)                 ## sample years
p6TypeData <- data.frame(row.names=FALSE) ## small storage structure for 
                                          ## subset of data

for(i in 1:length(Years)){ 
    p6TypeData[i,1] <- Years[i]                       ## Load sample dates
    p6TypeData[i,2] <- sum(NEI[NEI$year==Years[i]    ## Load sum 1st NEI$type
                              & NEI$fips=="24510" 
                              & NEI$SCC %in% roadIndex,
                              4])
    p6TypeData[i,3] <- sd(NEI[NEI$year==Years[i]     ## Load std 1st NEI$type
                             & NEI$fips=="24510" 
                             & NEI$SCC %in% roadIndex,
                             4])
    p6TypeData[i,4] <- sum(NEI[NEI$year==Years[i]    ## Load sum 2nd NEI$type
                              & NEI$fips=="06037" 
                              & NEI$SCC %in% roadIndex,
                              4])
    p6TypeData[i,5] <- sd(NEI[NEI$year==Years[i]     ## Load std 2nd NEI$type
                             & NEI$fips=="06037" 
                             & NEI$SCC %in% roadIndex,
                             4])
}
colnames(p6TypeData) <- c("Year", 
                          "Baltimore_City", 
                          "BC_dev", 
                          "L_A_Co", 
                          "LA_dev")         ## data frame columns

p1 <- ggplot(p6TypeData, 
             aes(x=Year, 
                 y=p6TypeData[,2])) +                  ## Plot first type
      geom_line(color="red") +
      annotate("text",                                 ## Label first type
               label="total Baltimore", 
               y=p6TypeData[1,2], 
               x=1999.8,  
               size=4,
               vjust=-0.25,
               color="red") +
      geom_line(data=p6TypeData, 
                aes(y=p6TypeData[,3]), 
                color="red",
                linetype = 2) +                         ## Plot second type
      annotate("text",                                 ## Label first type
               label="std dev Baltimore", 
               y=p6TypeData[1,3], 
               x=1999.8,  
               size=4, 
               vjust=1,
               color="red") +
      geom_line(data=p6TypeData, 
                aes(y=p6TypeData[,4]), 
                color="blue") +                         ## Plot second type
      annotate("text", 
               label="total L.A.", 
               y=p6TypeData[4,4]-50, 
               x=2006.7,  
               size=4, 
               vjust=0.25,
               color="blue" ) +
      geom_line(data=p6TypeData, 
                aes(y=p6TypeData[,5]), 
                color="blue",
                linetype = 2) +                         ## Plot second type
      annotate("text", 
               label="std dev L.A. ", 
               y=p6TypeData[1,5], 
               x=2006.7,  
               size=4, 
               vjust=1.5,
               color="blue" ) +
      ylab("tons" ) +
      xlab("year" ) +                                  ## x,y labels
      ggtitle(paste0("Vehicle Emissions for\n",
                     "Baltimore City vs L.A. County")) + 
      scale_x_continuous(breaks=Years)                 ## label axis for sample 
                                                       ## year
    
print(p1)
dev.copy(png, width=600, height=480, file = targFile)  ## output to file
dev.off()
#rm(Years, targFile, i, p6TypeData, roadIndex)            ## cleanup