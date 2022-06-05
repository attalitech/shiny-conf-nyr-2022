# Load packages ----------------------------------------------------------------
library(shiny)
library(dplyr)
library(ggplot2)

ui <- fluidPage(
  titlePanel("Diamond browsing"),

  sidebarLayout(

    # Sidebar for inputs
    sidebarPanel(

      checkboxGroupInput(inputId = "selected_cut",
                         label = "Choose a cut:",
                         choices = levels(diamonds$cut),
                         selected = unique(diamonds$cut)),

      checkboxGroupInput(inputId = "selected_color",
                         label = "Choose a color:",
                         choices = levels(diamonds$color),
                         selected = unique(diamonds$color)),

      numericInput(inputId = "obs",
                   label = "Number of observations to show",
                   value = 5,
                   min = 0,
                   max = nrow(diamonds))

    ),

    # Main panel for displaying outputs
    mainPanel(

      h3("Overall"),
      HTML("nrow"),

      h3("Variable summaries"),
      verbatimTextOutput("summary"),

      h3("Data"),
      tableOutput("view")

    )
  )
)

server <- function(input, output){

  # Report total number of observations in the data subset
  output$nrow <- renderText({
    diamonds %>%
      filter(
        cut %in% input$selected_cut,
        color %in% input$selected_color
      ) %>%
      nrow() %>%
      paste0("There are ", ., " diamonds that match your selection criteria.")
  })

  # Generate a summary of the dataset ----
  output$summary <- renderPrint({
    diamonds %>%
      filter(
        cut %in% input$selected_cut,
        color %in% input$selected_color
      ) %>%
      summary()
  })

  # Show the first "n" observations ----
  output$view <- renderTable({
    diamonds %>%
      filter(
        cut %in% input$selected_cut,
        color %in% input$selected_color
      ) %>%
      head(n = input$obs)
  })

}

shinyApp(ui = ui, server = server)
