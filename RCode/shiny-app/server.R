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
        
        # darksky::get_forecast_for(map.coordinates()$lat, map.coordinates()$lng, today())
        # owmr::get_current("Seattle", units = "metric")
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
    
    output$WorldMap <- renderLeaflet({
        
        # icon
        greenLeafIcon <- makeIcon(
            iconUrl = "http://leafletjs.com/examples/custom-icons/leaf-green.png",
            iconWidth = 38, iconHeight = 95,
            iconAnchorX = 22, iconAnchorY = 94,
            shadowUrl = "http://leafletjs.com/examples/custom-icons/leaf-shadow.png",
            shadowWidth = 50, shadowHeight = 64,
            shadowAnchorX = 4, shadowAnchorY = 62
        )
        
        # dataframe for markers
        city.data <- data.frame(
            City = character(), State = character(), Country = character(),
            Long = numeric(), Lat = numeric()
        ) %>% tibble::add_row(
            City = "Seattle", State = "WA", Country = "US",
            Long = -122.3320708, Lat = 47.6062095
        ) %>% tibble::add_row(
            City = "Santa Clara", State = "CA", Country = "US",
            Long = -121.955238, Lat = 37.354107
        ) %>% tibble::add_row(
            City = "San Francisco", State = "CA", Country = "US",
            Long = -122.4194, Lat = 37.77493
        ) %>% tibble::add_row(
            City = "Portland", State = "OR", Country = "US",
            Long = -122.676482, Lat = 45.523062
        ) %>% tibble::add_row(
            City = "Bellevue", State = "WA", Country = "US",
            Long = -122.20068, Lat = 47.61038
        ) %>% tibble::add_row(
            City = "Federal Way", State = "WA", Country = "US",
            Long = -122.3126, Lat = 47.32232
        ) %>% tibble::add_row(
            City = "Sacremento", State = "CA", Country = "US",
            Long = -121.4944, Lat = 38.58157
        ) %>% tibble::add_row(
            City = "Nampa", State = "ID", Country = "US",
            Long = -116.5635, Lat = 43.54072
        ) %>% tibble::add_row(
            City = "Salt Lake City", State = "UT", Country = "US",
            Long = -111.8911, Lat = 40.76078
        ) %>% tibble::add_row(
            City = "Spokane", State = "WA", Country = "US",
            Long = -117.4291, Lat = 47.65966
        ) %>% tibble::add_row(
            City = "Colorado Springs", State = "CO", Country = "US",
            Long = -104.8214, Lat = 38.83388
        ) %>% tibble::add_row(
            City = "Marshalltown", State = "IO", Country = "US",
            Long = -92.90798, Lat = 42.04943
        ) %>% tibble::add_row(
            City = "Jacksonville", State = "FL", Country = "US",
            Long = -81.655647, Lat = 30.332184
        ) %>% tibble::add_row(
            City = "Freiburg", State = NA, Country = "DE",
            Long = 7.85222, Lat = 47.9959
        ) %>% tibble::add_row(
            City = "Berlin", State = NA, Country = "DE",
            Long = 13.41053 , Lat = 52.52437
        ) %>% tibble::add_row(
            City = "Frankfurt", State = NA, Country = "DE",
            Long = 8.68333, Lat = 50.11667
        ) %>% tibble::add_row(
            City = "Strasbourg", State = NA, Country = "FR",
            Long = 7.74296, Lat = 48.58342
        )
        
        # %>% tibble::add_row(
        #     City = "asdf", State = "asdf", Country = "asdf",
        #     Long = asdf, Lat = asdf
        # )
        
        # owmr::search_city_list("Frankfurt", country_code = "DE")
        
        # map setup
        m <- leaflet(visit.data %>% dplyr::filter(Country == "US")) %>% addTiles() %>% 
            addMarkers(lng = ~Long, lat = ~Lat, popup = ~City)
        
        # render map
        m
    })
    
    output$TopographyMap <- renderLeaflet({
        
        # map parameters
        map.coordinates <- map.coordinates()
        map.zoom <- 11
        
        # map setup
        m <- leaflet() %>% addTiles() %>% 
            setView(lng = map.coordinates$lng, lat = map.coordinates$lat, zoom = map.zoom)
        
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
