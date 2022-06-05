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
  # This list holds all the previous values
  prior <- reactiveValues(
    xvar = "",
    yvar = ""
  )

  # This will contain the current plot
  plotObject <- reactiveVal()

  # Main workhorse - when any inputs change, determine how to update the plot
  observe({
    replotAxesFlag <- FALSE
    if (prior$xvar != input$xvar) {
      prior$xvar <- input$xvar
      replotAxesFlag <- TRUE
    }
    if (prior$yvar != input$yvar) {
      prior$yvar <- input$yvar
      replotAxesFlag <- TRUE
    }

    if (replotAxesFlag) {
      newPlot <- makePlot(prior$xvar, prior$yvar)
      plotObject(newPlot)
    }
  })

  output$plot <- renderPlot({
    plotObject()
  })
}

shinyApp(ui, server)
