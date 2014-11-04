best <- function(state, outcome) {
  
  ## Read outcome data
  file <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
  ## Make everything uppercase
  outcome <- toupper(outcome)
  state <- toupper(state)
  
  ## Valid Outcomes
  outcomes <- c("HEART ATTACK", "HEART FAILURE", "PNEUMONIA")
  
  ## Check that state and outcome are valid
  if (outcome %in% outcomes == "FALSE") stop("invalid outcome")
  if (state %in% toupper(file$State) == "FALSE") stop("invalid state")
    
    ## Reduce the file so its easier to maintain and make column names the same as outcome
  file <- file[c(2,7,11,17,23)]
  names(file)[1] <- "Hospital"
  names(file)[3] <- "HEART ATTACK"
  names(file)[4] <- "HEART FAILURE"
  names(file)[5] <- "PNEUMONIA"
  
  ##Reduce NA's from file and get only the correct State
  file <- file[file$State == state & file[outcome] != 'Not Available',]
  
  ##Make Variables a numeric
  #file[3:5] <- as.data.frame(sapply(file[3:5], as.numeric))
  
  ## Get the lowest Row
  row <- which.min(file[,outcome])

  ## Return hospital name in that state with lowest 30-day death rate
  file[row, ]$Hospital
  
}