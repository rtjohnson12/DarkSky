###############################################
##
##  DarkSky: RShiny ~ UI
## 
##  author: Ryan Johnson
##  created: Aug 2019
##  
###############################################

shinyUI(navbarPage(
    ## ========================================
    ## Global UI Settings
    ## ========================================
    title = "DarkSky API",
    theme = shinytheme("cyborg"),
    
    ## ========================================
    ## Washington Weather Map
    ## ========================================
    tabPanel("Weather map",
             fluidPage(fluidRow(
                 
                 # tags$script(HTML("$('body').addClass('fixed');")),
                 # br(), br(),
                 
                 ## ===========================
                 ## Sidebar
                 ## ===========================
                 column(2, "sidebar",
                        
                        selectInput("map.city", label = h3("Select City"), 
                                    choices = list("Seattle" = 1), 
                                    selected = 1)
                        
                 ),
                 
                 ## ===========================
                 ## Main
                 ## ===========================
                 column(10, "main",
                        
                        renderLeaflet("WeatherMap", width="100%", height="100%")
                        
                 )
                 
             ))   
    ),
    
    ## ========================================
    ## Second Page
    ## ========================================
    tabPanel("Component 2"
             
             
    ),
    
    ## ========================================
    ## Additional Pages
    ## ========================================
    navbarMenu("More",
               tabPanel("Sub A"),
               tabPanel("Sub B")
    )
))
