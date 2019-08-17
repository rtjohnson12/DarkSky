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
    title = "Otenki ~ お天気",
    theme = shinytheme("cyborg"),
    
    ## ========================================
    ## Second Page
    ## ========================================
    tabPanel("Places I've Been",
             fluidPage(fluidRow(
                 
                 column(12,
                        
                        leafletOutput("WorldMap", height = 800)
                        
                        ) # <!-- column -->
                 
             )) # <!-- fluidPage / fluidRow -->
             
    ), # <!-- tabPanel -->
    
    ## ========================================
    ## Maps for Individual Cities
    ## ========================================
    tabPanel("City Maps",
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
                            column(12, 
                            selectInput("map.city", label = h5("Select City"), 
                                         choices = c("Seattle", "Santa Clara"), 
                                         selected = "Seattle"))
                        ), # <!-- fluidRow -->
                        
                        # ---------------------
                        # City Description
                        # ---------------------
                        fluidRow(
                            column(12,
                            tableOutput("CityDescription"))
                        ) # <!-- fluidRow -->
                        
                 ), # <!-- column -->
                 
                 ## ===========================
                 ## Main
                 ## ===========================
                 column(10,
                        
                        mainPanel( 
                            width = 12,
                            tabsetPanel(
                                tabPanel("Geography", leafletOutput("GeographyMap", height = 900))
                                # , tabPanel("Topography", leafletOutput("TopographyMap", height = 900))

                            ) # <!-- tabsetPanel -->
                        ) # <!-- mainPanel -->
                        
                        
                 ) # <!-- column -->
                 
             )) # <!-- fluidPage / fluidRow -->
    ), # <!-- tabPanel -->
    
    ## ========================================
    ## Additional Pages
    ## ========================================
    navbarMenu("More",
               tabPanel("Sub A"
                        
                        ), # <!-- tabPanel -->
               tabPanel("Sub B"
                        
                        ) # <!-- tabPanel -->
    ) # <!-- navbarMenu -->
)) # <!-- navbarPage / shinyUI -->
