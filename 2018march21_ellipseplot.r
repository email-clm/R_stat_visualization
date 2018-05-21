# March 21, 2018 for Dona'a paper in Arctic C 
library(ellipse)
library(ggplot2)
library(car)
setwd("/Users/xxuadmin/BUSINESS/PUBLICATIONS/WorkingOn_Zona_SnowC/20180315_plot")
obs <- read.table("obdata",header=TRUE)
attach(obs)
library(Hmisc)
minor.tick()

pdf("Figure3a.pdf")
par(mai=c(1.25,1,0.9,0.8))
plot(-1000,-1000, xlim=c(-200,0), ylim=c(0,40),xlab=expression("Cum C Jun-Aug (g C-CO"[2]*" m"^-2*")"), ylab=expression('Cum C Sep (gC-CO'[2]*' m'^-2*")"), cex=1,las=1, cex.lab = 1.5, cex.axis = 1.5)
minor.tick(nx=4,ny=4,tick.ratio=0.5,x.args=list(),y.args=list())
Atq <- obs[which(obs$Site=='Atq'),]
dataEllipse(Atq$GS,Atq$SEP,levels=c(0.32), center.pch=0, ellipse.label="US-Atq", plot.points = FALSE,add=TRUE,col="darkgreen")
Bes <- obs[which(obs$Site=='Bes'),]
dataEllipse(Bes$GS,Bes$SEP,levels=c(0.32), center.pch=0, ellipse.label="US-Bes", plot.points = FALSE,add=TRUE,col="darkmagenta")
DL1 <- obs[which(obs$Site=='DL1'),]
dataEllipse(DL1$GS,DL1$SEP,levels=c(0.32), center.pch=0, ellipse.label="CA-DL1", plot.points = FALSE,add=TRUE,col="lightcoral")
ZaH <- obs[which(obs$Site=='ZaH'),]
dataEllipse(ZaH$GS,ZaH$SEP,levels=c(0.32), center.pch=0, ellipse.label="US-ZaH", plot.points = FALSE,add=TRUE,col="darkred")
Ict <- obs[which(obs$Site=='Ict'),]
dataEllipse(Ict$GS,Ict$SEP,levels=c(0.32), center.pch=0, ellipse.label="US-Ict", plot.points = FALSE,add=TRUE,col="navy")
Ivo <- obs[which(obs$Site=='Ivo'),]
dataEllipse(Ivo$GS,Ivo$SEP,levels=c(0.32), center.pch=0, ellipse.label="US-Ivo", plot.points = FALSE,add=TRUE,col="purple")
Che <- obs[which(obs$Site=='Che'),]
dataEllipse(Che$GS,Che$SEP,levels=c(0.32), center.pch=0, ellipse.label="US-Che", plot.points = FALSE,add=TRUE,col="blue")
CoK <- obs[which(obs$Site=='CoK'),]
dataEllipse(CoK$GS,CoK$SEP,levels=c(0.32), center.pch=0, ellipse.label="RU-CoK", plot.points = FALSE,add=TRUE,col="black")
Sam <- obs[which(obs$Site=='Sam'),]
dataEllipse(Sam$GS,Sam$SEP,levels=c(0.32), center.pch=0, ellipse.label="RU-Sam", plot.points = FALSE,add=TRUE,col="red")
dev.off()

hrt <- read.table("HRTemperature",header=TRUE)
attach(hrt)

