Rversion <- R.Version()
Rversion$version.string
## "R version 4.0.3 (2020-10-10)"


rm(list=ls())
getwd()
dir()

setwd("C:/Paco/GitHub/Tempo/DATRAS/Code/R")
dir()

library(dplyr)
library(maps)

DBa <- read.csv("DB.csv")


# Structure
str(DBa)
summary(DBa)

# Filtering
DB <- DB[!(DB$HLNoAtLngt == -9),]
DB <- DB[!(DB$HaulDur == 0),]
DB <- DB[!(DB$HaulDur > 200),]

# Standarized
for (c in 1:nrow(DB)){
    if (DB$DataType[c] == 'C')
        DB$CPUE_number_per_hour[c] <- DB$HLNoAtLngt[c]
    else 
        DB$CPUE_number_per_hour[c] <- (DB$HLNoAtLngt[c]*60)/DB$HaulDur[c]
}



write.table(DB,"DBcsv",
            sep=",",dec=".",col.names=NA)
