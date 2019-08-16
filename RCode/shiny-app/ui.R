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
    title = "Exploring R Shiny",
    theme = shinytheme("cyborg"),
    
    ## ========================================
    ## Washington Weather Map
    ## ========================================
    tabPanel("Maps",
             fluidPage(fluidRow(
                 
                 # tags$script(HTML("$('body').addClass('fixed');")),
                 # br(), br(),
                 
                 ## ===========================
                 ## Sidebar
                 ## ===========================
                 column(2,
                        
                        # ---------------------
                        # Map Input
                        # ---------------------
                        fluidRow(
                            column(8, 
                            selectInput("map.city", label = h5("Select City"), 
                                        choices = c("Seattle"), selected = "Seattle")),
                            
                            column(4,
                            numericInput("map.zoom", label = h5("Zoom"), value = 11))
                        ),
                        
                        # ---------------------
                        # City Description
                        # ---------------------
                        fluidRow(
                            tableOutput("CityDescription")
                        )
                        
                 ),
                 
                 ## ===========================
                 ## Main
                 ## ===========================
                 column(10,

                        mainPanel( 
                            width = 12,
                            tabsetPanel(
                                tabPanel("Geography", leafletOutput("GeographyMap", height = 800)),
                                tabPanel("Weather")
                            )
                        )


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
