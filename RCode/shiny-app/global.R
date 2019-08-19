###############################################
##
##  DarkSky: RShiny ~ Global
## 
##  author: Ryan Johnson
##  created: Aug 2019
##  
###############################################

env.run <- "dev"

# rsconnect::setAccountInfo(name='rtjohnson12',
#                           token='956AE93A5991BF429170528B93F77417',
#                           secret='<SECRET>')
# rsconnect::deployApp("RCode/shiny-app")

## =========================================
## loading packages and environment settings
## =========================================

# Libraries
suppressPackageStartupMessages({
  # shiny
  library(shiny)
  library(shinythemes)
  library(rsconnect)
  
  # utility
  library(config)
  library(glue)
  library(scales)
  library(rvest)
  
  # tidyverse
  library(dplyr)
  library(tidyr)
  library(lubridate)
  library(stringr)
  library(tibble)
  
  # plotting
  library(ggplot2)
  library(leaflet)
  library(leaflet.extras)
  library(plotly)
  library(maps)
  library(mapproj)
  
  # reports
  library(knitr)
  library(formattable)
  library(rmarkdown)
  
  # weather / geocodes
  library(darksky)
  library(owmr)
})

# Configurations
# config <- config::get(file = "config.yml", config = Sys.getenv("R_CONFIG_ACTIVE", env.run))

# Options
options(stringsAsFactors = FALSE)

## =========================================
## City Data
## =========================================

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
) %>% tibble::add_row(
  City = "Amsterdam", State = NA, Country = "NL",
  Long = 4.97222, Lat = 52.30750
) %>% tibble::add_row(
  City = "New York City", State = "NY", Country = "US",
  Long = -74.00597, Lat = 40.71427
) %>% tibble::add_row(
  City = "New Orleans", State = "LA", Country = "US",
  Long = -90.07507, Lat = 29.95465
) %>% tibble::add_row(
  City = "Las Vegas", State = "NV", Country = "US",
  Long = -115.13722, Lat = 36.17497
)

#  %>% tibble::add_row(
#     City = "asdf", State = "asdf", Country = "asdf",
#     Long = asdf, Lat = asdf
# )

# owmr::search_city_list("Frankfurt", country_code = "DE")

## =========================================
## Directories & Sourcing Files
## =========================================

# Storing Directories
# dir.data <- paste0(config$dir.main, "/Data")

# # Set-Up
# source(paste0(config$dir.main, "/RCode/initialSetup.R"))
# source(paste0(config$dir.main, "/RCode/getData.R"))