library("RNetCDF")
library("akima")
setwd("/Users/xxuadmin/Dropbox/SPRUCE/2017Nov27")
#notice: please copy a file with the name of fileoutput in the following code for variable to be replaced
fileinput <- open.nc("US-SPR_finalspinup.clm2.r.0101-01-01-00000.nc")  # 2012 year climate data
fileoutput <- open.nc("SPRUCE-finalspinup-peatland-carbon-initial.nc",write=TRUE)  # 2012 year climate data

depth <- c(0.0071, 0.0028, 0.0623, 0.1189, 0.2122, 0.366, 0.6197, 1.038, 1.72, 2.86)
thick <- c(0.0175128179, 0.0275789693, 0.0454700332, 0.0749674110, 0.1236003651, 0.2037825510, 0.3359806264, 0.5539384054, 0.9132900316, 1.5057607014)
realcarbondensity = c(22385, 22385, 22385, 30294, 43978, 95584, 92983, 83658, 83799, 90616)
CWDC_vr <- var.get.nc(fileinput, "cwdc_vr")
CWDN_vr <- var.get.nc(fileinput, "cwdn_vr")
LITR1C_vr <- var.get.nc(fileinput, "litr1c_vr")
LITR2C_vr <- var.get.nc(fileinput, "litr2c_vr")
LITR3C_vr <- var.get.nc(fileinput, "litr3c_vr")
LITR1N_vr <- var.get.nc(fileinput, "litr1n_vr")
LITR2N_vr <- var.get.nc(fileinput, "litr2n_vr")
LITR3N_vr <- var.get.nc(fileinput, "litr3n_vr")
SOIL1C_vr <- var.get.nc(fileinput, "soil1c_vr")
SOIL2C_vr <- var.get.nc(fileinput, "soil2c_vr")
SOIL3C_vr <- var.get.nc(fileinput, "soil3c_vr")
SOIL4C_vr <- var.get.nc(fileinput, "soil4c_vr")
CWDC_vr1 = array(1,c(15,2))
CWDN_vr1 = array(1,c(15,2))
LITR1C_vr1 = array(1,c(15,2))
LITR2C_vr1 = array(1,c(15,2))
LITR3C_vr1 = array(1,c(15,2))
SOIL1C_vr1 = array(1,c(15,2))
SOIL2C_vr1 = array(1,c(15,2))
SOIL3C_vr1 = array(1,c(15,2))
SOIL4C_vr1 = array(1,c(15,2))
CWDN_vr1 = array(1,c(15,2))
LITR1N_vr1 = array(1,c(15,2))
LITR2N_vr1 = array(1,c(15,2))
LITR3N_vr1 = array(1,c(15,2))
SOIL1N_vr1 = array(1,c(15,2))
SOIL2N_vr1 = array(1,c(15,2))
SOIL3N_vr1 = array(1,c(15,2))
SOIL4N_vr1 = array(1,c(15,2))
litr1cn = array(1,c(15,2))
litr2cn = array(1,c(15,2))
litr3cn = array(1,c(15,2))

tem1r = array(0,c(15,1))
tem2r = array(0,c(15,1))

for(i in 1:10)
{
tem1r[i] = 0
tem2r[i] = 0
litr1cn[i,1] = LITR1C_vr[i,1] / LITR1N_vr[i,1]
litr2cn[i,1] = LITR2C_vr[i,1] / LITR2N_vr[i,1]
litr3cn[i,1] = LITR3C_vr[i,1] / LITR3N_vr[i,1]

if(LITR1N_vr[i,1] == 0) {
litr1cn[i,1] = 50
} else {
print ("valid lit1 CN ratio in hum")
}
if(LITR2N_vr[i,1] == 0) {
litr2cn[i,1] = 50
} else {
print ("valid lit2 CN ratio in hum")
}
if(LITR3N_vr[i,1] == 0) {
litr3cn[i,1] = 50
} else {
print ("valid lit3 CN ratio in hum")
}
litr1cn[i,2] = LITR1C_vr[i,2] / LITR1N_vr[i,2]
litr2cn[i,2] = LITR2C_vr[i,2] / LITR2N_vr[i,2]
litr3cn[i,2] = LITR3C_vr[i,2] / LITR3N_vr[i,2]
if(LITR2N_vr[i,2] == 0) {
litr1cn[i,2] = 50
} else {
print ("valid lit1 CN ratio in hol")
}
if(LITR2N_vr[i,2] == 0) {
litr2cn[i,2] = 50
} else {
print ("valid lit2 CN ratio in hol")
}
if(LITR3N_vr[i,2] == 0) {
litr3cn[i,2] = 50
} else {
print ("valid lit3 CN ratio in hol")
}
}

