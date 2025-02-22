# Created: 2025-01-27
# Description: Translates inputs to outputs

server <- 
  function(input, output, session) {
    
    # Import the dataset
    load_responses <- 
      eventReactive(
        list(input$refresh, input$course),
        {
          
          # Import the sheet
          sheet <- load_sheet(input$course)
          
          # Update the question list
          updateSelectInput(
            session = session,
            inputId = "question",
            choices = names(sheet)[-1]
          )
          
          # Return the sheet
          sheet
          
        },
        ignoreNULL = FALSE
      )
    
    # Filter the dataset
    survey_responses <-
      reactive({
        
        load_responses() |>
          
          # Filter to date range
          filter(
            as.Date(Timestamp) >= min(input$response_range),
            as.Date(Timestamp) <= max(input$response_range)
          )
        
      })
    
    # Display the number of respondents
    output$completed_forms <- renderText({nrow(survey_responses())})
    
    # Display the response accumulation
    output$completion_time <-
      renderPlotly({
        
        # Check for data
        validate(need(nrow(survey_responses()) > 0, "No responses"))
        
        survey_responses() |>
          
          # Sort by response time
          arrange(Timestamp) |>
          
          # Compute the cumulative sum
          mutate(
            Total = 1,
            Total = cumsum(Total)
          ) |>
          
          # Make a plot
          plot_ly(
            x = ~Timestamp,
            y = ~Total,
            type = "scatter",
            mode = "lines+markers",
            hovertemplate = 
              ~paste0(
                "Time: ", Timestamp,
                "<br>Respondents: ", Total
              )
          ) |>
          layout(
            xaxis = list(title = "Response Time"),
            yaxis = list(title = "Responses")
          )
        
      })
    # Get distribution of selected question
    current_response_distribution <-
      reactive({
        
        # Check for data
        validate(need(nrow(survey_responses()) > 0, "No responses"))
        
        survey_responses() |>
          
          # Send chosen question down the rows
          pivot_longer(
            cols = all_of(input$question),
            names_to = "Question",
            values_to = "Response"
          ) |>
          
          # Fill in NULL values
          mutate(Response = coalesce(Response, "No Response")) |>
          
          # Compute counts
          summarize(
            N = n(),
            .by = Response
          ) |>
          
          # Compute rates; reorder as factor
          mutate(
            Rate = N / sum(N),
            Response = fct_rev(Response)
          )
        
      })
    
    # Make a plot
    output$response_distribution <-
      renderPlotly({
        
        # Make the plot
        temp_plot <- 
          current_response_distribution() |>
          ggplot(
            aes(
              text = 
                paste0(
                  "Response: ", Response,
                  "<br>Respondents: ", N,
                  "<br>Percent (%): ", round(Rate * 100, 2), "%"
                )
            )
          ) +
          geom_col(
            aes(
              x = Response,
              y = N
            ),
            color = "black",
            fill = "#4a86cf",
            width = .5,
            alpha = .5
          ) +
          coord_flip() +
          theme_minimal() +
          xlab("Choice") +
          ylab("Respondents") +
          scale_x_discrete(drop = FALSE) +
          labs(title = input$question)
        
        # Convert to plotly
        ggplotly(temp_plot, tooltip = "text")
        
      })
    
    # Show the data table
    output$response_table <- 
      renderDataTable({
        survey_responses()
      })
  }