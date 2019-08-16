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

  # tidyverse
  library(dplyr)
  library(tidyr)
  library(lubridate)
  
  # plotting
  library(ggplot2)
  library(leaflet)
  library(plotly)
  
  # reports
  library(knitr)
  library(rhandsontable)
  library(rmarkdown)
})

# Configurations
config <- config::get(file = "config.yml", config = Sys.getenv("R_CONFIG_ACTIVE", env.run))

# Options
options(stringsAsFactors = FALSE)

## =========================================
## Directories & Sourcing Files
## =========================================

# Storing Directories
dir.data <- paste0(config$dir.main, "/Data")

# # Set-Up
# source(paste0(config$dir.main, "/RCode/initialSetup.R"))
# source(paste0(config$dir.main, "/RCode/getData.R"))