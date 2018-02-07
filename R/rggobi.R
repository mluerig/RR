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

# go to tools > automatic brush and select family from the dropdown

# make up fake data to do a PCA:
iso$Width<-iso$log.Length*
iso$HeadSize


# lets pretend "Area" and 


