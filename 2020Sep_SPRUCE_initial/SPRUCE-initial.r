# Xiaofeng Xu created this file in May 2020, and updated in Sep 2020
library("RNetCDF")
library("akima")
rm(list=ls())
setwd("/Users/xxuadmin/BUSINESS/PUBLICATIONS/WorkingOn_Xu_Isotope/SPRUCE_2020Sep")
# 13C is based on the PD standard Pee Dee Belemnite (PDB). 13C:12C = 0.0112372.
# 13C/12C(sample) / 13C/12C(standard - 1)
# 13C = (delta / 1000 + 1) * 0.0112372 * 12C
data <- read.csv("Peat_Characteristics_T0_20180425_plot.csv", header=TRUE)
O13C <- data[1:16,3:4]
#depth 25, 15, 5, -5, -25, -35, -45, -55, -65, -85, -113, -163, -188, -225, -255
#-5 for layer 1, 2, 3
# -15 for layer 4, 
#-25 for layer 5,
#-35 for layer 6
#-45 -55, and -65 for layer 7 0.6197
#-85 and -133 for layer 8 1.038
# -163 and -188 for layer 9 1.72
# -225 and -275 for layer 10 2.86
SO13C = array(0,dim=15)
#L13C = O13C[3,1]
SO13C[1] = O13C[4,1]
SO13C[2] = O13C[4,1]
SO13C[3] = O13C[4,1]
SO13C[4] = O13C[5,1]
SO13C[5] = O13C[6,1]
SO13C[6] = mean(O13C[7:9,1])
SO13C[7] = mean(O13C[7:9,1])
SO13C[8] = mean(O13C[10:11,1])
SO13C[9] = mean(O13C[12:13,1])
SO13C[10] = mean(O13C[14:16,1])

computC13 <- function(C12, deltaC)
{
        (deltaC / 1000.0 + 1.0) * 0.0112372 * C12
}

#notice: please copy a file with the name of fileoutput in the following code for variable to be incorporated
fileinput <- open.nc("SPRUCE-finalspinup-peatland-carbon-initial.nc")  # 2012 year climate data
fileoutput <- open.nc("SPRUCE-finalspinup-peatland-ISOcarbon-initial.nc",write=TRUE)

depth <- c(0.0071, 0.0028, 0.0623, 0.1189, 0.2122, 0.366, 0.6197, 1.038, 1.72, 2.86)
thick <- c(0.0175128179, 0.0275789693, 0.0454700332, 0.0749674110, 0.1236003651, 0.2037825510, 0.3359806264, 0.5539384054, 0.9132900316, 1.5057607014)
#realcarbondensity = c(22385, 22385, 22385, 30294, 43978, 95584, 92983, 83658, 83799, 90616)

cwdc_vr <- var.get.nc(fileinput, "cwdc_vr")
litr1c_vr <- var.get.nc(fileinput, "litr1c_vr")
litr2c_vr <- var.get.nc(fileinput, "litr2c_vr")
litr3c_vr <- var.get.nc(fileinput, "litr3c_vr")
soil1c_vr <- var.get.nc(fileinput, "soil1c_vr")
soil2c_vr <- var.get.nc(fileinput, "soil2c_vr")
soil3c_vr <- var.get.nc(fileinput, "soil3c_vr")
soil4c_vr <- var.get.nc(fileinput, "soil4c_vr")

cwdc_13_vr = cwdc_vr
litr1c_13_vr = litr1c_vr
litr2c_13_vr = litr2c_vr
litr3c_13_vr = litr3c_vr
soil1c_13_vr = soil1c_vr
soil2c_13_vr = soil2c_vr
soil3c_13_vr = soil3c_vr
soil4c_13_vr = soil4c_vr

bacteriac_vr = litr1c_vr
fungic_vr = litr1c_vr
domc_vr = litr1c_vr
seedc = litr1c_vr
col_ctrunc_vr = litr1c_vr

totlitc = litr1c_vr
totcolc = litr1c_vr
prod10c = litr1c_vr
prod100c = litr1c_vr

bacteriac_13_vr = bacteriac_vr
fungic_13_vr = fungic_vr
domc_13_vr = domc_vr
seedc_13 = seedc
col_ctrunc_13_vr = col_ctrunc_vr

