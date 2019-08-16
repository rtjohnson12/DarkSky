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
    
    map.coordinates <- reactive({
        
        switch(
            input$map.city,
            Seattle = list(lng = -122.3320708, lat = 47.6062095)
        )
        
    })
    
    output$WeatherMap <- renderLeaflet({
        
        # map parameters
        map.coordinates <- map.coordinates()
        map.zoom <- 10
        
        # map setup
        m <- leaflet() %>% addTiles()
            setView(map.coordinates$lng, map.coordinates$lat, map.zoom)
            
            
        browser()
        
        # render map
        m
    })
    
})
