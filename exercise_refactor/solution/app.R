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
      tabsetPanel(
        tabPanel("Overall", textOutput("nrow")),
        tabPanel("Variable summaries", verbatimTextOutput("summary")),
        tabPanel("Data", tableOutput("view"))
      )
    )
  )
)

server <- function(input, output){

  filtered_data <- reactive({
    diamonds %>%
      filter(
        cut %in% input$selected_cut,
        color %in% input$selected_color
      )
  })

  # Report total number of observations in the data subset
  output$nrow <- renderText({
    filtered_data() %>%
      nrow() %>%
      paste0("There are ", ., " diamonds that match your selection criteria.")
  })

  # Generate a summary of the dataset ----
  output$summary <- renderPrint({
    filtered_data() %>%
      summary()
  })

  # Show the first "n" observations ----
  output$view <- renderTable({
    filtered_data() %>%
      head(n = input$obs)
  })

}

shinyApp(ui = ui, server = server)
