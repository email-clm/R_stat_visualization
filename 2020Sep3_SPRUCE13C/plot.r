#setwd("./")
#Xiaofeng Xu plot the 13C data of S1 bog on Sep 3, 2020
rm(list=ls())
data <- read.csv("Peat_Characteristics_T0_20180425_plot.csv")
attach(data)

pdf("13C_spruce.pdf")
par(mar = c(6,6,1,1) + 0.2)
par(mgp = c(3.5,1,0))
plot(X13CLLNL, Depth, xlab="Delta 13C",ylab = "Depth (cm)", xlim=c(-30,-25),ylim=c(-300,25), cex=1.5,las=1,cex.lab=1.25,cex.axis=1.25,font.lab=2)
lines(X13C_ave, Depth_ave, col="red",lwd="2")
legend(-30, -240, 
       legend = c("      Observed data"), 
       pch = c(1), 
       bty = "n", 
       pt.cex = 1.5, 
       cex = 1.2, 
       text.col = "black")
legend(-30, -260, 
       legend = c("Mean"), 
       lty =c(1), 
       lwd = 2, 
       bty="n", 
       col = "red", 
       pt.cex = 1.5, 
       cex = 1.2, 
       text.col = "black")
dev.off()

