## File plot6.R Assignment 2 Exploratory Data Analysis November, 2014.
## Dave Kenny

## Plot the PM_2.5 totals for motor vehicle sources in Baltimore City and 
## Los Angeles over each sample year using the ggplot2 plotting system.

source("loadData.R")  ## Source the utility file that downloads, unzips, and
                      ## reads in the data as needed.
targFile="plot6.png"
library(ggplot2 )

roadIndex <-                                ## Create an index of the 
  sort(unique(SCC[grepl("road",             ## SCC numbers from the on and off      
                        SCC$Data.Category,  ## road categories which indicate
                        ignore.case=TRUE),  ## vehicular sources
                        1]))

Years <- unique(NEI$year)                   ## Sample years
p6TypeData <- data.frame(row.names=FALSE)   ## Small storage structure for 
                                            ## a subset of the data

for(i in 1:length(Years)){ 
    p6TypeData[i,1] <- Years[i]             ## Load sample-dates into frame c1.
    p6TypeData[i,2] <-                      ## Load and sum the samples for the
      sum(NEI[NEI$year==Years[i]            ## vehicle PM_2.5 for Baltimore.
             & NEI$fips=="24510" 
             & NEI$SCC %in% roadIndex,
             4])
    p6TypeData[i,3] <-                      ## Load the standard deviation for
      sd(NEI[NEI$year==Years[i]             ## each year using the same data 
            & NEI$fips=="24510"             ## source as summed above.
            & NEI$SCC %in% roadIndex,
            4])
    p6TypeData[i,4] <-                      ## Load and sum the samples for the
      sum(NEI[NEI$year==Years[i]            ## vehicle PM_2.5 for L.A. County.
             & NEI$fips=="06037" 
             & NEI$SCC %in% roadIndex,
             4])
    p6TypeData[i,5] <-                      ## Load standard deviation for L.A.
      sd(NEI[NEI$year==Years[i]             ## County from the PM_2.5 data
            & NEI$fips=="06037"             ## the same as above.
            & NEI$SCC %in% roadIndex,
            4])
    }

colnames(p6TypeData) <- c("Year",           ## Name data frame columns for the
                          "Baltimore_City", ## content.
                          "BC_dev", 
                          "L_A_Co", 
                          "LA_dev")         

p1 <- ggplot(p6TypeData,                    ## Initial plot of Baltimore totals
             aes(x=Year, 
                 y=p6TypeData[,2])) +
      geom_line(color="red") +              ## Make into solid line plot layer.
      annotate("text",                      ## Label the first line plot type.
               label="total Baltimore", 
               y=p6TypeData[1,2], 
               x=1999.8,  
               size=4,
               vjust=-0.25,
               color="red") +
      geom_line(data=p6TypeData,            ## Add dotted line for standard 
                aes(y=p6TypeData[,3]),      ## deviation.
                color="red",
                linetype = 2) +             
      annotate("text",                      ## Add label for Baltimore standard
               label="std dev Baltimore",   ## deviation.
               y=p6TypeData[1,3], 
               x=1999.8,  
               size=4, 
               vjust=1,
               color="red") +
      geom_line(data=p6TypeData,            ## Add plot for L.A. totals.
                aes(y=p6TypeData[,4]), 
                color="blue") +             
      annotate("text",                      ## Annotate L.A. total plot.
               label="total L.A.", 
               y=p6TypeData[4,4]-50, 
               x=2006.7,  
               size=4, 
               vjust=0.25,
               color="blue" ) +
      geom_line(data=p6TypeData,            ## Add dotted line plot for
                aes(y=p6TypeData[,5]),      ## L.A. standard deviation by year.
                color="blue",
                linetype = 2) + 
      annotate("text",                      ## Label L.A. standard dev.
               label="std dev L.A. ", 
               y=p6TypeData[1,5], 
               x=2006.7,  
               size=4, 
               vjust=1.5,
               color="blue" ) +
      ylab("tons" ) +                       ## x,y axis labels.
      xlab("year" ) +
      ggtitle(                              ## Title for table.
        paste0("Vehicle Emissions for\n",
                "Baltimore City vs L.A. County")) + 
      scale_x_continuous(breaks=Years)      ## Breaks x axis by sample year .
    
print(p1)                                   ## Print the plot.
dev.copy(png,                               ## Output to file
         width=600, 
         height=480, 
         file = targFile)  
dev.off()                                   ## Close output device.
rm(Years, targFile, i,                      ## Cleanup for variables.
   p6TypeData, roadIndex, p1)