# Created: 2025-01-27
# Description: Builds the user interface

ui <- 
  
  # Make a page
  fluidPage(
    title = "Google Forms Survey Responses",
    
    # Make some outputs
    fluidRow(
      column(
        width = 12,
        dataTableOutput('table')
      )
    )
  )