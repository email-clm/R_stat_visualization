#May 21, 2018, R script plotting for SPRUCE modeling paper Figure 9
	
library(RNetCDF)
library(Hmisc)
minor.tick()
getwd()
setwd("/Users/xxuadmin/PEONY_2018Jan/")

# CLM SPRUCE manipulative experiments
# plot the manipulative resutls
library(RNetCDF)
getwd()
setwd("/Users/xxuadmin/PEONY_2018Jan")
ALMSPRUCEt9h0 <- open.nc("ALMSPRUCET9h0.nc")
ALMSPRUCEt9co2h0 <- open.nc("ALMSPRUCET9CO2h0.nc")

ALMSPRUCEt6h0 <- open.nc("ALMSPRUCET6h0.nc")
ALMSPRUCEt6co2h0 <- open.nc("ALMSPRUCET6CO2h0.nc")

ALMSPRUCEt4h0 <- open.nc("ALMSPRUCET4h0.nc")
ALMSPRUCEt4co2h0 <- open.nc("ALMSPRUCET4CO2h0.nc")

ALMSPRUCEt2h0 <- open.nc("ALMSPRUCET2h0.nc")
ALMSPRUCEt2co2h0 <- open.nc("ALMSPRUCET2CO2h0.nc")

ALMSPRUCEt0h0 <- open.nc("ALMSPRUCET0h0.nc")
ALMSPRUCEt0co2h0 <- open.nc("ALMSPRUCET0CO2h0.nc")

sd = 5110
ed = 7300

# reading ch4 flux
ALMSPRUCEt9h0ch4 <- var.get.nc(ALMSPRUCEt9h0,"CH4_SURF_NETFLUX")
ALMSPRUCEt9co2h0ch4 <- var.get.nc(ALMSPRUCEt9co2h0,"CH4_SURF_NETFLUX")

ALMSPRUCEt6h0ch4 <- var.get.nc(ALMSPRUCEt6h0,"CH4_SURF_NETFLUX")
ALMSPRUCEt6co2h0ch4 <- var.get.nc(ALMSPRUCEt6co2h0,"CH4_SURF_NETFLUX")

ALMSPRUCEt4h0ch4 <- var.get.nc(ALMSPRUCEt4h0,"CH4_SURF_NETFLUX")
ALMSPRUCEt4co2h0ch4 <- var.get.nc(ALMSPRUCEt4co2h0,"CH4_SURF_NETFLUX")

ALMSPRUCEt2h0ch4 <- var.get.nc(ALMSPRUCEt2h0,"CH4_SURF_NETFLUX")
ALMSPRUCEt2co2h0ch4 <- var.get.nc(ALMSPRUCEt2co2h0,"CH4_SURF_NETFLUX")

ALMSPRUCEt0h0ch4 <- var.get.nc(ALMSPRUCEt0h0,"CH4_SURF_NETFLUX")
ALMSPRUCEt0co2h0ch4 <- var.get.nc(ALMSPRUCEt0co2h0,"CH4_SURF_NETFLUX")

#Warming + CO2
timeseriesch4 <- function() {
  day=c(5475:6205) #day=c(4745:5175)
  slice = 5475:6205
  plot(c(5475-5475,6205-5475),c(-5e-8,3.5e-7),type="n",xlim=c(0,730),xlab=expression("Days Since Manipulation"),ylab=expression("CH"[4]*" flux (molC/m"^2*"/second)"),cex=2,las=0,cex.lab=1.5,cex.axis=1.5)
  lines(day-5475,ALMSPRUCEt9h0ch4[1,slice],col="blue",lwd=2)
#  lines(day-5475,ALMSPRUCEt6h0ch4[1,slice],col="green",lwd=1)
#  lines(day-5475,ALMSPRUCEt4h0ch4[1,slice],col="darkblue",lwd=1)
#  lines(day-5475,ALMSPRUCEt2h0ch4[1,slice],col="black",lwd=1)
  lines(day-5475,ALMSPRUCEt0h0ch4[1,slice],col="grey36",lwd=5)
  lines(day-5475,ALMSPRUCEt0co2h0ch4[1,slice],col="darkred",lwd=1)
  lines(day-5475,ALMSPRUCEt9h0ch4[1,slice] - ALMSPRUCEt0h0ch4[1,slice],col="red",lwd=2)
  lines(day-5475,ALMSPRUCEt0co2h0ch4[1,slice] - ALMSPRUCEt0h0ch4[1,slice],col="darkgreen",lwd=2)
  legend((280),3.65e-7,c("9 C","0 C",expression("0 C + eCO"[2]*""),"warming",expression("eCO"[2]*"")),lty=c(1,1),lwd=c(2.5,2.5),col=c("brown2","grey","burlywood4","darkred","darkgreen"),cex=1.5)
}
pdf("ALMSPRUCECH4Flux_t_gradient.pdf",width=10,height=6)
par(mai=c(1,1,0.4,0.4))
timeseriesch4()
minor.tick(nx=5,ny=5,tick.ratio=0.5,x.args=list(),y.args=list())
dev.off()

a = sum(ALMSPRUCEt9h0ch4[1,slice])
b = sum(ALMSPRUCEt0h0ch4[1,slice])
c = sum(ALMSPRUCEt0co2h0ch4[1,slice])
