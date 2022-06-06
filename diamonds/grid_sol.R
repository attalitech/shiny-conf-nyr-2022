library(shiny)
library(ggplot2)
library(dplyr)

ui <- fluidPage(
  h2("Exploration of 'diamonds'"),
  fluidRow(
    column(
      4,
      selectInput("cut", "Select a cut", diamonds$cut %>% unique() %>% sort()),
      textOutput("num_diamonds", inline = TRUE),
      "such diamonds"
    ),
    column(
      8,
      fluidRow(
        column(6, tableOutput("data_table")),
        column(6, plotOutput("carat_vs_price"))
      ),
      fluidRow(
        column(4, plotOutput("carat_vs_x")),
        column(4, plotOutput("carat_vs_y")),
        column(4, plotOutput("carat_vs_z"))
      )
    )
  )
)

server <- function(input, output, session) {
  data <- reactive({
    diamonds %>% filter(cut == input$cut)
  })

  output$num_diamonds <- renderText({
    nrow(data())
  })

  output$data_table <- renderTable({
    sample_n(data(), 10)
  })

  output$carat_vs_price <- renderPlot({
    ggplot(data(), aes(carat, price)) + geom_point()
  })

  output$carat_vs_x <- renderPlot({
    ggplot(data(), aes(carat, x)) + geom_point()
  })

  output$carat_vs_y <- renderPlot({
    ggplot(data(), aes(carat, y)) + geom_point()
  })

  output$carat_vs_z <- renderPlot({
    ggplot(data(), aes(carat, z)) + geom_point()
  })
}

shinyApp(ui, server)
