## File plot3.R Assignment 2 Exploratory Data Analysis November, 2014.
## Dave Kenny

## Plot the PM_2.5 totals for source types in Baltimore City over each sample 
## year using the ggplot2 plotting system.

source("loadData.R")  ## Source the utility file that downloads, unzips, and
                      ## reads in the data as needed.

targFile="plot3.png"

library(ggplot2 )

Years <- unique(NEI$year)  ## sample years
p3TypeData <- data.frame() ## small storage structure for subset of data
for( i in 1:length(Years)){ 
     p3TypeData[i,1] <- Years[i]                       ## Load sample dates
     p3TypeData[i,2] <- sum(NEI[NEI$year==Years[i]     ## Load first NEI$type
                            & NEI$fips=="24510" 
                            & NEI$type==typeNEI[1],
                              4])
     p3TypeData[i,3] <- sum(NEI[NEI$year==Years[i]     ## Load 2nd NEI$type
                                & NEI$fips=="24510" 
                                & NEI$type==typeNEI[2],
                                4])
     p3TypeData[i,4] <- sum(NEI[NEI$year==Years[i]     ## Load 3rd NEI$type
                                & NEI$fips=="24510" 
                                & NEI$type==typeNEI[3],
                                4])
     p3TypeData[i,5] <- sum(NEI[NEI$year==Years[i]     ## Load 4th NEI$type
                                & NEI$fips=="24510" 
                                & NEI$type==typeNEI[4],
                                4])
}
colnames(p3TypeData) <- c("Year", typeNEI)             ## data frame columns

p1 <- ggplot(p3TypeData, 
             aes(x=Year, 
                 y=p3TypeData[,2]))+                   ## Plot first type
      geom_line(color="black") +
      annotate("text",                                 ## Label first type
               label=tolower(colnames(p3TypeData[2])), 
               y=p3TypeData[1,2], 
               x=1998.75,  
               size=4 ) +
      geom_line(data=p3TypeData, 
                aes(y=p3TypeData[,3]), 
                color="red") +                         ## Plot second type
      annotate("text", label=tolower(colnames(p3TypeData[3])), 
               y=p3TypeData[1,3], x=1998.75,  
               size=4, color="red" ) +
      geom_line(data=p3TypeData, 
                aes(y=p3TypeData[,4]), 
                color="blue") +                        ## Plot third type
      annotate("text", label=tolower(colnames(p3TypeData[4])), 
               y=p3TypeData[1,4], x=1998.75,  
               size=4, color="blue" ) +
      geom_line(data=p3TypeData, 
                aes(y=p3TypeData[,5]), 
                color="green") +                       ## Plot last type
      annotate("text", label=tolower(colnames(p3TypeData[5])), 
               y=p3TypeData[1,5], x=1998.75,  
               size=4, color="green" ) +
      ylab("tons" ) +
      xlab("year" ) +                                  ## x,y labels
      ggtitle("FPM Emissions for Baltimore City by Source Type") + 
      scale_x_continuous(breaks=Years)                 ## label axis for sample 
                                                       ## year
    
print(p1)
dev.copy(png, width=600, height=480, file = targFile)  ## output to file
dev.off()
rm(Years, targFile, i, typeNEI, p3TypeData)            ## cleanup