totlitc_13 = totlitc
totcolc_13 = totcolc
prod10c_13 = prod10c
prod100c_13 = prod100c

for(i in 1:10)
{
cwdc_13_vr[i,1] = computC13(cwdc_vr[i,1], SO13C[i])
litr1c_13_vr[i,1] = computC13(litr1c_vr[i,1], SO13C[i])
litr2c_13_vr[i,1] = computC13(litr2c_vr[i,1], SO13C[i])
litr3c_13_vr[i,1] = computC13(litr3c_vr[i,1], SO13C[i])
soil1c_13_vr[i,1] = computC13(soil1c_vr[i,1], SO13C[i])
soil2c_13_vr[i,1] = computC13(soil2c_vr[i,1], SO13C[i])
soil3c_13_vr[i,1] = computC13(soil3c_vr[i,1], SO13C[i])
soil4c_13_vr[i,1] = computC13(soil4c_vr[i,1], SO13C[i])

bacteriac_13_vr[i,1] = computC13(bacteriac_vr[i,1], SO13C[i])
fungic_13_vr[i,1] = computC13(fungic_vr[i,1], SO13C[i])
domc_13_vr[i,1] = computC13(domc_vr[i,1], SO13C[i])
seedc_13[i,1] = computC13(seedc[i,1], SO13C[i])
col_ctrunc_13_vr[i,1] = computC13(col_ctrunc_vr[i,1], SO13C[i])
totlitc_13[i,1] = computC13(totlitc[i,1], SO13C[i])
totcolc_13[i,1] = computC13(totcolc[i,1], SO13C[i])
prod10c_13[i,1] = computC13(prod10c[i,1], SO13C[i])
prod100c_13[i,1] = computC13(prod100c[i,1], SO13C[i])

cwdc_13_vr[i,2] = computC13(cwdc_vr[i,2], SO13C[i])
litr1c_13_vr[i,2] = computC13(litr1c_vr[i,2], SO13C[i])
litr2c_13_vr[i,2] = computC13(litr2c_vr[i,2], SO13C[i])
litr3c_13_vr[i,2] = computC13(litr3c_vr[i,2], SO13C[i])
soil1c_13_vr[i,2] = computC13(soil1c_vr[i,2], SO13C[i])
soil2c_13_vr[i,2] = computC13(soil2c_vr[i,2], SO13C[i])
soil3c_13_vr[i,2] = computC13(soil3c_vr[i,2], SO13C[i])
soil4c_13_vr[i,2] = computC13(soil4c_vr[i,2], SO13C[i])

bacteriac_13_vr[i,2] = computC13(bacteriac_vr[i,2], SO13C[i])
fungic_13_vr[i,2] = computC13(fungic_vr[i,2], SO13C[i])
domc_13_vr[i,2] = computC13(domc_vr[i,2], SO13C[i])
seedc_13[i,2] = computC13(seedc[i,2], SO13C[i])
col_ctrunc_13_vr[i,2] = computC13(col_ctrunc_vr[i,2], SO13C[i])
totlitc_13[i,2] = computC13(totlitc[i,2], SO13C[i])
totcolc_13[i,2] = computC13(totcolc[i,2], SO13C[i])
prod10c_13[i,2] = computC13(prod10c[i,2], SO13C[i])
prod100c_13[i,2] = computC13(prod100c[i,2], SO13C[i])
}

