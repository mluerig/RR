library(ggplot2)
library(rggobi)
library(cowplot) # makes nice bw plots


setwd("E://GitHub//RR//R//")


iso<-read.delim("../data/Sample_001a.txt", header=T, sep="\t")


# we are interested in pigmentation and body size
# plot and inspect the data
p<-ggplot(iso, aes(x=Length, y=Pigmentation)) +
  geom_point()
p

# show families
p<-ggplot(iso, aes(x=Length, y=Pigmentation, colour=Family)) +
  geom_point()

p



# send to ggobi
g <- ggobi(iso)

# select appropriate x and y axes and show them (plot panel > options > show axes)

# go the interaction > identify. you can change the value you would like to have returned, e.g. Family or ID

# go to tools > automatic brush and select family from the dropdown ... 
# ... or do it from R:


glyph_colour(g[1])<-iso$Family



# make up fake data to do a PCA:
iso$Width <- sqrt(iso$Area)*runif(nrow(iso), min=.5, max=1.8) 
iso$HeadArea <- (iso$Area/6)*runif(nrow(iso), min=0.4, max=1.6)

g <- ggobi(iso)

# go to tools > sphering  and add variables you want include in a PCA (shift hold + click)
# save file, and read to R

iso.px<-read.csv("iso.pca.csv", header=T)

