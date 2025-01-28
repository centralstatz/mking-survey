# Created: 2025-01-27
# Description: Creates global objects for access within app

# Load packages
library(shiny)
library(DT)
library(googlesheets4)

# Sheet is public (for now); no authentication needed
gs4_deauth()