## File plot6.R Assignment 2 Exploratory Data Analysis November, 2014.
## Dave Kenny

## Plot the PM_2.5 totals for motor vehicle sources in Baltimore City and 
## Los Angeles over each sample year using the ggplot2 plotting system.
library(ggplot2 )

source("loadData.R")  ## Source the utility file that downloads, unzips, and
                      ## reads in the data as needed.
targFile="plot6.png"

roadIndex <-                                ## Create an index of the SCC 
  sort( unique( SCC[                        ## numbers from the on and off road
        grepl("road",                       ## categories which indicate
        SCC$Data.Category,                  ## vehicular sources
        ignore.case=TRUE), 1]))

years <- unique(NEI$year)                   ## Sample years
zipCode <- c( "24510", "06037")             ## Zip code
plotTitle <- paste0("Vehicle Emissions ",
                    "for\nBaltimore City ",
                    "vs L.A. County")
getSum <-                                   ## Function to return the sum of
  function(y, zip, index){                  ## sensor data for each year-group,
    return( sum( NEI[ NEI$year==y &         ## the locale zip code, and
      NEI$fips==zip &                       ## the SCC code
      NEI$SCC %in% index, 4]))}

getDev <-                                    ## Function to return the std dev
  function(y, zip, index){                   ## of sensor data for group, zip,
    return( sd( NEI[ NEI$year==y &           ## and SCC.
      NEI$fips==zip &
      NEI$SCC %in% index, 4]))}

p6TypeData <- data.frame( Year=years)       ## Store a subset of the data
          
for(col in as.numeric(c(2,4))){
  for(i in 1:length(years)){
    p6TypeData[i,col] <-
      getSum( years[i], zipCode[col/2], roadIndex)
    p6TypeData[i,col+1] <-
      getDev( years[i], zipCode[col/2], roadIndex)}}

colnames(p6TypeData) <-                     ## Name data frame columns for the
  c("Year", "Baltimore_City", "BC_dev",     ## content.
    "L_A_Co", "LA_dev")

p1 <- ggplot(p6TypeData,                    ## Initial plot of Baltimore totals
             aes(x=Year, 
                 y=p6TypeData[,2])) +
      geom_line(color="red") +              ## Make into solid line plot layer.
      annotate("text",                      ## Label the first line plot type.
               label="total Baltimore",
               y=p6TypeData[1,2], x=1999.8,
               size=4, vjust=-0.25, color="red") +
      geom_line(data=p6TypeData,            ## Add dotted line for standard 
                aes(y=p6TypeData[,3]),      ## deviation.
                color="red", linetype = 2) +             
      annotate("text",                      ## Add label for Baltimore standard
               label="std dev Baltimore",   ## deviation.
               y=p6TypeData[1,3], x=1999.8, 
               size=4, vjust=1, color="red") +
      geom_line(data=p6TypeData,            ## Add plot for L.A. totals.
                aes(y=p6TypeData[,4]), color="blue") +             
      annotate("text",                      ## Annotate L.A. total plot.
               label="total L.A.", 
               y=p6TypeData[4,4]-50, x=2006.7,
               size=4, vjust=0.25, color="blue" ) +
      geom_line(data=p6TypeData,            ## Add dotted line plot for
                aes(y=p6TypeData[,5]),      ## L.A. standard deviation by year.
                color="blue", linetype = 2) + 
      annotate("text",                      ## Label L.A. standard dev.
               label="std dev L.A.", 
               y=p6TypeData[1,5], x=2006.7,  
               size=4, vjust=1.5, color="blue" ) +
      ylab( "tons" ) + xlab( "year" ) +     ## x,y axis labels.
      ggtitle( plotTitle) +                 ## Title for table.
      scale_x_continuous(breaks=years)      ## Breaks x axis by sample year .
    
print(p1)                                   ## Print the plot.

dev.copy(png, width=600, height=480,        ## Print plot to file.
         file=targFile)

dev.off()                                   ## Close output device.

rm(years, targFile, i, col, zipCode, p1,    ## Cleanup for variables.
   p6TypeData, roadIndex, plotTitle,
   getDev, getSum)