for(i in 11:15)
{
cwdc_13_vr[i,1] = 0.0
litr1c_13_vr[i,1] = 0.0
litr2c_13_vr[i,1] = 0.0
litr3c_13_vr[i,1] = 0.0
soil1c_13_vr[i,1] = 0.0
soil2c_13_vr[i,1] = 0.0
soil3c_13_vr[i,1] = 0.0
soil4c_13_vr[i,1] = 0.0
        
bacteriac_13_vr[i,1] = 0.0
fungic_13_vr[i,1] = 0.0
domc_13_vr[i,1] = 0.0
seedc_13[i,1] = 0.0
col_ctrunc_13_vr[i,1] = 0.0

totlitc_13[i,1] = 0.0
totcolc_13[i,1] = 0.0
prod10c_13[i,1] = 0.0
prod100c_13[i,1] = 0.0
        
cwdc_13_vr[i,2] = 0.0
litr1c_13_vr[i,2] = 0.0
litr2c_13_vr[i,2] = 0.0
litr3c_13_vr[i,2] = 0.0
soil1c_13_vr[i,2] = 0.0
soil2c_13_vr[i,2] = 0.0
soil3c_13_vr[i,2] = 0.0
soil4c_13_vr[i,2] = 0.0
        
bacteriac_13_vr[i,2] = 0.0
fungic_13_vr[i,2] = 0.0
domc_13_vr[i,2] = 0.0
seedc_13[i,2] = 0.0
col_ctrunc_13_vr[i,2] = 0.0
        
totlitc_13[i,2] = 0.0
totcolc_13[i,2] = 0.0
prod10c_13[i,2] = 0.0
prod100c_13[i,2] = 0.0
}

cwdc_14_vr = cwdc_13_vr / 10000.0
litr1c_14_vr = litr1c_13_vr / 10000.0
litr2c_14_vr = litr2c_13_vr / 10000.0
litr3c_14_vr = litr3c_13_vr / 10000.0
soil1c_14_vr = soil1c_13_vr / 10000.0
soil2c_14_vr = soil2c_13_vr / 10000.0
soil3c_14_vr = soil3c_13_vr / 10000.0
soil4c_14_vr = soil4c_13_vr / 10000.0
bacteriac_14_vr = bacteriac_13_vr / 10000.0
fungic_14_vr = fungic_13_vr / 10000.0
domc_14_vr = domc_13_vr / 10000.0
seedc_14 = seedc_13 / 10000.0
col_ctrunc_14_vr = col_ctrunc_13_vr / 10000.0
totlitc_14 = totlitc_13 / 10000.0
totcolc_14 = totcolc_13 / 10000.0
prod10c_14 = prod10c_13 / 10000.0
prod100c_14 = prod100c_13 / 10000.0

#levgrnd = 15
#column = 2
#var.def.nc(fileoutput,"levgrnd","NC_FLOAT","levgrnd")
#var.def.nc(fileoutput,"column","NC_FLOAT","column")

var.def.nc(fileoutput,"cwdc_13_vr","NC_FLOAT",c("levgrnd","column"))
var.def.nc(fileoutput,"litr1c_13_vr","NC_FLOAT",c("levgrnd","column"))
var.def.nc(fileoutput,"litr2c_13_vr","NC_FLOAT",c("levgrnd","column"))
var.def.nc(fileoutput,"litr3c_13_vr","NC_FLOAT",c("levgrnd","column"))
var.def.nc(fileoutput,"soil1c_13_vr","NC_FLOAT",c("levgrnd","column"))
var.def.nc(fileoutput,"soil2c_13_vr","NC_FLOAT",c("levgrnd","column"))
var.def.nc(fileoutput,"soil3c_13_vr","NC_FLOAT",c("levgrnd","column"))
var.def.nc(fileoutput,"soil4c_13_vr","NC_FLOAT",c("levgrnd","column"))
var.def.nc(fileoutput,"bacteriac_13_vr","NC_FLOAT",c("levgrnd","column"))
var.def.nc(fileoutput,"fungic_13_vr","NC_FLOAT",c("levgrnd","column"))
var.def.nc(fileoutput,"domc_13_vr","NC_FLOAT",c("levgrnd","column"))
var.def.nc(fileoutput,"seedc_13","NC_FLOAT",c("levgrnd","column"))
var.def.nc(fileoutput,"col_ctrunc_13_vr","NC_FLOAT",c("levgrnd","column"))
var.def.nc(fileoutput,"totlitc_13","NC_FLOAT",c("levgrnd","column"))
var.def.nc(fileoutput,"totcolc_13","NC_FLOAT",c("levgrnd","column"))
var.def.nc(fileoutput,"prod10c_13","NC_FLOAT",c("levgrnd","column"))
var.def.nc(fileoutput,"prod100c_13","NC_FLOAT",c("levgrnd","column"))

