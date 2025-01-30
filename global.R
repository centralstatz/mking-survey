# Created: 2025-01-27
# Description: Creates global objects for access within app

# Load packages
library(shiny)
library(DT)
library(googlesheets4)
library(plotly)
library(ggplot2)
library(bslib)
library(bsicons)
library(dplyr)
library(tidyr)
library(forcats)

# Sheet is public (for now); no authentication needed
gs4_deauth()

# Utility function to load the sheet
load_sheet <- 
  function() 
    googlesheets4::read_sheet("https://docs.google.com/spreadsheets/d/1rQR8V3xblApe03yE5yqGdqnqSR9_rj1ySf685KOow4Y")

# Call it once to gather metadata
initial_sheet <- load_sheet()
