# Created: 2025-01-27
# Description: Translates inputs to outputs

server <- function(input, output, session) {
  
  # Import the dataset
  survey_responses <- 
    reactive({
      #invalidateLater(1000)
      googlesheets4::read_sheet("https://docs.google.com/spreadsheets/d/1rQR8V3xblApe03yE5yqGdqnqSR9_rj1ySf685KOow4Y")
    })
  
  # Show the data table
  output$table <- 
    renderDataTable({
      survey_responses()
    })
}