pdf("Figure3b.pdf")
par(mai=c(1.25,1,0.9,0.8))
plot(-1000,-1000, xlim=c(-2,8), ylim=c(0,40),xlab=expression("Sep Soil Temperature ("^o*"C)"), ylab=expression('Cum C Sep (gC-CO'[2]*' m'^-2*")"), cex=1,las=1, cex.lab = 1.5, cex.axis = 1.5)
minor.tick(nx=4,ny=4,tick.ratio=0.5,x.args=list(),y.args=list())
Atq <- hrt[which(hrt$Site=='Atq'),]
dataEllipse(Atq$soilT,Atq$sepHR,levels=c(0.32), center.pch=0, ellipse.label="US-Atq", plot.points = FALSE,add=TRUE,col="darkgreen")
Bes <- hrt[which(hrt$Site=='Bes'),]
dataEllipse(Bes$soilT,Bes$sepHR,levels=c(0.32), center.pch=0, ellipse.label="US-Bes", plot.points = FALSE,add=TRUE,col="darkmagenta")
DL1 <- hrt[which(hrt$Site=='DL1'),]
dataEllipse(DL1$soilT,DL1$sepHR,levels=c(0.32), center.pch=0, ellipse.label="CA-DL1", plot.points = FALSE,add=TRUE,col="lightcoral")
ZaH <- hrt[which(hrt$Site=='ZaH'),]
dataEllipse(ZaH$soilT,ZaH$sepHR,levels=c(0.32), center.pch=0, ellipse.label="US-ZaH", plot.points = FALSE,add=TRUE,col="darkred")
Ict <- hrt[which(hrt$Site=='Ict'),]
dataEllipse(Ict$soilT,Ict$sepHR,levels=c(0.32), center.pch=0, ellipse.label="US-Ict", plot.points = FALSE,add=TRUE,col="navy")
Ivo <- hrt[which(hrt$Site=='Ivo'),]
dataEllipse(Ivo$soilT,Ivo$sepHR,levels=c(0.32), center.pch=0, ellipse.label="US-Ivo", plot.points = FALSE,add=TRUE,col="purple")
Che <- hrt[which(hrt$Site=='Che'),]
dataEllipse(Che$soilT,Che$sepHR,levels=c(0.32), center.pch=0, ellipse.label="US-Che", plot.points = FALSE,add=TRUE,col="blue")
CoK <- hrt[which(hrt$Site=='CoK'),]
dataEllipse(CoK$soilT,CoK$sepHR,levels=c(0.32), center.pch=0, ellipse.label="RU-CoK", plot.points = FALSE,add=TRUE,col="black")
Sam <- hrt[which(hrt$Site=='Sam'),]
dataEllipse(Sam$soilT,Sam$sepHR,levels=c(0.32), center.pch=0, ellipse.label="RU-Sam", plot.points = FALSE,add=TRUE,col="red")
dev.off()





library(ellipse)
library(ggplot2)
library(car)
setwd("/Users/xxuadmin/BUSINESS/PUBLICATIONS/WorkingOn_Zona_SnowC/20180315_plot")
obs <- read.table("obdata",header=TRUE)
attach(obs)
library(Hmisc)
minor.tick()

pdf("Figure3a2.pdf")
par(mai=c(1.25,1,0.9,0.8))
plot(-1000,-1000, xlim=c(-200,0), ylim=c(0,40),xlab=expression("Cum C Jun-Aug (g C-CO"[2]*" m"^-2*")"), ylab=expression('Cum C Sep (gC-CO'[2]*' m'^-2*")"), cex=1,las=1, cex.lab = 1.5, cex.axis = 1.5)
minor.tick(nx=4,ny=4,tick.ratio=0.5,x.args=list(),y.args=list())
Atq <- obs[which(obs$Site=='Atq'),]
dataEllipse(Atq$GS,Atq$SEP,levels=c(0.68), center.pch=0, ellipse.label="US-Atq", plot.points = FALSE,add=TRUE,col="darkgreen")
Bes <- obs[which(obs$Site=='Bes'),]
dataEllipse(Bes$GS,Bes$SEP,levels=c(0.68), center.pch=0, ellipse.label="US-Bes", plot.points = FALSE,add=TRUE,col="darkmagenta")
DL1 <- obs[which(obs$Site=='DL1'),]
dataEllipse(DL1$GS,DL1$SEP,levels=c(0.68), center.pch=0, ellipse.label="CA-DL1", plot.points = FALSE,add=TRUE,col="lightcoral")
ZaH <- obs[which(obs$Site=='ZaH'),]
dataEllipse(ZaH$GS,ZaH$SEP,levels=c(0.68), center.pch=0, ellipse.label="US-ZaH", plot.points = FALSE,add=TRUE,col="darkred")
Ict <- obs[which(obs$Site=='Ict'),]
dataEllipse(Ict$GS,Ict$SEP,levels=c(0.68), center.pch=0, ellipse.label="US-Ict", plot.points = FALSE,add=TRUE,col="navy")
Ivo <- obs[which(obs$Site=='Ivo'),]
dataEllipse(Ivo$GS,Ivo$SEP,levels=c(0.68), center.pch=0, ellipse.label="US-Ivo", plot.points = FALSE,add=TRUE,col="purple")
Che <- obs[which(obs$Site=='Che'),]
dataEllipse(Che$GS,Che$SEP,levels=c(0.68), center.pch=0, ellipse.label="US-Che", plot.points = FALSE,add=TRUE,col="blue")
CoK <- obs[which(obs$Site=='CoK'),]
dataEllipse(CoK$GS,CoK$SEP,levels=c(0.68), center.pch=0, ellipse.label="RU-CoK", plot.points = FALSE,add=TRUE,col="black")
Sam <- obs[which(obs$Site=='Sam'),]
dataEllipse(Sam$GS,Sam$SEP,levels=c(0.68), center.pch=0, ellipse.label="RU-Sam", plot.points = FALSE,add=TRUE,col="red")
dev.off()

