# code originally developed by Liyuan He at EMAIL lab at SDSU for plotting ternary plot of bacteria and fungi biomass C, same as soil MMQ (Xu et al. 2017).
# archived by Xiaofeng Xu on 9/1/2020
rm(list=ls())
library(soiltexture)

tmp <- TT.get("USDA.TT")

add_label_legend <- function(pos = "topleft", label, ...) {
  legend(pos, label, bty = "n", ...)
}

data2_corr<-read.table("data ana_PLFA.csv",sep=",", header=T)
colnames(data2_corr)=c("ID","Meth","MAT_ori","MAT_adj","MAP_ori","MAP_adj","Lat","Lon","biome","Cden_abo","Cden_bel","GPP","NPP","clay","silt","sand","bd","pH","SM","ST","OC_orig","TN_orig","CN_rat","bac_biomass","fun_biomass","fun_bac_rat")

shapiro.test(data2_corr$bac_biomass)
shapiro.test(data2_corr$fun_biomass)
shapiro.test(data2_corr$fun_bac_rat)

data2_corr$bac_biomass_log=log10(data2_corr$bac_biomass)
data2_corr$fun_biomass_log=log10(data2_corr$fun_biomass)
data2_corr$fun_bac_rat_log=log10(data2_corr$fun_bac_rat)

data_ternary_bac<-data.frame(data2_corr$clay, data2_corr$silt, data2_corr$sand, data2_corr$bac_biomass_log)
data_ternary_fun<-data.frame(data2_corr$clay, data2_corr$silt, data2_corr$sand, data2_corr$fun_biomass_log)
data_ternary_rat<-data.frame(data2_corr$clay, data2_corr$silt, data2_corr$sand, data2_corr$fun_bac_rat_log)

data_ternary_bac<-na.omit(data_ternary_bac)
data_ternary_fun<-na.omit(data_ternary_fun)
data_ternary_rat<-na.omit(data_ternary_rat)

colnames(data_ternary_bac)=c("CLAY","SILT","SAND","Z")
colnames(data_ternary_fun)=c("CLAY","SILT","SAND","Z")
colnames(data_ternary_rat)=c("CLAY","SILT","SAND","Z")

texture_abr<-c("Cl:",
"SiCl:",
"SaCl:",
"ClLo:",
"SiClLo:",
"SaClLo:",
"Lo:",
"SiLo:",
"SaLo:",
"Si:",
"LoSa:",
"Sa:")
texture_ori<-c("clay",
"silty clay",
"sandy clay",
"clay loam",
"silty clay loam",
"sandy clay loam",
"loam",
"silty loam",
"sandy loam",
"silt",
"loamy sand",
"sand")

png("funbac_ternary.png", width=20,height=20,units="cm",res=1200)
par(mar=c(0,0,0,0),family="Times New Roman")
loc<-layout(matrix(c(1,3,2,4),2,2))
layout.show(loc)

geo_fun <- TT.baseplot(main ="", new.mar = c(2,0,1,0))
title("Fungi biomass-C", line = -1)

iwd.res_fun <- TT.iwd (
      geo         = geo_fun,
      tri.data    = data_ternary_fun,
      pow = 0.0001, # Low values means strong smoothing
      z.name ="Z"
      )

TT.image(
    x = iwd.res_fun,
    col = rev(heat.colors(64)),
    geo = geo_fun,
    add=TRUE
    )

TT.contour(
	x = iwd.res_fun,
	geo = geo_fun,
	add = TRUE,
	lwd = 1,
	nlevels = 4,
  labcex = 0.7,
  levels = c(5.3, 5.4, 5.5, 5.6),
  labels = c(199526, 251189, 316228, 398107)
	)

TT.plot(
    tri.data= data_ternary_fun,
    geo= geo_fun,
    grid.show= FALSE,
    class.sys   = "USDA.TT",
    add= TRUE,
    col= "transparent",
    pch = 16,
    cex.lab = 0.9,
 
    col.lab = "black",
	  class.lab.show="abr",
	  cex.axis = 1
)

add_label_legend("right", cex=1.5, paste0("(", LETTERS[1], ")"))


geo_bac <- TT.baseplot(main = "", new.mar = c(2,0,1,0))
title("Bacteria biomass-C", line = -1)

iwd.res_bac <- TT.iwd (
      geo         = geo_bac,
      tri.data    = data_ternary_bac,
      pow = 0.0001, # Low values means strong smoothing
      z.name ="Z"
      )

TT.image(
    x = iwd.res_bac,
    col = rev(heat.colors(64)),
    geo = geo_bac,
    add=TRUE
    )

TT.contour(
	x = iwd.res_bac,
	geo = geo_bac,
	add = TRUE,
	lwd = 1,
  labcex = 0.7,
  levels = c(4.5, 4.6, 4.7, 4.8, 4.9, 5, 5.1),
  labels = c(31623, 39811, 50119, 63096, 79433, 100000, 125893),
	nlevels = 7
	)

TT.plot(
    tri.data= data_ternary_bac,
    geo= geo_bac,
    grid.show= FALSE,
    class.sys   = "USDA.TT",
    add= TRUE,
    col= "transparent",
    pch = 16,
    cex.lab = 0.9,
    col.lab = "black",
	  class.lab.show="abr",
	  cex.axis = 1,
    new.mar = c(0,0,1,0)
)

add_label_legend("right", cex=1.5, paste0("(", LETTERS[2], ")"))

geo_rat <- TT.baseplot(main = "", new.mar = c(2,0,1,0))
title("Fungi:bacteria biomass-C ratio", line = -1)

iwd.res_rat <- TT.iwd (
      geo         = geo_rat,
      tri.data    = data_ternary_rat,
      pow = 0.0001, # Low values means strong smoothing
      z.name ="Z"
      )

TT.image(
    x = iwd.res_rat,
    col = rev(heat.colors(64)),
    geo = geo_rat,
    add=TRUE,
    family.op = "Times New Roman"
    )

TT.contour(
	x = iwd.res_rat,
	geo = geo_rat,
	add = TRUE,
	lwd = 1,
  labcex = 0.7,
  levels = c(0.1, 0.2, 0.3,0.4,0.5,0.6,0.7, 0.8, 0.9,1),
  labels = c(1.26, 1.59, 2.0, 2.51, 3.16, 3.98, 5.01, 6.31, 7.94, 10),
	nlevels = 10
	)

TT.plot(
    tri.data= data_ternary_rat,
    geo= geo_rat,
    grid.show= FALSE,
    class.sys   = "USDA.TT",
    add= TRUE,
    col= "transparent",
    pch = 16,
    cex.lab = 0.9,
    col.lab = "black",
	  class.lab.show="abr",
	  cex.axis = 1,
    new.mar = c(0,0,1,0)
)

add_label_legend("right", cex=1.5, paste0("(", LETTERS[3], ")"))

par(mai=c(0,0,0,0))
plot.new()
L_abr = legend(x = 'left', legend = texture_abr, cex=1.4, box.col = "transparent", inset= 0.1, bg = NA, text.font = 2)

# use position data of previous legend to draw legend with invisble lines and points but with labels and box. x.intersp controls distance between lines and labels
L_ori = legend(x ='center', legend = texture_ori, cex=1.4, box.col = "transparent", inset= 0, bg = NA, text.font = 2)

L_tit = legend (x= 'top', legend = "Legend", cex=2, box.col = "transparent", bg = NA, text.font = 2)

dev.off()