var.def.nc(fileoutput,"cwdc_14_vr","NC_FLOAT",c("levgrnd","column"))
var.def.nc(fileoutput,"litr1c_14_vr","NC_FLOAT",c("levgrnd","column"))
var.def.nc(fileoutput,"litr2c_14_vr","NC_FLOAT",c("levgrnd","column"))
var.def.nc(fileoutput,"litr3c_14_vr","NC_FLOAT",c("levgrnd","column"))
var.def.nc(fileoutput,"soil1c_14_vr","NC_FLOAT",c("levgrnd","column"))
var.def.nc(fileoutput,"soil2c_14_vr","NC_FLOAT",c("levgrnd","column"))
var.def.nc(fileoutput,"soil3c_14_vr","NC_FLOAT",c("levgrnd","column"))
var.def.nc(fileoutput,"soil4c_14_vr","NC_FLOAT",c("levgrnd","column"))
var.def.nc(fileoutput,"bacteriac_14_vr","NC_FLOAT",c("levgrnd","column"))
var.def.nc(fileoutput,"fungic_14_vr","NC_FLOAT",c("levgrnd","column"))
var.def.nc(fileoutput,"domc_14_vr","NC_FLOAT",c("levgrnd","column"))
var.def.nc(fileoutput,"seedc_14","NC_FLOAT",c("levgrnd","column"))
var.def.nc(fileoutput,"col_ctrunc_14_vr","NC_FLOAT",c("levgrnd","column"))
var.def.nc(fileoutput,"totlitc_14","NC_FLOAT",c("levgrnd","column"))
var.def.nc(fileoutput,"totcolc_14","NC_FLOAT",c("levgrnd","column"))
var.def.nc(fileoutput,"prod10c_14","NC_FLOAT",c("levgrnd","column"))
var.def.nc(fileoutput,"prod100c_14","NC_FLOAT",c("levgrnd","column"))

att.put.nc(fileoutput, "cwdc_13_vr","missing_value", "NC_FLOAT", -9999)
var.put.nc(fileoutput, "cwdc_13_vr",cwdc_13_vr)

att.put.nc(fileoutput, "litr1c_13_vr","missing_value", "NC_FLOAT", -9999)
var.put.nc(fileoutput, "litr1c_13_vr",litr1c_13_vr)

att.put.nc(fileoutput, "litr2c_13_vr","missing_value", "NC_FLOAT", -9999)
var.put.nc(fileoutput, "litr2c_13_vr",litr2c_13_vr)

att.put.nc(fileoutput, "litr3c_13_vr","missing_value", "NC_FLOAT", -9999)
var.put.nc(fileoutput, "litr3c_13_vr",litr3c_13_vr)

att.put.nc(fileoutput, "soil1c_13_vr","missing_value", "NC_FLOAT", -9999)
var.put.nc(fileoutput, "soil1c_13_vr",soil1c_13_vr)

att.put.nc(fileoutput, "soil2c_13_vr","missing_value", "NC_FLOAT", -9999)
var.put.nc(fileoutput, "soil2c_13_vr",soil2c_13_vr)

att.put.nc(fileoutput, "soil3c_13_vr","missing_value", "NC_FLOAT", -9999)
var.put.nc(fileoutput, "soil3c_13_vr",soil3c_13_vr)

att.put.nc(fileoutput, "soil4c_13_vr","missing_value", "NC_FLOAT", -9999)
var.put.nc(fileoutput, "soil4c_13_vr",soil4c_13_vr)

att.put.nc(fileoutput, "bacteriac_13_vr","missing_value", "NC_FLOAT", -9999)
var.put.nc(fileoutput, "bacteriac_13_vr",bacteriac_13_vr)

att.put.nc(fileoutput, "fungic_13_vr","missing_value", "NC_FLOAT", -9999)
var.put.nc(fileoutput, "fungic_13_vr",fungic_13_vr)

att.put.nc(fileoutput, "domc_13_vr","missing_value", "NC_FLOAT", -9999)
var.put.nc(fileoutput, "domc_13_vr",domc_13_vr)

att.put.nc(fileoutput, "seedc_13","missing_value", "NC_FLOAT", -9999)
var.put.nc(fileoutput, "seedc_13",seedc_13)

att.put.nc(fileoutput, "col_ctrunc_13_vr","missing_value", "NC_FLOAT", -9999)
var.put.nc(fileoutput, "col_ctrunc_13_vr",col_ctrunc_13_vr)

