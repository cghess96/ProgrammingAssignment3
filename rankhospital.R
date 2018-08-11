### Set the working directory

setwd("/Users/dad/Documents/Coursera/Data-Science-Specialization/Course2RProgramming/ProgrammingAssignment3/rprog%2Fdata%2FProgAssignment3-data")

### Create "rankall" function

rankall <- function(outcome, num = "best") {
  # Read the outcome data
    outcome_data <- data.table::fread("outcome-of-care-measures.csv")
    outcome <- tolower(outcome)
  
  # Confirm that outcome is valid
    if(!outcome %in% c("heart attack", "heart failure", "pneumonia")) {
      stop("invalid outcome")
  }
  
  # Set column names as lowercase
    setnames(outcome_data, tolower(sapply(colnames(outcome_data), gsub, pattern = "^Hospital 30-Day Death \\(Mortality\\) Rates from", replacement="")))
  
  # Index columns
    col_indices <- grep(paste0("hospital name|state|^",outcome), colnames(outcome_data))
  
  # Filter out unnecessary data
    outcome_data <- outcome_data[, .SD ,.SDcols = col_indices]
  
  # Determine class for each column
  # sapply(outcome_data, class)
    
  # Change column class of outcome
    outcome_data[, outcome] <- outcome_data[, as.numeric(get(outcome))]
  
    if (num == "best") {
      return(outcome_data[order(state, get(outcome), "hospital name"), .(hospital = head("hospital name", 1)), by = state])
    }
    
    if (num == "worst"){
      return(outcome_data[order(get(outcome), "hospital name"), .(hospital = tail("hospital name", 1)), by = state])
    }
    
    return(outcome_data[order(state, get(outcome), "hospital name"), head(.SD,num), by = state, .SDcols = c("hospital name")])
  
}