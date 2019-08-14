###############################################
##
##  DarkSky: RShiny ~ Server
## 
##  author: Ryan Johnson
##  created: Aug 2019
##  
###############################################

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    output$distPlot <- renderPlot({
        hist(rnorm(input$obs))
    })
    
})
