targFile="plot1.png"


p1Data <- data.frame()

Years <- unique(NEI$year)
for( i in 1:length(Years)){ 
  p1Data[i,1] <- Years[i]
  p1Data[i, 2] <- sum(NEI[NEI$year==Years[i], 4])
  }

colnames(p1Data) <- c("Year", "Total")

par(pin = c(6, 4), 
    lab=c(12, 4, 7), 
    lwd=2,
    mar=c(4,5,4,2)) 
plot(p1Data$Year, 
     p1Data$Total/1000, 
     type="l", 
     ylab="kilotons", 
     xlab="year", 
     main="Fine Particulate Matter Annual Emissions")
dev.copy(png, width=600, height=480, file = targFile)  ## output to file
dev.off()
rm(p1Data, Years, targFile, i)