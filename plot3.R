## File plot3.R Assignment 2 Exploratory Data Analysis November, 2014.
## Dave Kenny

## Plot the PM_2.5 totals for each source-sensor type in Baltimore City over
## each sample year using the ggplot2 plotting system.

library(ggplot2)
source("loadData.R")                        ## Source the utility file that
                                            ## conditionally downloads, unzips,
                                            ## and reads in data.
targFile="plot3.png"
years <- unique(NEI$year)                   ## Data sample date-years
typeNEI <- unique(NEI$type)                 ## List of types from NEI
zipCode <- "24510"                          ## Zip code
p3TypeData <- data.frame(Year=years)        ## Data structure for data subset

getSum <-                                   ## Function to return the sum of
  function(y, typeN){                       ## sensor data for each year-group,
    return(sum(NEI[NEI$year==y              ## the Baltimore City zip code, and
                & NEI$fips==zipCode         ## the NEI sensor-data type
                & NEI$type==typeN, 4]))}

for(i in 1:length(years)){
  for(col in 2:5){
    p3TypeData[i,col] <- getSum(years[i], typeNEI[col-1])
    dimnames(p3TypeData)[[2]][col] <- as.character(typeNEI[col-1])}}

plotTitle <-                                ## Title for plot
  paste0("FPM Emissions for Baltimore City\n",
         "by Source-Sensor Type")

p1 <- ggplot(p3TypeData,                    ## Line plot for each type
             aes(x=Year,
                 y=p3TypeData[,2])) +
      geom_line(color="black") +            ## Add line plot layer
      annotate("text",                      ## Add label for first line type
               label=tolower(
                 colnames(p3TypeData[2])),
               y=p3TypeData[2,2], x=2002.7,
               size=4, vjust=-0.5) +
      geom_line(data=p3TypeData,            ## Add line plot for 2nd type
                aes(y=p3TypeData[,3]),
                color="red") +
      annotate("text",                      ## Add type label for 2nd line
               label=tolower(
                 colnames(p3TypeData[3])),
               y=p3TypeData[2,3], x=2002.7,
               size=4, vjust=-0.5,
               color="red") +
      geom_line(data=p3TypeData,            ## Add line plot for 3rd type
                aes(y=p3TypeData[,4]),
                color="blue") +
      annotate("text",                      ## Add type label for 3rd line
               label=tolower(
                 colnames(p3TypeData[4])),
               y=p3TypeData[2,4],
               x=2002.7, size=4,
               vjust=-0.5, color="blue") +
      geom_line(data=p3TypeData,            ## Add line plot for 4th type
                aes(y=p3TypeData[,5]),
                color="green") +
      annotate("text",                      ## Add type label for 4th line
               label=tolower(
                 colnames(p3TypeData[5])),
               y=p3TypeData[2,5],
               x=2002.7, size=4,
               vjust=-0.5, color="green") +
      ylab("tons") + xlab("year") +         ## x,y axis labels.
      ggtitle(plotTitle) +                  ## Add overall table. Axis breaks/
      scale_x_continuous(breaks=years)      ## labels for sample years

print(p1)                                   ## Print plot

dev.copy(png, width=600,                    ## Write plot to file
         height=480, file=targFile)

dev.off()                                   ## Turn off plot device

rm(years, targFile, i, col, p1, zipCode,    ## Clean up environment
   typeNEI, p3TypeData, getSum, plotTitle)