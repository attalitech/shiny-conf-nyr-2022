library(shiny)

ui <- fluidPage(
  numericInput("n", "Number of observations", 5),
  actionButton("recalculate", "Recalculate"),
  verbatimTextOutput("numbers")
)

server <- function(input, output, session) {
  output$numbers <- renderText({
    input$recalculate
    isolate(rnorm(input$n))
  })
}

shinyApp(ui, server)
