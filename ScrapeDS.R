###############################################
##
##  DarkSky: Scraping
## 
##  author: Ryan Johnson
##  created: Aug 2019
##  
###############################################

## ========================================
## Scrape Weather Data
## ========================================

API_Hist_Request <- function(latitude, longitude) {
  
}

API_Forecast_Request <- function(latitude, longitude) {
  
  latitude <- 42.3601
  longitude <- -71.0589
  
  request.string <- glue::glue("https://api.darksky.net/forecast/{config$darksky_key}/{latitude}/{longitude}")
  
}
