#change the work space
setwd("C:\\Users\\xiaofeng\\Dropbox\\temp")
#load the library for processing netcdf files
library(RNetCDF)
out <- create.nc("Global_Soil_Microbeial_BiomassCN.nc",clobber=TRUE)
 dim.def.nc(out,"lat",360)
 dim.def.nc(out,"lon",720)
 var.def.nc(out,"lat","NC_FLOAT","lat")
 var.def.nc(out,"lon","NC_FLOAT","lon")
#define variable of C, N in 30cm and 100cm along soil pofile
 var.def.nc(out,"SMC30cm","NC_FLOAT",c("lon","lat"))
 var.def.nc(out,"SMN30cm","NC_FLOAT",c("lon","lat"))
 var.def.nc(out,"SMC100cm","NC_FLOAT",c("lon","lat"))
 var.def.nc(out,"SMN100cm","NC_FLOAT",c("lon","lat"))
 var.def.nc(out,"CN30cm","NC_FLOAT",c("lon","lat"))
 var.def.nc(out,"CN100cm","NC_FLOAT",c("lon","lat"))
#read in the origional data    
smc30cm <- open.nc("smc30cm.nc") 
smn30cm <- open.nc("smn30cm.nc") 
smc100cm <- open.nc("smc100cm.nc") 
smn100cm <- open.nc("smn100cm.nc") 

c30cm <- var.get.nc(smc30cm,"SMC30cmFinal",c(1,1),c(720,360),na.mode=0)
n30cm <- var.get.nc(smn30cm,"SMN30cmFinal",c(1,1),c(720,360),na.mode=0)
c100cm <- var.get.nc(smc100cm,"SMC100cmFinal",c(1,1),c(720,360),na.mode=0)
n100cm <- var.get.nc(smn100cm,"SMN100cmFinal",c(1,1),c(720,360),na.mode=0)
cn30cm <- array(NA,c(720,360))
cn100cm <- array(NA,c(720,360))

for (i in 1:720)	{
 for (j in 1:360) {
  if(is.na(c30cm[i,j]) == TRUE) {
  c30cm[i,j] = -9999  }
  if(is.na(n30cm[i,j]) == TRUE) {
  n30cm[i,j] = -9999  }
  if(is.na(c100cm[i,j]) == TRUE) {
  c100cm[i,j] = -9999 }
  if(is.na(n100cm[i,j]) == TRUE) {
  n100cm[i,j] = -9999  }
  if(c30cm[i,j] < 0) cn30cm[i,j] = -9999
  else
  {
  cn30cm[i,j] = c30cm[i,j] / n30cm[i,j]
  }
  if(c100cm[i,j] < 0) cn100cm[i,j] = -9999
  else
  {
  cn100cm[i,j] = c100cm[i,j] / n100cm[i,j]
  } 
 }
}

att.put.nc(out,"SMC30cm","missing_value","NC_FLOAT",-9999)
var.put.nc(out,"SMC30cm",c30cm,c(1,1),c(720,360))

att.put.nc(out,"SMN30cm","missing_value","NC_FLOAT",-9999)
var.put.nc(out,"SMN30cm",n30cm,c(1,1),c(720,360))

att.put.nc(out,"SMC100cm","missing_value","NC_FLOAT",-9999)
var.put.nc(out,"SMC100cm",c100cm,c(1,1),c(720,360))

att.put.nc(out,"SMN100cm","missing_value","NC_FLOAT",-9999)
var.put.nc(out,"SMN100cm",n100cm,c(1,1),c(720,360))

att.put.nc(out,"CN30cm","missing_value","NC_FLOAT",-9999)
var.put.nc(out,"CN30cm",cn30cm,c(1,1),c(720,360))

att.put.nc(out,"CN100cm","missing_value","NC_FLOAT",-9999)
var.put.nc(out,"CN100cm",cn100cm,c(1,1),c(720,360))

latvalue = seq(89.75,-89.75,by = -0.5)
lonvalue = seq(-179.75,179.75,by=0.5)
var.put.nc(out,"lat",latvalue,1,NA)
var.put.nc(out,"lon",lonvalue,1,NA)

var.put.nc(out,"SMC30cm",c30cm,c(1,1),c(720,360))
var.put.nc(out,"SMN30cm",n30cm,c(1,1),c(720,360))
var.put.nc(out,"SMC100cm",c100cm,c(1,1),c(720,360))
var.put.nc(out,"SMN100cm",n100cm,c(1,1),c(720,360))
var.put.nc(out,"CN30cm",cn30cm,c(1,1),c(720,360))
var.put.nc(out,"CN100cm",cn100cm,c(1,1),c(720,360))

att.put.nc(out,"NC_GLOBAL","title","NC_CHAR","Global Dataset of Soil Microbial Biomass Carbon and Nitrogen")
att.put.nc(out,"NC_GLOBAL","reference","NC_CHAR","Xu, X., Thornton, P. E. and Post, W. M. (2013), A global analysis of soil microbial biomass carbon, nitrogen and phosphorus in terrestrial ecosystems. Global Ecology and Biogeography, 22: 737–749. doi: 10.1111/geb.12029")
att.put.nc(out,"NC_GLOBAL","contact","NC_CHAR","Xiaofeng Xu: xux4@ornl.gov, xuxfmail@gmail.com")
att.put.nc(out,"SMC30cm","long_name","NC_CHAR","soil microbial biomass carbon in top 30cm soil profile")
att.put.nc(out,"SMN30cm","long_name","NC_CHAR","soil microbial biomass nitrogen in top 30cm soil profile")
att.put.nc(out,"SMC100cm","long_name","NC_CHAR","soil microbial biomass carbon in top 100cm soil profile")
att.put.nc(out,"SMN100cm","long_name","NC_CHAR","soil microbial biomass nitrogen in top 100cm soil profile")
att.put.nc(out,"CN30cm","long_name","NC_CHAR","C:N ratio of soil microbial biomass in top 30cm soil profile")
att.put.nc(out,"CN100cm","long_name","NC_CHAR","C:N ratio of soil microbial biomass in top 100cm soil profile")
att.put.nc(out,"SMC30cm","unit","NC_CHAR","gC/m2")
att.put.nc(out,"SMN30cm","unit","NC_CHAR","gN/m2")
att.put.nc(out,"SMC100cm","unit","NC_CHAR","gC/m2")
att.put.nc(out,"SMN100cm","unit","NC_CHAR","gN/m2")

att.put.nc(out,"NC_GLOBAL","history","NC_CHAR",paste("Created on", date()))
close.nc(out)

