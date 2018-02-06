# python

setwd("E:\\Github\\RR\\data\\")

rm(list = ls())


#####START#####--------------------------------------------------------------------------------------

filename = "Sample_001b.txt"
fn.noex<-substr(filename, 1, nchar(filename)-4)
file<-read.table(filename, sep = "\t", header = TRUE) #, colClasses = "character"

file$ID<-paste0("ID",file$PyLabel)
file$Source_File<-paste0(fn.noex, "_",file$ID, ".jpg")
file$CV<-file$StdDev/file$Mean
file$Pigmentation<-abs(file$Mean-255)/255
file$log.Length<-log10(file$Length)
file$Link<-paste0("https://mluerig.github.io/RR/data/images/",fn.noex,"/", fn.noex,"_",file$ID, ".jpg")

write.table(file, paste0(fn.noex,"_processed.txt"), sep = "\t")

with(file, plot(Pigmentation, Length))




