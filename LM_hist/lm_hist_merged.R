# r script to plot linear regression with histgram for both X and Y variables
# data used in the plot is from Xu, X., Hui, D., King, A. W., Song, X., Thornton, P. E., & Zhang, L. H. (2015). Convergence of microbial assimilations of soil carbon, nitrogen, phosphorus, and sulfur in terrestrial ecosystems. Scientific Reports, 5, 17445-17454. 

setwd("/Users/xxuadmin/BUSINESS/PUBLICATIONS/WorkingOn_XuXF_labileC/r")
smc <- read.csv("logSOC_logSMC.csv",header=TRUE)
minoc <- min(smc$Log.OC)
maxoc <- max(smc$Log.OC)

minsmc <- min(smc$Log.SMC)
maxsmc <- max(smc$Log.SMC)

# NOT RUN {
def.par <- par(no.readonly = TRUE) # save default, for resetting...
pdf("outout.pdf", 12,12)
## divide the device into two rows and two columns
## allocate figure 1 all of row 1
## allocate figure 2 the intersection of column 2 and row 2
layout(matrix(c(1,1,0,2), 2, 2, byrow = TRUE))
## show the regions that have been allocated to each plot
layout.show(2)

## divide device into two rows and two columns
## allocate figure 1 and figure 2 as above
## respect relations between widths and heights
nf <- layout(matrix(c(1,1,0,2), 2, 2, byrow = TRUE), respect = TRUE)
layout.show(nf)

## create single figure which is 5cm square
nf <- layout(matrix(1), widths = lcm(5), heights = lcm(5))
layout.show(nf)

##-- Create a scatterplot with marginal histograms -----
xhist <- hist(smc$Log.OC, breaks = seq(0, 5, 0.25), plot = FALSE)
yhist <- hist(smc$Log.SMC, breaks = seq(-2, 4, 0.25), plot = FALSE)
top <- max(c(xhist$counts, yhist$counts))
xrange <- c(0.5, 5.0)
yrange <- c(-1.5, 3.5)
nf <- layout(matrix(c(2,0,1,3),2,2,byrow = TRUE), c(3,1), c(1,3), TRUE)
layout.show(nf)

par(mar = c(5,5,1,1))
plot(smc$Log.OC, smc$Log.SMC, xlim = xrange, ylim = yrange, xlab = expression("log10-soil organic C (gC m"^-2*")"), ylab = expression("log10-microbial biomass C (gC m"^-2*")"), cex = 1, cex.lab=1.5, cex.axis=1.5, font.lab=3)
abline(lm(smc$Log.SMC~smc$Log.OC), col="RED", lwd=2)
# add the fitted line in red

par(mar = c(0,3,1,1))
barplot(xhist$counts, axes = FALSE, ylim = c(0, top), space = 0)
par(mar = c(3,0,1,1))
barplot(yhist$counts, axes = FALSE, xlim = c(0, top), space = 0, horiz = TRUE)
dev.off()

par(def.par)  #- reset to default
# }
