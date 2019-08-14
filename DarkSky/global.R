###############################################
##
##  DarkSky: RShiny ~ Global
## 
##  author: Ryan Johnson
##  created: Aug 2019
##  
###############################################

env.run <- "dev"

## =========================================
## loading packages and environment settings
## =========================================

# Libraries
suppressPackageStartupMessages({
  # shiny
  library(shiny)
  library(shinydashboard)
  
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
config <- config::get(file = "//Analystfs/WestCoastData/Projects/KeyPerformanceIndicators/config.yml", 
                      config = Sys.getenv("R_CONFIG_ACTIVE", env.run))


# Options
options(stringsAsFactors = FALSE)

# Connect to DB's
np_conn <- NULL
slice_conn <- NULL

## =========================================
## Directories & Sourcing Files
## =========================================

# Reference Directories
dir.fimo  <- paste0(config$server.loc, "/WC Risk/Results")
dir.slice <- paste0(config$server.loc, "/Projects/Slice")
dir.st_slice <- paste0(dir.slice, "/ShortTerm/Data - Copy")
dir.lt_slice <- paste0(dir.slice, "/LongTerm/Data")
dir.lt_slice_fcast <- paste0(config$server.loc, "/KPI Automation/Slice Generation Data")

# Storing Directories
dir.data <- paste0(config$server.loc, "/KeyPerformanceIndicators/Data")
dir.store.fm <- paste0(dir.data, "/FinancialModel")
dir.store.op <- paste0(dir.data, "/OpenPositions")
dir.store.rp <- paste0(dir.data, "/RealizedPositions")
dir.store.sl <- paste0(dir.data, "/Slice")

# Set-Up
source(paste0(config$dir.main, "/RCode/initialSetup.R"))
source(paste0(config$dir.main, "/RCode/getData.R"))