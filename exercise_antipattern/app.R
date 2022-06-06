library(shiny)

ui <- fluidPage(
  numericInput("n", "Number of observations", 5),
  actionButton("recalculate", "Recalculate"),
  verbatimTextOutput("numbers")
)

server <- function(input, output, session) {
  observeEvent(input$recalculate, {
    output$numbers <- renderText({
      rnorm(input$n)
    })
  })
}

shinyApp(ui, server)
