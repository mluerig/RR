# there are many different layout concepts, i.e. overall 
# this one, as you may have guessed, is a single page with a sidebar, which will have
# a sidebar panel where we can add control elements, and a main panel where we can display some stuff sent over 
# from the server code
pageWithSidebar(
  
  headerPanel("Sample 001"),
  
  sidebarPanel(

    
    # checkboxes with input
    checkboxGroupInput("fam", # this will be our hook (input$fam on the server side)
                       c("Choose families:"),
                       choiceNames = # we can rename the input
                         list("Family 1", "Family 2",
                              "Family 3", "Family 4"),
                       choiceValues = # on the server side, input$var will be substituted with whatever we select
                         list("fam1", "fam2", "fam3", "fam4"), 
                              selected = "fam1"
    )
    
    
    ),

  mainPanel(plotOutput('plot1') # sent over from server
            )
)
    

