## vreate inverse matrix and save in cache inverse matrix

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


## find inverse matrix and return by makeCacheMatrix
## if the inverse already calculate, then getInverse.
cacheSolve = function(x,...){
  ##return inverse matrix of x
  inverse <- x$getInverse()
  if(!is.null(inverse)) {
    message("getting cached data")
    return(inverse)
  }
  data <- x$get()
  inverse <- solve(data, ...)
  x$setInverse(inverse)
  inverse

}
