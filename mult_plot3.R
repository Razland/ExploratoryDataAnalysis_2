## File subPlot3.R Assignment 2 Exploratory Data Analysis November, 2014.
## Dave Kenny

## Plot the PM_2.5 totals for source types in Baltimore City over each sample 
## year using the ggsubPlot2 plotting system.  Variant uses internet-supplied 
## multiplot.R to draw four plots, one for each of the sensor source types.

source("loadData.R")  ## Source the utility file that downloads, unzips, and
                      ## reads in the data as needed.

targFile="mult_subPlot3.png"

library(ggsubPlot2)
library(grid)
source("multiplot.R")         ## Internet sourced (credit in comments) file for
                              ## multiple ggsubPlot2 plots in rows and columns.
Years <- unique(NEI$year)                   ## Sample date-years
typeNEI <- unique(NEI$type)                 ## List of types from NEI
titleText <-                                ## Same title text for each plot.
  "-type FPM Emissions\nfor Baltimore City"

subPlot1 <- function() {                    ## Function creates 1st plot data
  p3TypeData1 <- data.frame()               ## type, returns plot variable
  for(i in 1:length(Years)){                ## Load a data frame with 
      p3TypeData1[i,1] <- Years[i]          ## appropriate data for each year
      p3TypeData1[i,2] <-                   ## by sampling type.
        sum(NEI[NEI$year==Years[i] 
               & NEI$fips=="24510" 
               & NEI$type==typeNEI[1],
               4])
  }
  colnames(p3TypeData1) <-                  ## Name the data frame variables.
    c("Year", "Total")
  p1 <- ggplot(p3TypeData1,                 ## Plot the data into p1.
               aes(x=Year, 
                   y=Total)) +
        geom_line() +
        ylab("tons") +
        xlab("year") + 
        ggtitle(
          paste0(
            typeNEI[1],
            titleText)) +
        theme(plot.title=element_text(size=12)) +
        scale_x_continuous(breaks=Years)
  return(p1)
}

subPlot2 <- function() {
  p3TypeData2 <- data.frame()
  for(i in 1:length(Years)){ 
      p3TypeData2[i,1] <- Years[i]
      p3TypeData2[i,2] <- 
        sum(NEI[NEI$year==Years[i] 
               & NEI$fips=="24510" 
               & NEI$type==typeNEI[2],
               4])
  }
  colnames(p3TypeData2) <- 
    c("Year", "Total")
  p2 <- ggplot(p3TypeData2, 
               aes(x=Year, 
                   y=Total)) +
        geom_line() +
        ylab("tons") +
        xlab("year") + 
        ggtitle(
          paste0(
            typeNEI[2], 
            titleText)) +
    theme(plot.title=element_text(size=12)) +
    scale_x_continuous(breaks=Years)
  return(p2)
}

subPlot3 <- function() {
  p3TypeData3 <- data.frame()
  for(i in 1:length(Years)){ 
      p3TypeData3[i,1] <- Years[i]
      p3TypeData3[i, 2] <- 
        sum(NEI[NEI$year==Years[i] 
               & NEI$fips=="24510" 
               & NEI$type==typeNEI[3],
               4])
  }
  colnames(p3TypeData3) <- 
    c("Year", "Total")
  p3 <- ggplot(p3TypeData3, 
               aes(x=Year, 
                   y=Total)) +
        geom_line() +
        ylab("tons") +
        xlab("year") + 
        ggtitle(
          paste0(
            typeNEI[3], 
            titleText)) + 
    theme(plot.title=element_text(size=12)) +
    scale_x_continuous(breaks=Years)
  return(p3)
}

subPlot4 <- function() {
  p3TypeData4 <- data.frame()
  for(i in 1:length(Years)){ 
      p3TypeData4[i,1] <- Years[i]
      p3TypeData4[i,2] <- 
        sum(NEI[NEI$year==Years[i] 
               & NEI$fips=="24510" 
               & NEI$type==typeNEI[4],
               4])
  }
  colnames(p3TypeData4) <- 
    c("Year", "Total")
  p4 <- ggplot(p3TypeData4, 
               aes(x=Year, 
                   y=Total)) +
        geom_line() +
        ylab("tons") +
        xlab("year") + 
        ggtitle(
          paste0(
            typeNEI[4], 
            titleText)) + 
    theme(plot.title=element_text(size=12)) +
    scale_x_continuous(breaks=Years)
  return(p4)
}

multiplot(subPlot1(),                       ## Calls multiplot function for 2
          subPlot2(),                       ## columns of plots.
          subPlot3(),
          subPlot4(), 
          cols=2
)
dev.copy(png,                               ## Write plot to file
         width=600, 
         height=480, 
         file=targFile)  
dev.off()                                   ## Turn device off
rm(Years, targFile, titleText,              ## Clean up environment
   typeNEI, multiplot, 
   subPlot1, subPlot2, 
   subPlot3, subPlot4)