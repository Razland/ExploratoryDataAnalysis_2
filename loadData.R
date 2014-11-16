# Script loadData.R
# Dave Kenny.  Exploratory Data Analysis Assignment 2, Nov 2014.
# Utility script to get files and load into data structure.


dataURL <- paste0("https://d396qusza40orc.cloudfront.net/",
                  "exdata%2Fdata%2FNEI_data.zip")
targFileName <- "exdata_data_NEI_data.zip"
summFileName <- "summarySCC_PM25.rds"
classFileName <- "Source_Classification_Code.rds"

if(!file.exists(targFileName)) {                          ## if not present,
  print(paste0("downloading data ", dataURL))               ## download file
  download.file(dataURL,                                    ## from web and  
                destfile = targFileName, method = "curl")   ## decompress
  unzip(targFileName)
}
## Lines copied from assignment text:
print("loading rds file")
NEI <- readRDS("summarySCC_PM25.rds")
print("loading code data")
SCC <- readRDS("Source_Classification_Code.rds")



