# Created: 2025-01-27
# Description: Builds the user interface

ui <- 
  
  # Make a page
  fluidPage(
    title = "Google Forms Survey Responses",
    
    # Make a sidebar layout
    sidebarLayout(
      
      # Filter panel
      sidebarPanel(
        
        # Question selector
        selectInput(
          inputId = "question",
          label = "Question",
          choices = names(initial_sheet)[-1]
        )
        
      ),
      
      # Display panel
      mainPanel(
        
        # Plot showing the selected results
        plotlyOutput(outputId = "plot"),
        
        # Table with all records
        dataTableOutput("table")
      )
    )
  )