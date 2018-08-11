### Set the working directory

setwd("/Users/dad/Documents/Coursera/Data-Science-Specialization/Course2RProgramming/ProgrammingAssignment3/rprog%2Fdata%2FProgAssignment3-data")

### Load the 'data.table' package

library("data.table")

### Read the data into R

outcome <- data.table::fread("outcome-of-care-measures.csv")
head(outcome)
outcome[, (11) := lapply(.SD, as.numeric), .SDcols = (11)]
outcome[, lapply(.SD
                 , hist
                 , xlab= "Deaths"
                 , main="Hospital 30-Day Death (Mortality) Rates from Heart Attack"
                 , col="lightblue")
        , .SDcols=(11)]