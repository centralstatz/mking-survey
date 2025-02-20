# Created: 2025-01-27
# Description: Builds the user interface

ui <- 
  
  # Make a page
  page_sidebar(
    theme = bs_theme(bootswatch = "sandstone"),
    title = "Class Surveys",
    
    # Add tag to remove padding from time plot
    tags$head(
      tags$style(HTML("
      div.nopad .value-box-area {
        padding: 0;
      }
    "))
    ),
    
    # Make a sidebar
    sidebar = 
      sidebar(
        
        # Course selector
        selectInput(
          inputId = "course",
          label = "Course",
          choices = 
            c(
              "101",
              "370",
              "LIBA"
            )
        ),
        
        # Question selector
        selectInput(
          inputId = "question",
          label = "Question",
          choices = names(initial_sheet)[-1]
        ),
        
        # Response range
        dateRangeInput(
          inputId = "response_range",
          label = "Response Date Range",
          start = Sys.Date() - 90,
          end = Sys.Date()
        ),
        
        # Button to refresh the data
        actionButton(
          inputId = "refresh",
          label = "Refresh"
        )
        
      ),
    
    ## Main output
    
    # Cards displaying overall metrics
    layout_columns(
      max_height = "250px",
      
      # Completed forms
      value_box(
        title = "Total Respondents",
        value = textOutput("completed_forms"),
        showcase = bs_icon("ui-checks"),
        theme = "blue"
      ),
      
      # Graph form completion times
      value_box(
        title = "Completion Times",
        value = plotlyOutput(outputId = "completion_time"),
        class = "p-0 nopad",
        full_screen = TRUE
      )
    ),
    
    # Bar plot showing results
    card(
      card_header("Response Distribution"),
      card_body(
        plotlyOutput(outputId = "response_distribution")
      ),
      full_screen = TRUE
    ),
    
    # Table showing the full response set in tabular form
    accordion(
      open = FALSE,
      accordion_panel(
        title = "Tabular Data",
        dataTableOutput("response_table")
      )
    )
  )