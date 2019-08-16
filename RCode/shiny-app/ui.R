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
    ## Washington Map
    ## ========================================
    tabPanel("Component 1",
             fluidPage(fluidRow(
                 
                 # tags$script(HTML("$('body').addClass('fixed');")),
                 # br(), br(),
                 
                 
                 ## ===========================
                 ## Sidebar
                 ## ===========================
                 column(2, "sidebar",
                        
                        
                        sliderInput("obs",
                                    "Number of observations:",
                                    min = 0,
                                    max = 1000,
                                    value = 500)
                        
                 ),
                 
                 ## ===========================
                 ## Sidebar
                 ## ===========================
                 column(10, "main",
                        
                        
                        plotOutput("distPlot")
                        
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
