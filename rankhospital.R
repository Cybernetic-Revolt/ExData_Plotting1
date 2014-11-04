rankhospital <- function(state, outcome, num) {
  
  ## Read outcome data
  file <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Make everything uppercase
  outcome <- toupper(outcome)
  state <- toupper(state)
  
  
  ## Valid Outcomes
  outcomes <- c("HEART ATTACK", "HEART FAILURE", "PNEUMONIA")
  
  ## Check that state, outcome  and num are valid
  if (outcome %in% outcomes == "FALSE") stop("invalid outcome")
  if (state %in% toupper(file$State) == "FALSE") stop("invalid state")
  if (num != "best" && num != "worst" && num%%1 != 0) stop("invalid num")
  
  ## Reduce the file so its easier to maintain and make column names the same as the outcome variable
  file <- file[c(2,7,11,17,23)]
  names(file)[1] <- "Hospital"
  names(file)[3] <- "HEART ATTACK"
  names(file)[4] <- "HEART FAILURE"
  names(file)[5] <- "PNEUMONIA"
  
  ## Reduce NA's from file and get only the correct State
  file <- file[file$State == state & file[outcome] != 'Not Available',]
  
  ## Change to numeric Values
  file[outcome] <- as.data.frame(sapply(file[outcome], as.numeric))
  
  ## start Sorting - Hospital name first, then Values
  file <- file[order(file$Hospital, decreasing = FALSE), ]
  file <- file[order(file[outcome], decreasing = FALSE), ]
  
  ## Find Hospital
  
  rows <- file[,outcome]
  
  if( num == "best" ) {
    rownumber <- which.min(rows)
  } else if( num == "worst" ) {
    rownumber <- which.max(rows)
  } else {
    rownumber <- num
  }
  
  file[rownumber, ]$Hospital
}
  
  