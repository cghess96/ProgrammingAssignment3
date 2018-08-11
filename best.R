### Set the working directory

setwd("/Users/dad/Documents/Coursera/Data-Science-Specialization/Course2RProgramming/ProgrammingAssignment3/rprog%2Fdata%2FProgAssignment3-data")

### Create "best" function

best <- function(state, outcome) {
    # Read the outcome data
      outcome_data <- data.table::fread("outcome-of-care-measures.csv")
      outcome <- tolower(outcome)
    
    # Rename 'state' variable to avoid confusion with column named 'state'
      selected_state <- state
      
    # Confirm that state and outcome are valid
      if (!selected_state %in% unique(outcome_data[["State"]])) {
        stop("invalid state")
      }
      
      if(!outcome %in% c("heart attack", "heart failure", "pneumonia")) {
        stop("invalid outcome")
      }
  
    # Set column names as lowercase
      setnames(outcome_data, tolower(sapply(colnames(outcome_data), gsub, pattern = "^Hospital 30-Day Death \\(Mortality\\) Rates from", replacement="")))
      
    # Filter by state
      outcome_data <- outcome_data[state==selected_state]
      
    # Index columns
      col_indices <- grep(paste0("hospital name|state|^",outcome), colnames(outcome_data))
      
    # Filter out unnecessary data
      outcome_data <- outcome_data[, .SD ,.SDcols = col_indices]
      
    # Determine class for each column
    # sapply(outcome_data, class)
      outcome_data[, outcome] <- outcome_data[, as.numeric(get(outcome))]
      
    # Remove missing values
      outcome_data <- outcome_data[copmlete.cases(outcome_data),]
      
    # Order column
      outcome_data <- outcome_data[order(get(outcome), "hospital name")]
      
    return(outcome_data[, "hospital name"][1])
}