hrt <- read.table("HRTemperature",header=TRUE)
attach(hrt)

pdf("Figure3b2.pdf")
par(mai=c(1.25,1,0.9,0.8))
plot(-1000,-1000, xlim=c(-2,8), ylim=c(0,40),xlab=expression("Sep Soil Temperature ("^o*"C)"), ylab=expression('Cum C Sep (gC-CO'[2]*' m'^-2*")"), cex=1,las=1, cex.lab = 1.5, cex.axis = 1.5)
minor.tick(nx=4,ny=4,tick.ratio=0.5,x.args=list(),y.args=list())
Atq <- hrt[which(hrt$Site=='Atq'),]
dataEllipse(Atq$soilT,Atq$sepHR,levels=c(0.68), center.pch=0, ellipse.label="US-Atq", plot.points = FALSE,add=TRUE,col="darkgreen")
Bes <- hrt[which(hrt$Site=='Bes'),]
dataEllipse(Bes$soilT,Bes$sepHR,levels=c(0.68), center.pch=0, ellipse.label="US-Bes", plot.points = FALSE,add=TRUE,col="darkmagenta")
DL1 <- hrt[which(hrt$Site=='DL1'),]
dataEllipse(DL1$soilT,DL1$sepHR,levels=c(0.68), center.pch=0, ellipse.label="CA-DL1", plot.points = FALSE,add=TRUE,col="lightcoral")
ZaH <- hrt[which(hrt$Site=='ZaH'),]
dataEllipse(ZaH$soilT,ZaH$sepHR,levels=c(0.68), center.pch=0, ellipse.label="US-ZaH", plot.points = FALSE,add=TRUE,col="darkred")
Ict <- hrt[which(hrt$Site=='Ict'),]
dataEllipse(Ict$soilT,Ict$sepHR,levels=c(0.68), center.pch=0, ellipse.label="US-Ict", plot.points = FALSE,add=TRUE,col="navy")
Ivo <- hrt[which(hrt$Site=='Ivo'),]
dataEllipse(Ivo$soilT,Ivo$sepHR,levels=c(0.68), center.pch=0, ellipse.label="US-Ivo", plot.points = FALSE,add=TRUE,col="purple")
Che <- hrt[which(hrt$Site=='Che'),]
dataEllipse(Che$soilT,Che$sepHR,levels=c(0.68), center.pch=0, ellipse.label="US-Che", plot.points = FALSE,add=TRUE,col="blue")
CoK <- hrt[which(hrt$Site=='CoK'),]
dataEllipse(CoK$soilT,CoK$sepHR,levels=c(0.68), center.pch=0, ellipse.label="RU-CoK", plot.points = FALSE,add=TRUE,col="black")
Sam <- hrt[which(hrt$Site=='Sam'),]
dataEllipse(Sam$soilT,Sam$sepHR,levels=c(0.68), center.pch=0, ellipse.label="RU-Sam", plot.points = FALSE,add=TRUE,col="red")
dev.off()



# blow for modeling
ibrary(RNetCDF)
library(ellipse)
library(ggplot2)
library(car)
library(Hmisc)
minor.tick()
setwd("/Users/xxuadmin/BUSINESS/PUBLICATIONS/WorkingOn_Zona_SnowC/20180315_plot")
data <- open.nc("12yearCarbonFlux.nc")
GS_NEP <- var.get.nc(data,"GS_NEP")
SEP_HR <- var.get.nc(data,"SEP_HR")
SEP_TSOI <- var.get.nc(data,"SEP_TSOI")

