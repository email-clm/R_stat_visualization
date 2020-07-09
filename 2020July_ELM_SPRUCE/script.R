#July 8 2020. R script processing model validation against observational data of ch4, doc, and ace ELM_SPRUCE

getwd()
setwd("/Users/xxuadmin/BUSINESS/PUBLICATIONS/Published/2020/2020_Ricciuto_Xu_ELM_SPRUCE/20200708/r")

dailych4 <- read.table("dailych4flux", header=TRUE)
summary(lm(dailych4$ModeledCH4~dailych4$ObservedCH4Hanson))
out1 <- capture.output(summary(lm(dailych4$ModeledCH4~dailych4$ObservedCH4Hanson)))
cat("comparision of Hanson CH4 with ELM_SPRUCE", out1, file="statistic_output.txt", sep=" ", append=TRUE)


dailych4_s <- read.table("dailych4flux_bridgham", header=TRUE)
summary(lm(dailych4_s$ModeledCH4~dailych4_s$ObservedCH4Bridgham))
out2 <- capture.output(summary(lm(dailych4_s$ModeledCH4~dailych4_s$ObservedCH4Bridgham)))
cat("comparision of Bridgham CH4 with ELM_SPRUCE", out2, file="statistic_output.txt", sep=" ", append=TRUE)


dailych4_clm4me <- read.table("dailych4flux_clm4me", header=TRUE)
summary(lm(dailych4_clm4me$CLM4Me~dailych4_clm4me$ObservedCH4Hanson))
out3 <- capture.output(summary(lm(dailych4_clm4me$CLM4Me~dailych4_clm4me$ObservedCH4Hanson)))
cat("comparision of Hanson CH4 with CLM4Me", out3, file="statistic_output.txt", sep=" ", append=TRUE)


DOC <- read.table("DOC", header=TRUE)
summary(lm(DOC$ModeledDOC~DOC$ObservedDOC))
out4 <- capture.output(summary(lm(DOC$ModeledDOC~DOC$ObservedDOC)))
cat("comparision of DOC with ELM_SPRUCE", out4, file="statistic_output.txt", sep=" ", append=TRUE)


ACE <- read.table("ACE", header=TRUE)
summary(lm(ACE$ModeledACE~ACE$ObservedACE))
out5 <- capture.output(summary(lm(ACE$ModeledACE~ACE$ObservedACE)))
cat("comparision of Acetate with ELM_SPRUCE", out5, file="statistic_output.txt", sep=" ", append=TRUE)
