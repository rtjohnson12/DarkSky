###############################################
##
##  DarkSky: RShiny ~ UI
## 
##  author: Ryan Johnson
##  created: Aug 2019
##  
###############################################

shinyUI(fluidPage(
    
    ## ======================================
    ## Global UI Settings
    ## ======================================
    theme = shinytheme("cyborg"),
    

    
    titlePanel("DarkSky Testing"),
    
    ## ======================================
    ## Sidebar Layout
    ## ======================================
    sidebarLayout(
        
        # -----------------------------------
        # Sidebar Setup
        # -----------------------------------
        sidebarPanel(
            sliderInput("obs",
                        "Number of observations:",
                        min = 0,
                        max = 1000,
                        value = 500)
        ),
        
        # -----------------------------------
        # Body Setup
        # -----------------------------------
        mainPanel(
            
            # tags$script(HTML("$('body').addClass('fixed');")),
            # br(), br(),
            
            plotOutput("distPlot")
        )
    )
))
