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
    googlesheets4::read_sheet("https://docs.google.com/spreadsheets/d/182-fJACcL7ryFC6SMvdci8R2WCG68dawPF4LpNVXfdg")

# Call it once to gather metadata
initial_sheet <- load_sheet()
