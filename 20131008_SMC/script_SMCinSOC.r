#change the work space
setwd("E:\\Conferences\\2013_ICDC9\\GlobalSMB")
#load the library for processing netcdf files
library(RNetCDF)
out <- create.nc("Percentage_SMCinSOC_100cm.nc",clobber=TRUE)
 dim.def.nc(out,"lat",360)
 dim.def.nc(out,"lon",720)
 var.def.nc(out,"lat","NC_FLOAT","lat")
 var.def.nc(out,"lon","NC_FLOAT","lon")
#define variable of C, N in 30cm and 100cm along soil pofile
 var.def.nc(out,"SMCinSOC100cm","NC_FLOAT",c("lon","lat"))
#read in the origional data    
infile <- open.nc("SMCinSOC_100cm.nc") 

fraction <- var.get.nc(infile,"smcinsoc100cm",c(1,1),c(720,360),na.mode=0)

for (i in 1:720)	{
 for (j in 1:360) {
  if(is.na(fraction[i,j]) == TRUE)
  fraction[i,j] = -9999 
 }
}

latvalue = seq(89.75,-89.75,by = -0.5)
lonvalue = seq(-179.75,179.75,by=0.5)
var.put.nc(out,"lat",latvalue,1,NA)
var.put.nc(out,"lon",lonvalue,1,NA)

att.put.nc(out,"SMCinSOC100cm","missing_value","NC_FLOAT",-9999)
var.put.nc(out,"SMCinSOC100cm",fraction,c(1,1),c(720,360))

att.put.nc(out,"NC_GLOBAL","title","NC_CHAR","Global Dataset of Soil Microbial Biomass Carbon and Nitrogen")
att.put.nc(out,"NC_GLOBAL","reference","NC_CHAR","Xu, X., Thornton, P. E. and Post, W. M. (2013), A global analysis of soil microbial biomass carbon, nitrogen and phosphorus in terrestrial ecosystems. Global Ecology and Biogeography, 22: 737–749. doi: 10.1111/geb.12029")
att.put.nc(out,"NC_GLOBAL","contact","NC_CHAR","Xiaofeng Xu: xux4@ornl.gov, xuxfmail@gmail.com")
att.put.nc(out,"SMCinSOC100cm","long_name","NC_CHAR","Percentage of soil organic carbon as soil microbial biomass carbon in top 100cm soil profile")
att.put.nc(out,"SMCinSOC100cm","unit","NC_CHAR","100%")

att.put.nc(out,"NC_GLOBAL","history","NC_CHAR",paste("Created on", date()))
close.nc(out)