CWDC_vr[10,1] = CWDC_vr[9,1]
LITR1C_vr[10,1] = LITR1C_vr[9,1]
LITR2C_vr[10,1] = LITR2C_vr[9,1]
LITR3C_vr[10,1] = LITR3C_vr[9,1]
SOIL1C_vr[10,1] = SOIL1C_vr[9,1]
SOIL2C_vr[10,1] = SOIL2C_vr[9,1]
SOIL3C_vr[10,1] = SOIL3C_vr[9,1]
SOIL4C_vr[10,1] = SOIL4C_vr[9,1]

CWDC_vr[10,2] = CWDC_vr[9,2]
LITR1C_vr[10,2] = LITR1C_vr[9,2]
LITR2C_vr[10,2] = LITR2C_vr[9,2]
LITR3C_vr[10,2] = LITR3C_vr[9,2]
SOIL1C_vr[10,2] = SOIL1C_vr[9,2]
SOIL2C_vr[10,2] = SOIL2C_vr[9,2]
SOIL3C_vr[10,2] = SOIL3C_vr[9,2]
SOIL4C_vr[10,2] = SOIL4C_vr[9,2]

for(i in 1:10)
{
tem1 = sum(CWDC_vr[i,1],LITR1C_vr[i,1],LITR2C_vr[i,1],LITR3C_vr[i,1],SOIL1C_vr[i,1],SOIL2C_vr[i,1],SOIL3C_vr[i,1],SOIL4C_vr[i,1])
CWDC_vr1[i,1] = CWDC_vr[i,1] / tem1 * realcarbondensity[i]
LITR1C_vr1[i,1] = LITR1C_vr[i,1] / tem1 * realcarbondensity[i]
LITR2C_vr1[i,1] = LITR2C_vr[i,1] / tem1 * realcarbondensity[i]
LITR3C_vr1[i,1] = LITR3C_vr[i,1] / tem1 * realcarbondensity[i]
SOIL1C_vr1[i,1] = SOIL1C_vr[i,1] / tem1 * realcarbondensity[i]
SOIL2C_vr1[i,1] = SOIL2C_vr[i,1] / tem1 * realcarbondensity[i]
SOIL3C_vr1[i,1] = SOIL3C_vr[i,1] / tem1 * realcarbondensity[i]
SOIL4C_vr1[i,1] = SOIL4C_vr[i,1] / tem1 * realcarbondensity[i]
tem1r[i] = realcarbondensity[i] / tem1
#cn[i,1] = CWDC_vr1[i,1] / CWDN_vr1[i,1]

CWDN_vr1[i,1] = CWDC_vr1[i,1] / 200
LITR1N_vr1[i,1] = LITR1C_vr1[i,1] / litr1cn[i,1]
LITR2N_vr1[i,1] = LITR2C_vr1[i,1] / litr2cn[i,1]
LITR3N_vr1[i,1] = LITR3C_vr1[i,1] / litr3cn[i,1]
SOIL1N_vr1[i,1] = SOIL1C_vr1[i,1] / 12
SOIL2N_vr1[i,1] = SOIL2C_vr1[i,1] / 12
SOIL3N_vr1[i,1] = SOIL3C_vr1[i,1] / 10
SOIL4N_vr1[i,1] = SOIL4C_vr1[i,1] / 10

tem2 = sum(CWDC_vr[i,2],LITR1C_vr[i,2],LITR2C_vr[i,2],LITR3C_vr[i,2],SOIL1C_vr[i,2],SOIL2C_vr[i,2],SOIL3C_vr[i,2],SOIL4C_vr[i,2])
CWDC_vr1[i,2] = CWDC_vr[i,2] / tem2 * realcarbondensity[i]
LITR1C_vr1[i,2] = LITR1C_vr[i,2] / tem2 * realcarbondensity[i]
LITR2C_vr1[i,2] = LITR2C_vr[i,2] / tem2 * realcarbondensity[i]
LITR3C_vr1[i,2] = LITR3C_vr[i,2] / tem2 * realcarbondensity[i]
SOIL1C_vr1[i,2] = SOIL1C_vr[i,2] / tem2 * realcarbondensity[i]
SOIL2C_vr1[i,2] = SOIL2C_vr[i,2] / tem2 * realcarbondensity[i]
SOIL3C_vr1[i,2] = SOIL3C_vr[i,2] / tem2 * realcarbondensity[i]
SOIL4C_vr1[i,2] = SOIL4C_vr[i,2] / tem2 * realcarbondensity[i]
tem2r[i] = realcarbondensity[i] / tem2
#cn[i,2] = CWDC_vr1[i,2] / CWDN_vr1[i,2]

CWDN_vr1[i,2] = CWDC_vr1[i,2] / 200
LITR1N_vr1[i,2] = LITR1C_vr1[i,2] / litr1cn[i,2]
LITR2N_vr1[i,2] = LITR2C_vr1[i,2] / litr2cn[i,2]
LITR3N_vr1[i,2] = LITR3C_vr1[i,2] / litr3cn[i,2]
SOIL1N_vr1[i,2] = SOIL1C_vr1[i,2] / 12
SOIL2N_vr1[i,2] = SOIL2C_vr1[i,2] / 12
SOIL3N_vr1[i,2] = SOIL3C_vr1[i,2] / 10
SOIL4N_vr1[i,2] = SOIL4C_vr1[i,2] / 10
}


