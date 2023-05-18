library("RNetCDF")
library("akima")
setwd("/Users/xxu/Documents/BUSINESS/PUBLICATIONS/WorkingOn_Xu_Howland/Met_data")

data <- read.table("data_ready_nc.txt", header=TRUE) # read in the data

mday = c(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)
mname = c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12")
x = 1
lat = 1
lon = 1
scalar = 1

LONGXY <- array(0., c(1,1))
LATIXY <- array(0., c(1,1))

EDGEW = 291.1597
EDGEE = 291.3597
EDGES = 45.1041
EDGEN = 45.3041
LONGXY[1,1] = 291.2597
LATIXY[1,1] = 45.2041

for(year in 1996:2020) 
  {
  for(mon in 1:12)
  {
    # january
    timestep = mday[mon] * 48
    time <- array(0., c(timestep))
    zbot <- array(2., c(lon, lat, timestep))
    tbot <- array(0., c(lon, lat, timestep))
    rh <- array(0., c(lon, lat, timestep))
    wind <- array(0., c(lon, lat, timestep))
    fsds <- array(0., c(lon, lat, timestep))
    flds <- array(0., c(lon, lat, timestep))
    psrf <- array(0., c(lon, lat, timestep))
    prec <- array(0., c(lon, lat, timestep))
    
    for(dofm in 1:timestep)
      {
      time[dofm] = 0.0 + 1.0/48 * (dofm-1)
      }
    ofile <- paste("./nc/", year, "-", mname[mon], ".nc", sep="")
    onc <- create.nc(ofile)
    # define dimensions, scalar, lon, lat, and time 
    dim.def.nc(onc, "scalar", 1)  
    dim.def.nc(onc, "lon", 1)  
    dim.def.nc(onc, "lat", 1)  
    dim.def.nc(onc, "time", timestep)  
    # create seven variables
    var.def.nc(onc, "time", "NC_FLOAT", "time")
    var.def.nc(onc, "LONGXY", "NC_FLOAT", c("lon", "lat"))
    var.def.nc(onc, "LATIXY", "NC_FLOAT", c("lon", "lat"))
    var.def.nc(onc, "EDGEW", "NC_FLOAT", c("scalar"))
    var.def.nc(onc, "EDGEE", "NC_FLOAT", c("scalar"))
    var.def.nc(onc, "EDGES", "NC_FLOAT", c("scalar"))
    var.def.nc(onc, "EDGEN", "NC_FLOAT", c("scalar"))
    var.def.nc(onc, "ZBOT", "NC_FLOAT", c("lon", "lat", "time"))
    var.def.nc(onc, "TBOT", "NC_FLOAT", c("lon", "lat", "time"))
    var.def.nc(onc, "RH", "NC_FLOAT", c("lon", "lat", "time"))
    var.def.nc(onc, "WIND", "NC_FLOAT", c("lon", "lat", "time"))
    var.def.nc(onc, "FSDS", "NC_FLOAT", c("lon", "lat", "time"))
    var.def.nc(onc, "FLDS", "NC_FLOAT", c("lon", "lat", "time"))
    var.def.nc(onc, "PSRF", "NC_FLOAT", c("lon", "lat", "time"))
    var.def.nc(onc, "PRECTmms", "NC_FLOAT", c("lon", "lat", "time"))

    att.put.nc(onc, "time", "long_name", "NC_CHAR", "observation time")
    att.put.nc(onc, "time", "units", "NC_CHAR", paste("days since ", year, "-", mname[mon], "-01 00:00:00", sep=""))
    att.put.nc(onc, "time", "calendar", "NC_CHAR", "noleap")

    att.put.nc(onc, "LONGXY", "long_name", "NC_CHAR", "longitude")
    att.put.nc(onc, "LONGXY", "units", "NC_CHAR", "degrees E")
    
    att.put.nc(onc, "LATIXY", "long_name", "NC_CHAR", "latitude")
    att.put.nc(onc, "LATIXY", "units", "NC_CHAR", "degrees N")

    att.put.nc(onc, "EDGEW", "long_name", "NC_CHAR", "western edge in atmospheric data")
    att.put.nc(onc, "EDGEW", "units", "NC_CHAR", "degrees E")
    att.put.nc(onc, "EDGEE", "long_name", "NC_CHAR", "eastern edge in atmospheric data")
    att.put.nc(onc, "EDGEE", "units", "NC_CHAR", "degrees E")
    
    att.put.nc(onc, "EDGES", "long_name", "NC_CHAR", "southern edge in atmospheric data")
    att.put.nc(onc, "EDGES", "units", "NC_CHAR", "degrees N")
    att.put.nc(onc, "EDGEN", "long_name", "NC_CHAR", "northern edge in atmospheric data")
    att.put.nc(onc, "EDGEN", "units", "NC_CHAR", "degrees N")

     att.put.nc(onc, "ZBOT", "long_name", "NC_CHAR", "observational height")
     att.put.nc(onc, "ZBOT", "units", "NC_CHAR", "m")
     att.put.nc(onc, "ZBOT", "Mode", "NC_CHAR", "time-dependent")

     att.put.nc(onc, "TBOT", "long_name", "NC_CHAR", "temperature at the lowest atm level (TBOT)")
     att.put.nc(onc, "TBOT", "units", "NC_CHAR", "K")
     att.put.nc(onc, "TBOT", "Mode", "NC_CHAR", "time-dependent")

     att.put.nc(onc, "RH", "long_name", "NC_CHAR", "relative huidity at the lwest atm level (RH)")
     att.put.nc(onc, "RH", "units", "NC_CHAR", "%")
     att.put.nc(onc, "RH", "Mode", "NC_CHAR", "time-dependent")

     att.put.nc(onc, "WIND", "long_name", "NC_CHAR", "wind at the lowest atm level (WIND)")
     att.put.nc(onc, "WIND", "units", "NC_CHAR", "m/s")
     att.put.nc(onc, "WIND", "Mode", "NC_CHAR", "time-dependent")

     att.put.nc(onc, "FSDS", "long_name", "NC_CHAR", "incident solar (FSDS)")
     att.put.nc(onc, "FSDS", "units", "NC_CHAR", "W/m2")
     att.put.nc(onc, "FSDS", "Mode", "NC_CHAR", "time-dependent")

     att.put.nc(onc, "FLDS", "long_name", "NC_CHAR", "incident longwave (FLDS)")
     att.put.nc(onc, "FLDS", "units", "NC_CHAR", "W/m2")
     att.put.nc(onc, "FLDS", "Mode", "NC_CHAR", "time-dependent")

     att.put.nc(onc, "PSRF", "long_name", "NC_CHAR", "pressure at the lowest atm level (PSRF)")
     att.put.nc(onc, "PSRF", "units", "NC_CHAR", "Pa")
     att.put.nc(onc, "PSRF", "Mode", "NC_CHAR", "time-dependent")

     att.put.nc(onc, "PRECTmms", "long_name", "NC_CHAR", "precipitation (PRECTmms)")
     att.put.nc(onc, "PRECTmms", "units", "NC_CHAR", "mm/s")
     att.put.nc(onc, "PRECTmms", "Mode", "NC_CHAR", "time-dependent")

    tbot[1,1,] <- data[x:(x+timestep-1),6] + 273.15    # temperature at half an hour time step
    prec[1,1,] <- data[x:(x+timestep-1),7] / 1800.0   # precipitation convert from mm per half an hour to mm / s
    rh[1,1,] <- data[x:(x+timestep-1),8]      # rh
    psrf[1,1,] <- data[x:(x+timestep-1),9] * 1000.0    # air pressure
    wind[1,1,] <- data[x:(x+timestep-1),10]   # wind speed
    fsds[1,1,] <- data[x:(x+timestep-1),11]   # short wave radiation
    flds[1,1,] <- data[x:(x+timestep-1),12]   # long wave radiation
    
    var.put.nc(onc, "time", time, start=c(1), count=timestep)
    var.put.nc(onc, "LONGXY", LONGXY)
    var.put.nc(onc, "LATIXY", LATIXY)
    var.put.nc(onc, "EDGEW", EDGEW)
    var.put.nc(onc, "EDGEE", EDGEE)
    var.put.nc(onc, "EDGES", EDGES)
    var.put.nc(onc, "EDGEN", EDGEN)
    var.put.nc(onc, "ZBOT", zbot, start=c(1,1,1), count=c(1,1,timestep))
    var.put.nc(onc, "TBOT", tbot, start=c(1,1,1), count=c(1,1,timestep))
    var.put.nc(onc, "RH", rh, start=c(1,1,1), count=c(1,1,timestep))
    var.put.nc(onc, "WIND", wind, start=c(1,1,1), count=c(1,1,timestep))
    var.put.nc(onc, "FSDS", fsds, start=c(1,1,1), count=c(1,1,timestep))
    var.put.nc(onc, "FLDS", flds, start=c(1,1,1), count=c(1,1,timestep))
    var.put.nc(onc, "PSRF", psrf, start=c(1,1,1), count=c(1,1,timestep))
    var.put.nc(onc, "PRECTmms", prec, start=c(1,1,1), count=c(1,1,timestep))
    
    att.put.nc(onc, "NC_GLOBAL", "title", "NC_CHAR", "CLM-Microbe model driving forces for the Howland forest site")
    att.put.nc(onc, "NC_GLOBAL", "institute", "NC_CHAR", "San Diego State University")
    att.put.nc(onc, "NC_GLOBAL", "author", "NC_CHAR", "Xiaofeng Xu (xxu@sdsu.edu)")
    att.put.nc(onc, "NC_GLOBAL", "site location", "NC_CHAR", "Latitude:  45.20410   Longitude:   291.25970 Elevation (masl):   29.")
    att.put.nc(onc, "NC_GLOBAL", "title", "NC_CHAR", "CLM-Microbe model driving forces for the Howland forest site")
    att.put.nc(onc, "NC_GLOBAL", "history", "NC_CHAR", paste("Created on", date()))

    close.nc(onc)
    # end of month
    x <- x + timestep
    }    
}
