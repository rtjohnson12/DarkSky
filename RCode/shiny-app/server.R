###############################################
##
##  DarkSky: RShiny ~ Server
## 
##  author: Ryan Johnson
##  created: Aug 2019
##  
###############################################

shinyServer(function(input, output) {
    
    ## ========================================
    ## Reactive Values
    ## ========================================
    map.coordinates <- reactive({
        
        switch(
            input$map.city,
            Seattle = list(lng = -122.3320708, lat = 47.6062095)
        )
        
    })
    
    map.forecast <- reactive({
        
        browser()
        # darksky::get_forecast_for(map.coordinates()$lat, map.coordinates()$lng, today())
        
    })
    
    ## ========================================
    ## Server Output
    ## ========================================
    output$GeographyMap <- renderLeaflet({
        
        # map parameters
        map.coordinates <- map.coordinates()
        map.zoom <- input$map.zoom
        
        # map setup
        m <- leaflet() %>% addTiles() %>% 
            setView(lng = map.coordinates$lng, lat = map.coordinates$lat, zoom = map.zoom)
        
        # render map
        m
    })
    
    output$CityDescription <- renderTable({
        
        city <- "Seattle" # input$map.city
        wikipedia.url <- glue("https://en.wikipedia.org/wiki/{city}")
        
        # scrape wikipedia
        info.box <- wikipedia.url %>% 
            read_html() %>% 
            html_nodes("table.vcard") %>% 
            html_table(header=FALSE, fill=TRUE) %>% 
            .[[1]] %>% as.data.frame()
            
        # clean up dataframe
        clean.info.box <- info.box %>% 
            dplyr::slice(c(5:6, 10:37, 39:nrow(info.box))) %>% 
            dplyr::mutate(X1 = gsub("\\[.*\\]", "", X1),
                          X2 = gsub("\\[.*\\]", "", X2)) %>% 

            do({
                # city nickname
                .[1,1] = 'Nickname'
                .[1,2] = gsub(".*:", "", .[1,2])
                
                # city motto
                .[2,1] = 'Motto'
                .[2,2] = gsub(".*:", "", .[2,2])
                
                # city government
                .[8,2] = ""
                
                # city area
                .[13,2] = ""
                
                # city population
                .[20,2] = ""
                
                # ----
                .
            })
        
        
        # render table
        clean.info.box

    }, colnames = FALSE, hover = TRUE)
    
})
