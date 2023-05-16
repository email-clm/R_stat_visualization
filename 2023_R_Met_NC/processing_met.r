library("RNetCDF")
library("akima")
#minor.tick()
setwd("/Users/xxu/Documents/BUSINESS/PUBLICATIONS/WorkingOn_Xu_Howland/Met_data")
#depth <- c(0.0071, 0.028, 0.0623, 0.1189, 0.2122, 0.366, 0.6197, 1.038, 1.72, 2.86)
data <- read.csv("Raw met data for processing.csv", header=TRUE)
data1 <- array(1,c(455520, 9))
data1[,1] = data[,1]
data1[,2] = data[,2]
for(x in 1:455520) 
  {
  data1[x,3] = data$TA_1_1_1[x]  # temperature at half an hour time step
  data1[x,4] = if(data$P_2_1_1[x] > -9000) data$P_2_1_1[x] else data$P_RAIN_1_1_1[x]  # precipitation
  data1[x,5] = if(data$RH_PI_F_2_1_1[x] > -9000) data$RH_PI_F_2_1_1[x] else data$RH_1_1_1[x]  # rh
  data1[x,6] = data$PA_1_1_1[x]  # air pressure
  data1[x,7] = if(data$WS_1_1_1[x] > -9000) data$WS_1_1_1[x] else data$WS_2_1_1[x]  # wind speed
  data1[x,8] = if(data$SW_IN_1_1_1[x] > -9000) data$SW_IN_1_1_1[x] else data$SW_IN_2_1_1[x]  # short wave radiation
  data1[x,9] = data$LW_IN_1_1_1[x] # long wave radiation
  }
for(x in (438001+48):(455520-48))
{
  data1[x,3] = if(data1[x,3] > -9000) data1[x,3] else mean(data1[x-48,3],data1[x+48,3])
  data1[x,4] = if(data1[x,4] > -9000) data1[x,4] else mean(data1[x-48,4],data1[x+48,4])
  data1[x,5] = if(data1[x,5] > -9000) data1[x,5] else mean(data1[x-48,5],data1[x+48,5])
  data1[x,6] = if(data1[x,6] > -9000) data1[x,6] else mean(data1[x-48,6],data1[x+48,6])
  data1[x,7] = if(data1[x,7] > -9000) data1[x,7] else mean(data1[x-48,7],data1[x+48,7])
  data1[x,8] = if(data1[x,8] > -9000) data1[x,8] else mean(data1[x-48,8],data1[x+48,8])
#  data1[x,8] = if(data1[x,8] > 0) data1[x,8] else 0.0     # set the minimum short wave radiation as zero 
  data1[x,9] = if(data1[x,9] > -9000) data1[x,9] else mean(data1[x-48,9],data1[x+48,9])
}

plot(data1[438001:455520,3]) # quick data quality control
plot(data1[438001:455520,4]) # quick data quality control
plot(data1[438001:455520,5]) # quick data quality control
plot(data1[438001:455520,6]) # quick data quality control
plot(data1[438001:455520,7]) # quick data quality control
plot(data1[438001:455520,8]) # quick data quality control
plot(data1[438001:455520,9]) # quick data quality control

for(x in 17521:438000)
{
  data1[455521-x,3] = if(data1[455521-x,3] > -9000) data1[455521-x,3] else data1[455521+17520-x,3]
  data1[455521-x,4] = if(data1[455521-x,4] > -9000) data1[455521-x,4] else data1[455521+17520-x,4]  
  data1[455521-x,5] = if(data1[455521-x,5] > -9000) data1[455521-x,5] else data1[455521+17520-x,5]  
  data1[455521-x,6] = if(data1[455521-x,6] > -9000) data1[455521-x,6] else data1[455521+17520-x,6]  
  data1[455521-x,7] = if(data1[455521-x,7] > -9000) data1[455521-x,7] else data1[455521+17520-x,7]  
  data1[455521-x,8] = if(data1[455521-x,8] > -9000) data1[455521-x,8] else data1[455521+17520-x,8] 
#  data1[455521-x,8] = if(data1[455521-x,8] > 0) data1[455521-x,8] else 0.0     # set the minimum short wave radiation as zero 
  data1[455521-x,9] = if(data1[455521-x,9] > -9000) data1[455521-x,9] else data1[455521+17520-x,9]  
}

for(x in 1:455520)
  {
  data1[x,7] = if(data1[x,7] > 0) data1[x,7] else 0.0     # set the minimum short wave radiation as zero 
  data1[x,8] = if(data1[x,8] > 0) data1[x,8] else 0.0     # set the minimum short wave radiation as zero 
  }

plot(data1[17521:455520,3]) # quick data quality control
plot(data1[17521:455520,4]) # quick data quality control
plot(data1[17521:455520,5]) # quick data quality control
plot(data1[17521:455520,6]) # quick data quality control
plot(data1[17521:455520,7]) # quick data quality control
plot(data1[17521:455520,8]) # quick data quality control
plot(data1[17521:455520,9]) # quick data quality control

write.csv(data1[17521:455520,], "metdata_readyfornc.csv")