pdf("Figure3c.pdf")
par(mai=c(1.25,1,0.9,0.8))
plot(-1000,-1000, xlim=c(-200,0), ylim=c(0,40),xlab=expression("Cum C Jun-Aug (g C-CO"[2]*" m"^-2*")"), ylab=expression('Cum C Sep (gC-CO'[2]*' m'^-2*")"), cex=1,las=1, cex.lab = 1.5, cex.axis = 1.5)
minor.tick(nx=4,ny=4,tick.ratio=0.5,x.args=list(),y.args=list())
for(ii in 1:144) 
{
  for(jj in 1:16)
  {
   if (!is.na(GS_NEP[1,ii,jj]) && SEP_HR[1,ii,jj] > 0.0)
        dataEllipse(GS_NEP[,ii,jj],SEP_HR[,ii,jj],levels=c(0.32), center.pch=0, plot.points = FALSE,add=TRUE,col="#555555")
  }
}
dev.off()

pdf("Figure3d.pdf")
par(mai=c(1.25,1,0.9,0.8))
plot(-1000,-1000, xlim=c(-2,8), ylim=c(0,40),xlab=expression("Sep Soil Temperature ("^o*"C)"), ylab=expression('Cum C Sep (gC-CO'[2]*' m'^-2*")"), cex=1,las=1, cex.lab = 1.5, cex.axis = 1.5)
minor.tick(nx=4,ny=4,tick.ratio=0.5,x.args=list(),y.args=list())
for(ii in 1:144) 
{
  for(jj in 1:16)
  {
    if (!is.na(GS_NEP[1,ii,jj]) && SEP_HR[1,ii,jj] > 0.0)
      dataEllipse((SEP_TSOI[,ii,jj]-273.15),SEP_HR[,ii,jj],levels=c(0.32), center.pch=0, plot.points = FALSE,add=TRUE,col="#555555")
  }
}
dev.off()


colfunc <- colorRampPalette(c("black", "white"))
colfunc(10)





pdf("Figure3c2.pdf")
par(mai=c(1.25,1,0.9,0.8))
plot(-1000,-1000, xlim=c(-200,0), ylim=c(0,40),xlab=expression("Cum C Jun-Aug (g C-CO"[2]*" m"^-2*")"), ylab=expression('Cum C Sep (gC-CO'[2]*' m'^-2*")"), cex=1,las=1, cex.lab = 1.5, cex.axis = 1.5)
minor.tick(nx=4,ny=4,tick.ratio=0.5,x.args=list(),y.args=list())
for(ii in 1:144) 
{
  for(jj in 1:16)
  {
    if (!is.na(GS_NEP[1,ii,jj]) && SEP_HR[1,ii,jj] > 0.0)
      dataEllipse(GS_NEP[,ii,jj],SEP_HR[,ii,jj],levels=c(0.68), center.pch=0, plot.points = FALSE,add=TRUE,col="#555555")
  }
}
dev.off()

pdf("Figure3d2.pdf")
par(mai=c(1.25,1,0.9,0.8))
plot(-1000,-1000, xlim=c(-2,8), ylim=c(0,40),xlab=expression("Sep Soil Temperature ("^o*"C)"), ylab=expression('Cum C Sep (gC-CO'[2]*' m'^-2*")"), cex=1,las=1, cex.lab = 1.5, cex.axis = 1.5)
minor.tick(nx=4,ny=4,tick.ratio=0.5,x.args=list(),y.args=list())
for(ii in 1:144) 
{
  for(jj in 1:16)
  {
    if (!is.na(GS_NEP[1,ii,jj]) && SEP_HR[1,ii,jj] > 0.0)
      dataEllipse((SEP_TSOI[,ii,jj]-273.15),SEP_HR[,ii,jj],levels=c(0.68), center.pch=0, plot.points = FALSE,add=TRUE,col="#555555")
  }
}
dev.off()


colfunc <- colorRampPalette(c("black", "white"))
colfunc(10)

