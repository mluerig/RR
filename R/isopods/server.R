 # we need to specify packages ...

library(ggplot2)
library(plotly)
library(cowplot) 

# ... and source data ...
iso<-read.delim("Sample_001a.txt", header=T, sep="\t") # n
# ... but not the working directory, this is be default the app folder



function(input, output) { # wrapper for server logic
  
  # look up reactive environment, this is where the magic happens:
  # https://shiny.rstudio.com/articles/reactivity-overview.html
  # Combine the selected variables into a new data frame
  plot1.dat <- reactive({ # this will return a 'reactive object', NOT a dataframe (see below)
    fams=input$fam # this returns a character vector from the checkboxes
    subs<-subset(iso, Family %in% fams) # this subsets our data frame

  })
  
  # render plot - "plot1" will be sent over to ui.R
    output$plot1 <- renderPlot({
      p<-ggplot(plot1.dat(), # the ()brackets here are important, they turn plot1.dat into a data frame
                aes(x=Length, y=Pigmentation, colour=Family)) +
    geom_point(size=4)
    p

  })
}