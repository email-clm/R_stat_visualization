https://stackoverflow.com/questions/11777124/three-way-color-gradient-fill-in-r

#works well, but slow

plot(NA,NA,xlim=c(0,1),ylim=c(0,1),asp=1,bty="n",axes=F,xlab="",ylab="")
segments(0,0,0.5,sqrt(3)/2)
segments(0.5,sqrt(3)/2,1,0)
segments(1,0,0,0)
# sm - how smooth the plot is. Higher values will plot very slowly
sm <- 500
for (y in 1:(sm*sqrt(3)/2)/sm){
    for (x in (y*sm/sqrt(3)):(sm-y*sm/sqrt(3))/sm){
        ## distance from base line:
        d.red = y
        ## distance from line y = sqrt(3) * x:
        d.green = abs(sqrt(3) * x - y) / sqrt(3 + 1)
        ## distance from line y = - sqrt(3) * x + sqrt(3):
        d.blue = abs(- sqrt(3) * x - y + sqrt(3)) / sqrt(3 + 1)
        points(x, y, col=rgb(1-d.red,1 - d.green,1 - d.blue), pch=19)
    }
}

# works well and fast
plot(NA,NA,xlim=c(0,1),ylim=c(0,1),asp=1,bty="n",axes=F,xlab="",ylab="")
sm <- 500
x <- do.call(c, sapply(1:(sm*sqrt(3)/2)/sm, 
                       function(i) (i*sm/sqrt(3)):(sm-i*sm/sqrt(3))/sm))
y <- do.call(c, sapply(1:(sm*sqrt(3)/2)/sm, 
                       function(i) rep(i, length((i*sm/sqrt(3)):(sm-i*sm/sqrt(3))))))
d.red = y
d.green = abs(sqrt(3) * x - y) / sqrt(3 + 1)
d.blue = abs(- sqrt(3) * x - y + sqrt(3)) / sqrt(3 + 1)
points(x, y, col=rgb(1-d.red,1 - d.green,1 - d.blue), pch=19)


# Coordinates of the triangle
tri <- rbind(sin(0:2*2/3*pi), cos(0:2*2/3*pi))

# Function for calculating the color of a set of points `pt`
# in relation to the triangle
tricol <- function(pt, sharpness=2){
    require(splancs)
    RGB <- sapply(1:3, function(i){
        a <- sweep(pt, 2, tri[,i])
        b <- apply(tri[,-i], 1, mean) - tri[,i]
        sharpness*((a %*% b) / sum(b^2))-sharpness+1
    })
    RGB[-inpip(pt,t(tri)),] <- 1    # Color points outside the triangle white
    do.call(rgb, unname(as.data.frame(pmin(pmax(RGB, 0), 1))))
}

# Plot
res <- 1000                         # Resolution
xi <- seq(-1, 1, length=res)        # Axis points
yi <- seq(-.8, 1.2, length=res)
x <- xi[1] + cumsum(diff(xi))       # Midpoints between axis points
y <- yi[1] + cumsum(diff(yi))
xy <- matrix(1:(length(x)*length(y)), length(x))
image(xi, yi, xy, col=tricol(as.matrix(expand.grid(x,y))), useRaster=TRUE)
lines(tri[1,c(1:3,1)], tri[2,c(1:3,1)], type="l")

