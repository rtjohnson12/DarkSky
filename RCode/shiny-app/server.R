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
            Seattle = list(lng = -122.3320708, lat = 47.6062095),
            `Santa Clara` = list(lng = -121.955238, lat = 37.354107)
        )
        
    })
    
    wikipedia.url <- reactive({
        
        switch(
            input$map.city,
            Seattle = "https://en.wikipedia.org/wiki/Seattle",
            `Santa Clara` = "https://en.wikipedia.org/wiki/Santa_Clara,_California"
        )
    })
    
    map.forecast <- reactive({
        
        darksky::get_forecast_for(map.coordinates()$lat, map.coordinates()$lng, today())
        
    })
    
    ## ========================================
    ## Server Output
    ## ========================================
    output$GeographyMap <- renderLeaflet({
        
        # map parameters
        map.coordinates <- map.coordinates()
        map.zoom <- 11
        
        # map setup
        m <- leaflet() %>% addTiles() %>% 
            setView(lng = map.coordinates$lng, lat = map.coordinates$lat, zoom = map.zoom) %>%
            addMiniMap(zoomLevelOffset = -4)
        
        # render map
        m
    })
    
    output$TopographyMap <- renderLeaflet({
        
        # map parameters
        map.coordinates <- map.coordinates()
        map.zoom <- 11
        
        nhd.wms.url <- "https://basemap.nationalmap.gov/arcgis/services/USGSTopo/MapServer/WmsServer"
        
        # map setup
        m <- leaflet() %>% addTiles() %>% 
            setView(lng = map.coordinates$lng, lat = map.coordinates$lat, zoom = map.zoom) %>% 
            addWMSTiles(nhd.wms.url, layers = "0")
        
        # render map
        m
    })
    
    output$CityDescription <- renderTable({
        
        city <- input$map.city
        
        # scrape wikipedia
        info.box <- wikipedia.url() %>% 
            read_html() %>% 
            html_nodes("table.vcard") %>% 
            html_table(header=FALSE, fill=TRUE) %>% 
            .[[1]] %>% as.data.frame()
        
        clean.info.box <- switch(
            city,
            Seattle = info.box %>% 
                # select non-image features
                dplyr::slice(c(5:6, 10:37, 39:nrow(info.box))) %>% 
                # remove annotations
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
                }),
            `Santa Clara` = info.box %>% 
                # select non-image features
                dplyr::slice(c(9:30, 32:nrow(info.box))) %>% 
                # remove annotations
                dplyr::mutate(X1 = gsub("\\[.*\\]", "", X1),
                              X2 = gsub("\\[.*\\]", "", X2)) %>% 
                
                do({
                    # city government
                    .[6,2] = ""
                    
                    # city area
                    .[11,2] = ""
                    
                    # city population
                    .[16,2] = ""
                    
                    # ----
                    .
                })
        )
        
        # render table
        clean.info.box
        
    }, colnames = FALSE, hover = TRUE)
    
})
