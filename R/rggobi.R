#library(ggplot2)
library(rggobi)



setwd("E://GitHub//RR//R//")


iso<-read.delim("../data/Sample_001a.txt", header=T, sep="\t")

g <- ggobi(iso)

