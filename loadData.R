# Script loadData.R
# Dave Kenny.  Exploratory Data Analysis Assignment 2, Nov 2014.
# Utility script to (as needed) get files and load into data structure.


dataURL <- 
  paste0("https://d396qusza40orc.cloudfront.net/",
         "exdata%2Fdata%2FNEI_data.zip")
targFileName <- "exdata_data_NEI_data.zip"
summFileName <- "summarySCC_PM25.rds"
classFileName <- "Source_Classification_Code.rds"

if(!file.exists(targFileName)) {            ## If not present in the working
  print(                                    ## directory, download the
    paste0(                                 ## assignment file from the web and
      "downloading data ", dataURL))        ## decompress it.
  download.file(dataURL,        
                destfile = targFileName,
                method = "curl") 
  unzip(targFileName)
}

if(!"NEI" %in% ls()) {                      ## If data is not already loaded
  print("loading rds file")                 ## into the environment, then read
  NEI <- readRDS("summarySCC_PM25.rds")     ## it into memory using the
  }                                         ## command copied from the
                                            ## assignment text.

if(!"SCC" %in% ls()) {                      ## If the coding information table is
  print("loading code data")                ## not already loaded into the 
  codeFile <-                               ## working environment, then read
    "Source_Classification_Code.rds"        ## it into memory using the command
  SCC <- readRDS(codeFile)                  ## given in the assignment text. 
  rm(codeFile)
  }                       

rm(dataURL, targFileName,                   ## Clean up environment
   summFileName, classFileName)