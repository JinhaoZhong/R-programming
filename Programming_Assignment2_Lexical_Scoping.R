makeCacheMatrix = function (x=matrix){
  inverse = NULL
  set = function(y) {
    x <<- y
    i <<- NULL
  }
  tmp <- function() x
  setInverse <- function(solveMatrix) inverse <<- solveMatrix
  getInverse <- function() inverse
  list(set = set, get = get, setInverse = setInverse, getInverse = getInverse)
}



cacheSolve = function(x,...){
  inverse <- x$getmean()
  if(!is.null(inverse)) {
    message("getting cached data")
    return(inverse)
  }
  data <- x$get()
  inverse <- solve(data, ...)
  x$setInverse(inverse)
  inverse

}