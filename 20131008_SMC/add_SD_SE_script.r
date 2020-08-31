#change the work space
setwd("path/GlobalMC_Uncertainty_20131014")
#load the library for processing netcdf files
library(RNetCDF)
out <- create.nc("Global_Soil_Microbeial_BiomassCN_Uncertainty.nc",clobber=TRUE)
 dim.def.nc(out,"lat",360)
 dim.def.nc(out,"lon",720)
 var.def.nc(out,"lat","NC_FLOAT","lat")
 var.def.nc(out,"lon","NC_FLOAT","lon")
#define variable of C, N in 30cm and 100cm along soil pofile
 var.def.nc(out,"SMC30cm_SD","NC_FLOAT",c("lon","lat"))
 var.def.nc(out,"SMC30cm_SE","NC_FLOAT",c("lon","lat"))
 var.def.nc(out,"SMN30cm_SD","NC_FLOAT",c("lon","lat"))
 var.def.nc(out,"SMN30cm_SE","NC_FLOAT",c("lon","lat"))
 var.def.nc(out,"SMC100cm_SD","NC_FLOAT",c("lon","lat"))
 var.def.nc(out,"SMC100cm_SE","NC_FLOAT",c("lon","lat"))
 var.def.nc(out,"SMN100cm_SD","NC_FLOAT",c("lon","lat"))
 var.def.nc(out,"SMN100cm_SE","NC_FLOAT",c("lon","lat"))
#read in the origional data    
smc30cm_sd <- open.nc("SMC_sd30cm.nc") 
smc30cm_se <- open.nc("SMC_se30cm.nc") 
smn30cm_sd <- open.nc("SMN_sd30cm.nc") 
smn30cm_se <- open.nc("SMN_se30cm.nc") 
smc100cm_sd <- open.nc("SMC_sd100cm.nc") 
smc100cm_se <- open.nc("SMC_se100cm.nc") 
smn100cm_sd <- open.nc("SMN_sd100cm.nc") 
smn100cm_se <- open.nc("SMN_se100cm.nc") 

c30cm_sd <- var.get.nc(smc30cm_sd,"SMC30cm_SD",c(1,1),c(720,360),na.mode=0)
c30cm_se <- var.get.nc(smc30cm_se,"SMC30cm_SE",c(1,1),c(720,360),na.mode=0)
n30cm_sd <- var.get.nc(smn30cm_sd,"SMN30cm_SD",c(1,1),c(720,360),na.mode=0)
n30cm_se <- var.get.nc(smn30cm_se,"SMN30cm_SE",c(1,1),c(720,360),na.mode=0)
c100cm_sd <- var.get.nc(smc100cm_sd,"SMC100cm_SD",c(1,1),c(720,360),na.mode=0)
c100cm_se <- var.get.nc(smc100cm_se,"SMC100cm_SE",c(1,1),c(720,360),na.mode=0)
n100cm_sd <- var.get.nc(smn100cm_sd,"SMN100cm_SD",c(1,1),c(720,360),na.mode=0)
n100cm_se <- var.get.nc(smn100cm_se,"SMN100cm_SE",c(1,1),c(720,360),na.mode=0)

for (i in 1:720)	{
 for (j in 1:360) {
  if(is.na(c30cm_sd[i,j]) == TRUE) {
  c30cm_sd[i,j] = -9999  }
  if(is.na(c30cm_se[i,j]) == TRUE) {
  c30cm_se[i,j] = -9999  }
  if(is.na(n30cm_sd[i,j]) == TRUE) {
  n30cm_sd[i,j] = -9999 }
  if(is.na(n30cm_se[i,j]) == TRUE) {
  n30cm_se[i,j] = -9999  }
  if(is.na(c100cm_sd[i,j]) == TRUE) {
  c100cm_sd[i,j] = -9999  }
  if(is.na(c100cm_se[i,j]) == TRUE) {
  c100cm_se[i,j] = -9999  }
  if(is.na(n100cm_sd[i,j]) == TRUE) {
  n100cm_sd[i,j] = -9999  }
  if(is.na(n100cm_se[i,j]) == TRUE) {
  n100cm_se[i,j] = -9999  }
 }
}

att.put.nc(out,"SMC30cm_SD","missing_value","NC_FLOAT",-9999)
var.put.nc(out,"SMC30cm_SD",c30cm_sd,c(1,1),c(720,360))

att.put.nc(out,"SMC30cm_SE","missing_value","NC_FLOAT",-9999)
var.put.nc(out,"SMC30cm_SE",c30cm_se,c(1,1),c(720,360))

att.put.nc(out,"SMC100cm_SD","missing_value","NC_FLOAT",-9999)
var.put.nc(out,"SMC100cm_SD",c100cm_sd,c(1,1),c(720,360))

