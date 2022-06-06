library(shiny)
library(dplyr)

ui <- fluidPage(
  h2("Silly exploration of 'mtcars'"),
  fluidRow(
    column(
      4,
      selectInput("cyl", "How many cylinders?", unique(mtcars$cyl)),
      textOutput("num_cars", inline = TRUE),
      "such cars"
    ),
    column(
      8,
      fluidRow(
        column(6, tableOutput("data_table")),
        column(6, plotOutput("mpg_vs_hp"))
      ),
      fluidRow(
        column(4, plotOutput("disp_vs_hp")),
        column(4, plotOutput("wt_vs_hp")),
        column(4, plotOutput("wt_vs_mpg"))
      )
    )
  )
)

server <- function(input, output, session) {
  data <- reactive({
    mtcars %>% filter(cyl == input$cyl)
  })

  output$num_cars <- renderText({
    nrow(data())
  })

  output$data_table <- renderTable({
    data()
  })

  output$mpg_vs_hp <- renderPlot({
    plot(data()$mpg, data()$hp)
  })

  output$disp_vs_hp <- renderPlot({
    plot(data()$disp, data()$hp)
  })

  output$wt_vs_hp <- renderPlot({
    plot(data()$wt, data()$hp)
  })

  output$wt_vs_mpg <- renderPlot({
    plot(data()$wt, data()$mpg)
  })
}

shinyApp(ui, server)
