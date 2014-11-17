## File plot3.R Assignment 2 Exploratory Data Analysis November, 2014.
## Dave Kenny

## Plot the PM_2.5 totals for source types in Baltimore City over each sample 
## year using the ggplot2 plotting system.  Variant uses internet-supplied 
## multiplot.R to draw four plots, one for each of the sensor source types.

source("loadData.R")  ## Source the utility file that downloads, unzips, and
## reads in the data as needed.

targFile="mult_plot3.png"

library(ggplot2 )
source("multiplot.R" )   ## Internet sourced (credit in comments) file for 
                         ## multiple ggplot2 plots in rows and columns.
Years <- unique(NEI$year)
typeNEI <- unique(NEI$type)

plot1 <- function() {                                  ## Function creates 1st
  p3TypeData1 <- data.frame()                          ## plot data type, 
  for(i in 1:length(Years)){                           ## returns plot variable
      p3TypeData1[i,1] <- Years[i]
      p3TypeData1[i,2] <- sum(NEI[NEI$year==Years[i] 
                            & NEI$fips=="24510" 
                            & NEI$type==typeNEI[1],
                              4])
    }
  colnames(p3TypeData1) <- c("Year", "Total")
  p1 <- ggplot(p3TypeData1, aes(x=Year, y=Total)) +
        geom_line() +
        ylab("tons" ) +
        xlab("year" ) + 
        ggtitle(paste0(typeNEI[1],
                      "-type FPM Emissions for Baltimore City")) + 
        scale_x_continuous(breaks=Years)
  return(p1)
}

plot2 <- function() {
  p3TypeData2 <- data.frame()
  for(i in 1:length(Years)){ 
      p3TypeData2[i,1] <- Years[i]
      p3TypeData2[i,2] <- sum(NEI[NEI$year==Years[i] 
                                 & NEI$fips=="24510" 
                                 & NEI$type==typeNEI[2],
                                 4])
  }
  colnames(p3TypeData2) <- c("Year", "Total")
  p2 <- ggplot(p3TypeData2, aes(x=Year, y=Total)) +
        geom_line() +
        ylab("tons" ) +
        xlab("year" ) + 
        ggtitle(paste0( typeNEI[2], 
                        "-type FPM Emissions for Baltimore City")) +
        scale_x_continuous(breaks=Years)
  return(p2)
}

plot3 <- function() {
  p3TypeData3 <- data.frame()
  for(i in 1:length(Years)){ 
      p3TypeData3[i,1] <- Years[i]
      p3TypeData3[i, 2] <- sum(NEI[NEI$year==Years[i] 
                                 & NEI$fips=="24510" 
                                 & NEI$type==typeNEI[3],
                                 4])
  }
  colnames(p3TypeData3) <- c("Year", "Total")
  p3 <- ggplot(p3TypeData3, aes(x=Year, y=Total)) +
        geom_line() +
        ylab("tons" ) +
        xlab("year" ) + 
        ggtitle(paste0( typeNEI[3], 
                        "-type FPM Emissions for Baltimore City")) + 
        scale_x_continuous(breaks=Years)
  return(p3)
}

plot4 <- function() {
  p3TypeData4 <- data.frame()
  for(i in 1:length(Years)){ 
      p3TypeData4[i,1] <- Years[i]
      p3TypeData4[i,2] <- sum(NEI[NEI$year==Years[i] 
                                 & NEI$fips=="24510" 
                                 & NEI$type==typeNEI[4],
                                 4])
  }
  colnames(p3TypeData4) <- c("Year", "Total")
  p4 <- ggplot(p3TypeData4, aes(x=Year, y=Total)) +
        geom_line() +
        ylab("tons" ) +
        xlab("year" ) + 
        ggtitle(paste0(typeNEI[4], 
                       "-type FPM Emissions for Baltimore City")) + 
        scale_x_continuous(breaks=Years)
  return(p4)
}


multiplot(plot1(),
          plot2(),
          plot3(),
          plot4(), 
          cols=2
)
dev.copy(png, width=600, height=480, file = targFile)  ## output to file
dev.off()
rm(Years, targFile, i, typeNEI, multiplot, plot1, plot2, plot3, plot4)