att.put.nc(out,"SMC100cm_SE","missing_value","NC_FLOAT",-9999)
var.put.nc(out,"SMC100cm_SE",c100cm_se,c(1,1),c(720,360))

att.put.nc(out,"SMN30cm_SD","missing_value","NC_FLOAT",-9999)
var.put.nc(out,"SMN30cm_SD",n30cm_sd,c(1,1),c(720,360))

att.put.nc(out,"SMN30cm_SE","missing_value","NC_FLOAT",-9999)
var.put.nc(out,"SMN30cm_SE",n30cm_se,c(1,1),c(720,360))

att.put.nc(out,"SMN100cm_SD","missing_value","NC_FLOAT",-9999)
var.put.nc(out,"SMN100cm_SD",n100cm_sd,c(1,1),c(720,360))

att.put.nc(out,"SMN100cm_SE","missing_value","NC_FLOAT",-9999)
var.put.nc(out,"SMN100cm_SE",n100cm_se,c(1,1),c(720,360))

latvalue = seq(89.75,-89.75,by = -0.5)
lonvalue = seq(-179.75,179.75,by=0.5)
var.put.nc(out,"lat",latvalue,1,NA)
var.put.nc(out,"lon",lonvalue,1,NA)

var.put.nc(out,"SMC30cm_SD",c30cm_sd,c(1,1),c(720,360))
var.put.nc(out,"SMC30cm_SE",c30cm_se,c(1,1),c(720,360))
var.put.nc(out,"SMC100cm_SD",c100cm_sd,c(1,1),c(720,360))
var.put.nc(out,"SMC100cm_SE",c100cm_se,c(1,1),c(720,360))
var.put.nc(out,"SMN30cm_SD",n30cm_sd,c(1,1),c(720,360))
var.put.nc(out,"SMN30cm_SE",n30cm_se,c(1,1),c(720,360))
var.put.nc(out,"SMN100cm_SD",n100cm_sd,c(1,1),c(720,360))
var.put.nc(out,"SMN100cm_SE",n100cm_se,c(1,1),c(720,360))

att.put.nc(out,"NC_GLOBAL","title","NC_CHAR","Global Dataset of Soil Microbial Biomass Carbon and Nitrogen")
att.put.nc(out,"NC_GLOBAL","reference","NC_CHAR","Xu, X., Thornton, P. E. and Post, W. M. (2013), A global analysis of soil microbial biomass carbon, nitrogen and phosphorus in terrestrial ecosystems. Global Ecology and Biogeography, 22: 737–749. doi: 10.1111/geb.12029")
att.put.nc(out,"NC_GLOBAL","contact","NC_CHAR","Xiaofeng Xu: xux4@ornl.gov, xuxfmail@gmail.com")
att.put.nc(out,"SMC30cm_SD","long_name","NC_CHAR","standard deriation of soil microbial biomass carbon in top 30cm soil profile")
att.put.nc(out,"SMC30cm_SE","long_name","NC_CHAR","standard error of soil microbial biomass carbon in top 30cm soil profile")
att.put.nc(out,"SMC100cm_SD","long_name","NC_CHAR","standard deriation of soil microbial biomass carbon in top 100cm soil profile")
att.put.nc(out,"SMC100cm_SE","long_name","NC_CHAR","standard error of soil microbial biomass carbon in top 100cm soil profile")
att.put.nc(out,"SMN30cm_SD","long_name","NC_CHAR","standard deriation of soil microbial biomass nitrogen in top 30cm soil profile")
att.put.nc(out,"SMN30cm_SE","long_name","NC_CHAR","standard error of soil microbial biomass nitrogen in top 30cm soil profile")
att.put.nc(out,"SMN100cm_SD","long_name","NC_CHAR","standard deriation of soil microbial biomass nitrogen in top 100cm soil profile")
att.put.nc(out,"SMN100cm_SE","long_name","NC_CHAR","standard error of soil microbial biomass nitrogen in top 100cm soil profile")
att.put.nc(out,"SMC30cm_SD","unit","NC_CHAR","gC/m2")
att.put.nc(out,"SMC30cm_SE","unit","NC_CHAR","gC/m2")
att.put.nc(out,"SMC100cm_SD","unit","NC_CHAR","gC/m2")
att.put.nc(out,"SMC100cm_SE","unit","NC_CHAR","gC/m2")
att.put.nc(out,"SMN30cm_SD","unit","NC_CHAR","gN/m2")
att.put.nc(out,"SMN30cm_SE","unit","NC_CHAR","gN/m2")
att.put.nc(out,"SMN100cm_SD","unit","NC_CHAR","gN/m2")
att.put.nc(out,"SMN100cm_SE","unit","NC_CHAR","gN/m2")

att.put.nc(out,"NC_GLOBAL","history","NC_CHAR",paste("Created on", date()))
close.nc(out)

