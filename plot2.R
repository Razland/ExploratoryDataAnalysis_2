targFile="plot2.png"



Years <- unique(NEI$year)
p2Data <- data.frame()
for( i in 1:length(Years)){ 
  p2Data[i,1] <- Years[i]
  p2Data[i, 2] <- sum(NEI[NEI$year==Years[i] & NEI$fips=="24510", 4])
  }

colnames(p2Data) <- c("Year", "Total")

par(pin = c(6, 4), 
    lab=c(12, 4, 7), 
    lwd=2,
    mar=c(4,5,4,2)) 
plot(p2Data$Year, 
     p2Data$Total/1000, 
     type="l", 
     ylab="kilotons", 
     xlab="year", 
     main="FPM Annual Emissions for Baltimore")
dev.copy(png, width=600, height=480, file = targFile)  ## output to file
dev.off()
rm(p2Data, Years, targFile, i)