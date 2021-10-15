# The r script for processing NEON data of root carbon and nitrogen concentration data October 15, 2021; the data were compiled by Andrew Zhang and Michael Bao.
# xxu@sdsu.edu

setwd("/Users/xxuadmin/BUSINESS/CONFERENCES/2022_biogeography/WorkingOn_Andrew_Michael/NEON")
library("")
root <- read.table("data.txt", header=TRUE)
summary(lm(root$Latitude~root$d15N))
summary(lm(root$Latitude~root$d13C))
summary(lm(root$Latitude~root$nitrogenPercent))
summary(lm(root$Latitude~root$carbonPercent))
summary(lm(root$Latitude~root$CNratio))
summary(lm(root$d15N~root$MAT+root$MAP+root$SOC+root$clayTotal+root$phH2o+root$NPP))
summary(lm(root$d13C~root$MAT+root$MAP+root$SOC+root$clayTotal+root$phH2o+root$NPP))
summary(lm(root$nitrogenPercent~root$MAT+root$MAP+root$SOC+root$clayTotal+root$phH2o+root$NPP))
summary(lm(root$carbonPercent~root$MAT+root$MAP+root$SOC+root$clayTotal+root$phH2o+root$NPP))
summary(lm(root$CNratio~root$MAT+root$MAP+root$SOC+root$clayTotal+root$phH2o+root$NPP))

panel.cor <- function(x, y, digits = 2, cex.cor, ...)
{
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  # correlation coefficient
  r <- cor(x, y)
  txt <- format(c(r, 0.123456789), digits = digits)[1]
  txt <- paste("r= ", txt, sep = "")
  text(0.5, 0.6, txt, cex = 2)
  
  # p-value calculation
  p <- cor.test(x, y)$p.value
  txt2 <- format(c(p, 1.123456789), digits = digits)[1]
  txt2 <- paste("p= ", txt2, sep = "")
  if(p<0.01) txt2 <- paste("p= ", "<0.01", sep = "")
  text(0.5, 0.4, txt2, cex=2)
}

panel.smooth<-function (x, y, col = "blue", bg = NA, pch = 18, 
                        cex = 0.8, col.smooth = "red", span = 2/3, iter = 3, ...) 
{
  points(x, y, pch = pch, col = col, bg = bg, cex = cex)
  ok <- is.finite(x) & is.finite(y)
  if (any(ok)) 
    lines(stats::lowess(x[ok], y[ok], f = span, iter = iter), 
          col = col.smooth, ...)
}

panel.hist <- function(x, ...)
{
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(usr[1:2], 0, 1.5) )
  h <- hist(x, plot = FALSE)
  breaks <- h$breaks; nB <- length(breaks)
  y <- h$counts; y <- y/max(y)
  rect(breaks[-nB], 0, breaks[-1], y, col="cyan", ...)
}

pairs(root[,c(2,4,5,6,7,8)], lower.panel=panel.smooth, upper.panel=panel.cor,diag.panel=panel.hist)

pairs(root[,c(4,9:11,13:14,16:19)], lower.panel=panel.smooth, upper.panel=panel.cor,diag.panel=panel.hist)

pairs(root[,c(5,9:11,13:14,16:19)], lower.panel=panel.smooth, upper.panel=panel.cor,diag.panel=panel.hist)

pairs(root[,c(6,9:11,13:14,16:19)], lower.panel=panel.smooth, upper.panel=panel.cor,diag.panel=panel.hist)

pairs(root[,c(7,9:11,13:14,16:19)], lower.panel=panel.smooth, upper.panel=panel.cor,diag.panel=panel.hist)

pairs(root[,c(8,9:11,13:14,16:19)], lower.panel=panel.smooth, upper.panel=panel.cor,diag.panel=panel.hist)


