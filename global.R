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
  function(course) {
    
    # Link to sheet based on course
    if(course == "101") {
      
      sheet <- "https://docs.google.com/spreadsheets/d/19nKF-rIylgM1-weO1mrUXUmOp7h7NxqCfShHPlW65iI"
      
    } else if(course == "370") {
      
      sheet <- "https://docs.google.com/spreadsheets/d/182-fJACcL7ryFC6SMvdci8R2WCG68dawPF4LpNVXfdg"
      
    } else if(course == "LIBA") {
      
      sheet <- "https://docs.google.com/spreadsheets/d/1Zoa4FGX71LOJIi2EhmrBfQLp2oTbAZ5tWckA8MYSitU"
      
    }
    
    googlesheets4::read_sheet(sheet)
    
  } 
    
# Call it once to gather metadata (first one in list)
initial_sheet <- load_sheet("101")
