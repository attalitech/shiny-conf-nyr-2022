library(shiny)
library(ggplot2)

makePlot <- function(xvar, yvar) {
  ggplot(iris, aes_string(xvar, yvar)) + geom_point()
}

ui <- fluidPage(
  selectInput("xvar", "X variable", choices = names(iris), selected = names(iris)[1]),
  selectInput("yvar", "Y variable", choices = names(iris), selected = names(iris)[2]),
  plotOutput("plot")
)

server <- function(input, output, session) {
  plotObject <- reactive({
    makePlot(input$xvar, input$yvar)
  })

  output$plot <- renderPlot({
    plotObject()
  })
}

shinyApp(ui, server)
