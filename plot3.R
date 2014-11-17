## File plot3.R Assignment 2 Exploratory Data Analysis November, 2014.
## Dave Kenny

## Plot the PM_2.5 totals for each source-sensor type in Baltimore City over 
## each sample year using the ggplot2 plotting system.

source("loadData.R")                        ## Source the utility file that 
                                            ## downloads, unzips, and
                                            ## reads in the data as needed.

targFile="plot3.png"

library(ggplot2)

Years <- unique(NEI$year)                   ## Data sample date-years
typeNEI <- unique(NEI$type)                 ## List of types from NEI

p3TypeData <- data.frame()                  ## Data structure for data subset
for( i in 1:length(Years)){ 
     p3TypeData[i,1] <- Years[i]            ## Load sample dates
     p3TypeData[i,2] <-                     ## Load total for type
       sum(NEI[NEI$year==Years[i]
              & NEI$fips=="24510" 
              & NEI$type==typeNEI[1],
              4])
     p3TypeData[i,3] <-                     ## Load total for 2nd type
       sum(NEI[NEI$year==Years[i]           
              & NEI$fips=="24510" 
              & NEI$type==typeNEI[2],
              4])
     p3TypeData[i,4] <-                     ## Load total for 3rd type
       sum(NEI[NEI$year==Years[i]
              & NEI$fips=="24510" 
              & NEI$type==typeNEI[3],
              4])
     p3TypeData[i,5] <-                     ## Load total for 2nd type
       sum(NEI[NEI$year==Years[i]
              & NEI$fips=="24510" 
              & NEI$type==typeNEI[4],
              4])
  }

colnames(p3TypeData) <- c("Year", typeNEI)  ## Name data columns
plotTitle <-                                ## Title for plot
  paste0("FPM Emissions for Baltimore City\n",
          "by Source-Sensor Type")
p1 <- ggplot(p3TypeData,                    ## Line plot for each type
             aes(x=Year, 
                 y=p3TypeData[,2])) +
      geom_line(color="black") +            ## Add line plot layer
      annotate("text",                      ## Add label for first line type
               label=tolower(
                 colnames(
                   p3TypeData[2])), 
               y=p3TypeData[2,2], 
               x=2002.7,  
               size=4,
               vjust=-0.5) +
      geom_line(data=p3TypeData,            ## Add line plot for 2nd type
                aes(y=p3TypeData[,3]), 
                color="red") +                  
      annotate("text",                      ## Add type label for 2nd line
               label=tolower(
                 colnames(
                   p3TypeData[3])), 
               y=p3TypeData[2,3], 
               x=2002.7,  
               size=4, 
               vjust=-0.5,
               color="red") +
      geom_line(data=p3TypeData,            ## Add line plot for 3rd type
                aes(y=p3TypeData[,4]), 
                color="blue") +             
      annotate("text",                      ## Add type label for 3rd line
               label=tolower(
                 colnames(
                   p3TypeData[4])), 
               y=p3TypeData[2,4], 
               x=2002.7,  
               size=4,
               vjust=-0.5,
               color="blue") +
      geom_line(data=p3TypeData,            ## Add line plot for 4th type
                aes(y=p3TypeData[,5]), 
                color="green") +            
      annotate("text",                      ## Add type label for 4th line 
               label=tolower(
                 colnames(
                   p3TypeData[5])), 
               y=p3TypeData[2,5], 
               x=2002.7,  
               size=4,
               vjust=-0.5,
               color="green") +
      ylab("tons") +                        ## x,y axis labels.
      xlab("year") +
      ggtitle(plotTitle) +                  ## Add overall table. 
      scale_x_continuous(breaks=Years)      ## Axis breaks/labels for sample 
                                            ## years

print(p1)                                   ## Print plot
dev.copy(png,                               ## Write plot to file
         width=600, 
         height=480, 
         file=targFile) 
dev.off()                                   ## Turn off plot device
rm(Years, targFile, i,                      ## Clean up environment 
   typeNEI, p3TypeData)