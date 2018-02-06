# python

setwd("E://Github//RR//data//raw//")

rm(list = ls())

# read
filename = "Sample_001b_raw.txt"
fn.noex = "Sample_001b"
file<-read.table(filename, sep = "\t", header = TRUE) #, colClasses = "character"

# add some info
file$ID<-paste0("ID",file$PyLabel)
file$Source_File<-paste0(fn.noex, "_",file$ID, ".jpg")
file$CV<-file$StdDev/file$Mean
file$Pigmentation<-abs(file$Mean-255)/255
file$log.Length<-log10(file$Length)

# add family information
set.seed(4)
file$Family<-paste0("fam",sample(1:4, nrow(file), replace=T))

# add some url
file$Link<-paste0("https://mluerig.github.io/RR/data/images/",fn.noex,"/", fn.noex,"_",file$ID, ".jpg")

#write
write.table(file, paste0("../",fn.noex,".txt"), sep = "\t")


ggplot(file, aes(x=Length, y=Pigmentation)) +
  geom_point(aes(colour=Family))