att.put.nc(fileoutput, "totlitc_13","missing_value", "NC_FLOAT", -9999)
var.put.nc(fileoutput, "totlitc_13",totlitc_13)

att.put.nc(fileoutput, "totcolc_13","missing_value", "NC_FLOAT", -9999)
var.put.nc(fileoutput, "totcolc_13",totcolc_13)

att.put.nc(fileoutput, "prod10c_13","missing_value", "NC_FLOAT", -9999)
var.put.nc(fileoutput, "prod10c_13",prod10c_13)

att.put.nc(fileoutput, "prod100c_13","missing_value", "NC_FLOAT", -9999)
var.put.nc(fileoutput, "prod100c_13",prod100c_13)

# 14C
att.put.nc(fileoutput, "cwdc_14_vr","missing_value", "NC_FLOAT", -9999)
var.put.nc(fileoutput, "cwdc_14_vr",cwdc_14_vr)

att.put.nc(fileoutput, "litr1c_14_vr","missing_value", "NC_FLOAT", -9999)
var.put.nc(fileoutput, "litr1c_14_vr",litr1c_14_vr)

att.put.nc(fileoutput, "litr2c_14_vr","missing_value", "NC_FLOAT", -9999)
var.put.nc(fileoutput, "litr2c_14_vr",litr2c_14_vr)

att.put.nc(fileoutput, "litr3c_14_vr","missing_value", "NC_FLOAT", -9999)
var.put.nc(fileoutput, "litr3c_14_vr",litr3c_14_vr)

att.put.nc(fileoutput, "soil1c_14_vr","missing_value", "NC_FLOAT", -9999)
var.put.nc(fileoutput, "soil1c_14_vr",soil1c_14_vr)

att.put.nc(fileoutput, "soil2c_14_vr","missing_value", "NC_FLOAT", -9999)
var.put.nc(fileoutput, "soil2c_14_vr",soil2c_14_vr)

att.put.nc(fileoutput, "soil3c_14_vr","missing_value", "NC_FLOAT", -9999)
var.put.nc(fileoutput, "soil3c_14_vr",soil3c_14_vr)

att.put.nc(fileoutput, "soil4c_14_vr","missing_value", "NC_FLOAT", -9999)
var.put.nc(fileoutput, "soil4c_14_vr",soil4c_14_vr)

att.put.nc(fileoutput, "bacteriac_14_vr","missing_value", "NC_FLOAT", -9999)
var.put.nc(fileoutput, "bacteriac_14_vr",bacteriac_14_vr)

att.put.nc(fileoutput, "fungic_14_vr","missing_value", "NC_FLOAT", -9999)
var.put.nc(fileoutput, "fungic_14_vr",fungic_14_vr)

att.put.nc(fileoutput, "domc_14_vr","missing_value", "NC_FLOAT", -9999)
var.put.nc(fileoutput, "domc_14_vr",domc_14_vr)

att.put.nc(fileoutput, "seedc_14","missing_value", "NC_FLOAT", -9999)
var.put.nc(fileoutput, "seedc_14",seedc_14)

att.put.nc(fileoutput, "col_ctrunc_14_vr","missing_value", "NC_FLOAT", -9999)
var.put.nc(fileoutput, "col_ctrunc_14_vr",col_ctrunc_14_vr)

att.put.nc(fileoutput, "totlitc_14","missing_value", "NC_FLOAT", -9999)
var.put.nc(fileoutput, "totlitc_14",totlitc_14)

att.put.nc(fileoutput, "totcolc_14","missing_value", "NC_FLOAT", -9999)
var.put.nc(fileoutput, "totcolc_14",totcolc_14)

att.put.nc(fileoutput, "prod10c_14","missing_value", "NC_FLOAT", -9999)
var.put.nc(fileoutput, "prod10c_14",prod10c_14)

att.put.nc(fileoutput, "prod100c_14","missing_value", "NC_FLOAT", -9999)
var.put.nc(fileoutput, "prod100c_14",prod100c_14)

att.put.nc(fileoutput,"NC_GLOBAL","title","NC_CHAR","isotopic 13 carbon pools and 14 carbon pools")

close.nc(fileinput)
close.nc(fileoutput)

