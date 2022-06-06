library(shiny)

ui <- fluidPage(
  actionButton("btn", "btn"),
  numericInput("num", "num", 5)
)

server <- function(input, output, session) {
  x <- reactiveVal(0)

  observe({
    newval <- input$num * 2   # A
    x(newval)                 # B
  })

  observe({
    input$btn                 # C
    val <- x()                # D
    print(val)
  })
}

shinyApp(ui, server)
