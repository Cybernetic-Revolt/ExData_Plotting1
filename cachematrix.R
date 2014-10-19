makeCacheMatrix <- function(x = matrix()) {
  
  ## Initialize Inverse
  m<-NULL 
  
  ## Set the Matrix
  set<-function(y){
    x<<-y
    m<<-NULL
  }
  
  ## Get Matrix 
  get<-function() x
  
  ## Set inverse Matrix
  setmatrix<-function(solve) m<<- solve
  
  ## Get inverse Matrix 
  getmatrix<-function() m
  
  ## Return List
  list(set=set, get=get,
       setmatrix=setmatrix,
       getmatrix=getmatrix)
}

cacheSolve <- function(x=matrix(), ...) {

  ## Return Matrix that is invesse of x
  m<-x$getmatrix()
  
  ## Return Matrix if its set
  if(!is.null(m)){
    message("getting cached data")
    return(m)
  }
  
  ## Get Matrix from the object
  matrix<-x$get()  ## insure not to coherse
  
  ## Calculate inverse
  m<-solve(matrix, ...)
  
  ## Now Set the inverse Matrix
  x$setmatrix(m)
  
  ## Display the matrix
  m
}
