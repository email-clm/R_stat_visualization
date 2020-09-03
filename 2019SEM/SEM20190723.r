# 2019 July 23, this SEM code for controling factors on soil DOC concentration

library(lavaan)
DOC <- read.csv("/Users/????/sem.csv")
attach(DOC)

# DOC file contains variables: SoilT, SW, NPP, TOC, Clay, Sand, pH

model <- '
log_DOC ~ SoilT + SW + NPP + TOC + Clay + Sand + pH
NPP ~ SoilT + SW + pH + Sand
TOC ~ pH + SW + Sand + Clay
'

fit <- sem(model, data=na.omit(a), std.ov=TRUE)
summary(fit,standardized=T,fit.measures =T)
standardizedSolution(fit)
fitmeasures(fit) # print key measurs for the SEM
mod_ind <- modificationindices(fit)
head(mod_ind[order(mod_ind$mi, decreasing=TRUE), ], 10)   # ranking changes for improving SEM