for(i in 11:15)
{
CWDC_vr1[i,1] = 0.0
LITR1C_vr1[i,1] = 0.0
LITR2C_vr1[i,1] = 0.0
LITR3C_vr1[i,1] = 0.0
SOIL1C_vr1[i,1] = 0.0
SOIL2C_vr1[i,1] = 0.0
SOIL3C_vr1[i,1] = 0.0
SOIL4C_vr1[i,1] = 0.0

CWDN_vr1[i,1] = 0.0
LITR1N_vr1[i,1] = 0.0
LITR2N_vr1[i,1] = 0.0
LITR3N_vr1[i,1] = 0.0
SOIL1N_vr1[i,1] = 0.0
SOIL2N_vr1[i,1] = 0.0
SOIL3N_vr1[i,1] = 0.0
SOIL4N_vr1[i,1] = 0.0

CWDC_vr1[i,2] = 0.0
LITR1C_vr1[i,2] = 0.0
LITR2C_vr1[i,2] = 0.0
LITR3C_vr1[i,2] = 0.0
SOIL1C_vr1[i,2] = 0.0
SOIL2C_vr1[i,2] = 0.0
SOIL3C_vr1[i,2] = 0.0
SOIL4C_vr1[i,2] = 0.0

CWDN_vr1[i,2] = 0.0
LITR1N_vr1[i,2] = 0.0
LITR2N_vr1[i,2] = 0.0
LITR3N_vr1[i,2] = 0.0
SOIL1N_vr1[i,2] = 0.0
SOIL2N_vr1[i,2] = 0.0
SOIL3N_vr1[i,2] = 0.0
SOIL4N_vr1[i,2] = 0.0
}

 var.put.nc(fileoutput, "cwdc_vr",CWDC_vr1)
 var.put.nc(fileoutput, "litr1c_vr",LITR1C_vr1)
 var.put.nc(fileoutput, "litr2c_vr",LITR2C_vr1)
 var.put.nc(fileoutput, "litr3c_vr",LITR3C_vr1)
 var.put.nc(fileoutput, "soil1c_vr",SOIL1C_vr1)
 var.put.nc(fileoutput, "soil2c_vr",SOIL2C_vr1)
 var.put.nc(fileoutput, "soil3c_vr",SOIL3C_vr1)
 var.put.nc(fileoutput, "soil4c_vr",SOIL4C_vr1)

var.put.nc(fileoutput, "cwdn_vr",CWDN_vr1)
var.put.nc(fileoutput, "litr1n_vr",LITR1N_vr1)
var.put.nc(fileoutput, "litr2n_vr",LITR2N_vr1)
var.put.nc(fileoutput, "litr3n_vr",LITR3N_vr1)
var.put.nc(fileoutput, "soil1n_vr",SOIL1N_vr1)
var.put.nc(fileoutput, "soil2n_vr",SOIL2N_vr1)
var.put.nc(fileoutput, "soil3n_vr",SOIL3N_vr1)
var.put.nc(fileoutput, "soil4n_vr",SOIL4N_vr1)

temr <- cbind(tem1r,tem2r)
var.def.nc(fileoutput,"carbonpool_adjust", "NC_DOUBLE", c("levgrnd","gridcell"))
att.put.nc(fileoutput,"carbonpool_adjust", "missing_value","NC_DOUBLE",-9999)
att.put.nc(fileoutput,"carbonpool_adjust","long_name","NC_CHAR","adjustment of soil carbon density to fit observational carbon profile")
var.put.nc(fileoutput,"carbonpool_adjust", temr, c(1,1),c(15,2))

close.nc(fileinput)
close.nc(fileoutput)

