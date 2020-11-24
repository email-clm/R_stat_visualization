# credit: https://magesblog.com/post/2012-03-17-logistic-map-feigenbaum-diagram/
# Xiaofeng Xu Nov 24 2020
logistic.map <- function(r, x, N, M){
  ## r: bifurcation parameter
  ## x: initial value
  ## N: number of iteration
  ## M: number of iteration points to be returned
  z <- 1:N
  z[1] <- x
  for(i in c(1:(N-1))){
    z[i+1] <- r *z[i]  * (1 - z[i])
  }
  ## Return the last M iterations 
  z[c((N-M):N)]
}

## Set scanning range for bifurcation parameter r
my.r <- seq(1.0, 4, by=0.001)
system.time(Orbit <- sapply(my.r, logistic.map,  x=0.1, N=1000, M=300))
## record the time for this computing.

Orbit <- as.vector(Orbit)
r <- sort(rep(my.r, 301))

# plot the logistic map
plot(Orbit ~ r, pch=".")
