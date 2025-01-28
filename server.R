# Created: 2025-01-27
# Description: Translates inputs to outputs

server <- function(input, output, session) {
  
  # Import the dataset
  survey_responses <- 
    reactive({
      
      # Import the sheet via public link
      googlesheets4::read_sheet("https://docs.google.com/spreadsheets/d/1rQR8V3xblApe03yE5yqGdqnqSR9_rj1ySf685KOow4Y")
      
    })
  
  # Make a plot
  output$plot <-
    renderPlotly({
      
      # Make the plot
      temp_plot <- 
        survey_responses() |>
        ggplot() +
        geom_bar(
          aes(
            y = .data[[input$question]]
          )
        ) +
        theme_minimal() +
        xlab("Response Count") +
        ylab(input$question)
      
      # Convert to plotly
      ggplotly(temp_plot, tooltip = "x")
      
    })
  
  # Show the data table
  output$table <- 
    renderDataTable({
      survey_responses()
    })
}