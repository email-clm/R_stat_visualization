#change the work space # by xiaofeng Xu on Sep 1, 2020
setwd("/Users/xxuadmin/BUSINESS/PUBLICATIONS/Published/2020/2020_GuoZY_DOC/final_data")
#load the library for processing netcdf files
library(RNetCDF)
rm(list=ls()) #remove all objects
out <- create.nc("Global_Soil_DOC.nc",clobber=TRUE)
 dim.def.nc(out,"lat",360)
 dim.def.nc(out,"lon",720)
 var.def.nc(out,"lat","NC_FLOAT","lat")
 var.def.nc(out,"lon","NC_FLOAT","lon")
 var.def.nc(out,"veg","NC_INT",c("lon","lat"))
 var.def.nc(out,"DOC30cm","NC_FLOAT",c("lon","lat"))
 var.def.nc(out,"DOC100cm","NC_FLOAT",c("lon","lat"))

 doc30cmdata <- array(-9999, c(259200,1))
 doc100cmdata <- array(-9999, c(259200,1))

#read in the origional data    
vegdata <- read.table("veg.asc") 
doc30cmdata <- read.table("DOC_0_30_0507_g.txt") 
doc100cmdata <- read.table("DOC_0_100_0507_g.txt") 

vegdata = t(vegdata)
veg <- array(-9999, c(720,360))
doc30cm <- array(-9999, c(720,360))
doc100cm <- array(-9999, c(720,360))

 for (i in 1:720) {
   for (j in 1:360)	
 {
  veg[i,j] = vegdata[i,j]
  doc30cm[i,j] = doc30cmdata[((j-1)*720+i),1]
  doc100cm[i,j] = doc100cmdata[((j-1)*720+i),1]
  }
}

for (i in 1:360)	{
  i = i + 360
  for (j in 1:360) {
    if(is.na(veg[i,j]) == TRUE) {
      veg[i,j] = -9999  }
    else
      veg[i,j] = veg[i,j]
    
    if(is.na(doc30cm[i,j]) == TRUE) {
      doc30cm[i,j] = -9999  }
    else
      doc30cm[i,j] = doc30cm[i,j]
    
    if(is.na(doc100cm[i,j]) == TRUE) {
      doc100cm[i,j] = -9999  }
    else
      doc100cm[i,j] = doc100cm[i,j]
  }
}

for (i in 361:720)	{
  i = i - 360
  for (j in 1:360) {
    if(is.na(veg[i,j]) == TRUE) {
      veg[i,j] = -9999  }
    else
      veg[i,j] = veg[i,j]
    
    if(is.na(doc30cm[i,j]) == TRUE) {
      doc30cm[i,j] = -9999  }
    else
      doc30cm[i,j] = doc30cm[i,j]
    
    if(is.na(doc100cm[i,j]) == TRUE) {
      doc100cm[i,j] = -9999  }
    else
      doc100cm[i,j] = doc100cm[i,j]
  }
}

latvalue = seq(89.75,-89.75,by=-0.5)
lonvalue = seq(-179.75,179.75,by=0.5)
var.put.nc(out,"lat",latvalue,1,NA)
var.put.nc(out,"lon",lonvalue,1,NA)

att.put.nc(out,"veg","missing_value","NC_INT",-9999)
att.put.nc(out,"DOC30cm","missing_value","NC_FLOAT",-9999)
att.put.nc(out,"DOC100cm","missing_value","NC_FLOAT",-9999)

var.put.nc(out,"veg",veg,c(1,1),c(720,360))
var.put.nc(out,"DOC30cm",doc30cm,c(1,1),c(720,360))
var.put.nc(out,"DOC100cm",doc100cm,c(1,1),c(720,360))

att.put.nc(out,"NC_GLOBAL","title","NC_CHAR","Global Dataset of Soil Dissolved Organic Carbon")
att.put.nc(out,"NC_GLOBAL","reference_data","NC_CHAR","Xu, Xiaofeng; Guo, Ziyu; Wang, Yihui; Wang, Zhongmei (2021), Soil Dissolved Organic Carbon in Terrestrial Ecosystems: Global Budget, Spatial Distribution and Controls, v2, Dryad, Dataset, https://doi.org/10.5061/dryad.73n5tb2v6")
att.put.nc(out,"NC_GLOBAL","reference_literature","NC_CHAR","Guo Z.Y., Wang Y.H., Wan Z.M., Zuo Y.J., He L.Y., Li Dan., Yuan F.H., Wang N.N., Liu J.Z., Song Y.Y., Song C.C., Xu X.F. (2020). Global budget and distribution of soil dissolved organic carbon in terrestrial ecosystems. Global Ecology and Biogeography, DOI: 10.1111/GEB.13186.")
att.put.nc(out,"NC_GLOBAL","contact","NC_CHAR","Xiaofeng Xu: xxu@sdsu.edu, xuxfmail@gmail.com")
att.put.nc(out, "NC_GLOBAL","vegetation_code", "NC_CHAR", "101: boreal forest; 102: temperate confier; 103: temperate broadleaf; 104: tropicl forest; 105: mixed forest; 106: grassland; 107: shrubland; 108: tundra; 109: desert; 110: wetland; 111: cropland; 112: pasture")
att.put.nc(out,"veg","long_name","NC_CHAR","vegetation types")
att.put.nc(out,"DOC30cm","long_name","NC_CHAR","soil dissolved organic carbon in top 30cm soil profile")
att.put.nc(out,"DOC100cm","long_name","NC_CHAR","soil dissolved organic carbon in top 100cm soil profile")
att.put.nc(out,"DOC30cm","unit","NC_CHAR","gC/m2 in 0-30cm soil profile")
att.put.nc(out,"DOC100cm","unit","NC_CHAR","gC/m2 in 0-100 cm soil profile")

att.put.nc(out,"NC_GLOBAL","history","NC_CHAR",paste("Created on", date()))
close.nc(out)

