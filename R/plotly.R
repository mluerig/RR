library(ggplot2)
library(plotly)

setwd("E://GitHub//RR//R//")
data = "E://GitHub//RR//data//"



iso<-read.delim(paste0(data, "/Sample_001a.txt"), header=T, sep="\t")


# 1) ggplotly() --------------------------------------------------------


# make plot
p<-ggplot(iso, aes(x=Length, y=Pigmentation)) +
  geom_point()

ggplotly(p)


# add fit
p <- p + geom_smooth(method="lm", se=F)
ggplotly(p)


# make plot add colour based on family
p<-ggplot(iso, aes(x=Length, y=Pigmentation, colour=Family)) +
  geom_point()

ggplotly(p)
  

# play around with the functions (e.g. lasse select, double click on legends, etc,)
# there is a lot you can do


# 2) plotly also has native plotting functions --------------------------------

p <- plot_ly(data = iso, x = ~Length, y = ~Pigmentation, color= ~Family, type = "scatter")
p

p <- plot_ly(x = ~Pigmentation, type = "histogram", data=iso, xbins=20)
p 


# 3)

# click on "export-> save as webpage" = neat html
