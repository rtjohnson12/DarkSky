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
    tabPanel("Places",
             fluidPage(fluidRow(
                 
                 column(3,
                        HTML('<div class="card mb-3">
  <h3 class="card-header">Card header</h3>
  <div class="card-body">
    <h5 class="card-title">Special title treatment</h5>
    <h6 class="card-subtitle text-muted">Support card subtitle</h6>
  </div>
  <img style="height: 200px; width: 100%; display: block;" src="data:image/svg+xml;charset=UTF-8,%3Csvg%20width%3D%22318%22%20height%3D%22180%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%20318%20180%22%20preserveAspectRatio%3D%22none%22%3E%3Cdefs%3E%3Cstyle%20type%3D%22text%2Fcss%22%3E%23holder_158bd1d28ef%20text%20%7B%20fill%3Argba(255%2C255%2C255%2C.75)%3Bfont-weight%3Anormal%3Bfont-family%3AHelvetica%2C%20monospace%3Bfont-size%3A16pt%20%7D%20%3C%2Fstyle%3E%3C%2Fdefs%3E%3Cg%20id%3D%22holder_158bd1d28ef%22%3E%3Crect%20width%3D%22318%22%20height%3D%22180%22%20fill%3D%22%23777%22%3E%3C%2Frect%3E%3Cg%3E%3Ctext%20x%3D%22129.359375%22%20y%3D%2297.35%22%3EImage%3C%2Ftext%3E%3C%2Fg%3E%3C%2Fg%3E%3C%2Fsvg%3E" alt="Card image">
  <div class="card-body">
    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the cards content.</p>
                                 </div>
                                 <ul class="list-group list-group-flush">
                                 <li class="list-group-item">Cras justo odio</li>
                                 <li class="list-group-item">Dapibus ac facilisis in</li>
                                 <li class="list-group-item">Vestibulum at eros</li>
                                 </ul>
                                 <div class="card-body">
                                 <a href="#" class="card-link">Card link</a>
                                 <a href="#" class="card-link">Another link</a>
                                 </div>
                                 <div class="card-footer text-muted">
                                 2 days ago
                             </div>
                                 </div>
                                 <div class="card">
                                 <div class="card-body">
                                 <h4 class="card-title">Card title</h4>
                                 <h6 class="card-subtitle mb-2 text-muted">Card subtitle</h6>
                                 <p class="card-text">Some quick example text to build on the card title and make up the bulk of the cards content.</p>
    <a href="#" class="card-link">Card link</a>
    <a href="#" class="card-link">Another link</a>
  </div>
</div>')
                 ), # <!-- column -->
                 
                 column(9,
                        mainPanel( 
                            width = 12,
                            tabsetPanel(
                                tabPanel("US", leafletOutput("USMap", height = 900))
                                , tabPanel("Europe", leafletOutput("EuropeMap", height = 900))
                                
                            ) # <!-- tabsetPanel -->
                        ) # <!-- mainPanel -->
                        
                        
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
