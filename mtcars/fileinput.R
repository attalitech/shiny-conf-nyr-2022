library(shiny)
library(ggplot2)
library(dplyr)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      uiOutput("vars_chooser")
    ),
    mainPanel(
      plotOutput("plot"),
      verbatimTextOutput("summary")
    )
  )
)

server <- function(input, output, session) {
  subset_data <- reactive({
    mtcars[, c(input$xvar, input$yvar)]
  })

  output$vars_chooser <- renderUI({
    col_names <- names(mtcars)
    tagList(
      selectInput("xvar", "X variable", col_names),
      selectInput("yvar", "Y variable", col_names, selected = col_names[[2]])
    )
  })

  output$plot <- renderPlot({
    ggplot(subset_data(), aes_string(x = input$xvar, y = input$yvar)) +
      geom_point()
  })

  output$summary <- renderPrint({
    summary(subset_data())
  })
}

shinyApp(ui, server)
