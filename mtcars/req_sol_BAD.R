library(shiny)
library(ggplot2)
library(dplyr)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      checkboxInput("custom", "Choose my own file", value = FALSE),
      conditionalPanel(
        "input.custom",
        fileInput("file", "Choose a file")
      ),
      uiOutput("vars_chooser")
    ),
    mainPanel(
      plotOutput("plot"),
      verbatimTextOutput("summary")
    )
  )
)

server <- function(input, output, session) {
  full_data <- reactive({
    if (input$custom) {
      if (is.null(input$file)) return()
      read.csv(input$file$datapath)
    } else {
      mtcars
    }
  })

  subset_data <- reactive({
    if (is.null(full_data())) return()
    full_data()[, c(input$xvar, input$yvar)]
  })

  output$vars_chooser <- renderUI({
    if (is.null(full_data())) return()
    col_names <- names(full_data())
    tagList(
      selectInput("xvar", "X variable", col_names),
      selectInput("yvar", "Y variable", col_names, selected = col_names[[2]])
    )
  })

  output$plot <- renderPlot({
    if (is.null(subset_data())) return()
    ggplot(subset_data(), aes_string(x = input$xvar, y = input$yvar)) +
      geom_point()
  })

  output$summary <- renderPrint({
    if (is.null(subset_data())) return(invisible())
    summary(subset_data())
  })
}

shinyApp(ui, server)
