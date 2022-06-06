library(shiny)
library(ggplot2)
library(dplyr)

ui <- fluidPage(
  h2("Exploration of 'diamonds'"),
  sidebarLayout(
    sidebarPanel(
      selectInput("cut", "Select a cut", diamonds$cut %>% unique() %>% sort()),
      textOutput("num_diamonds", inline = TRUE),
      "such diamonds"
    ),
    mainPanel(
      tableOutput("data_table"),
      plotOutput("carat_vs_price")
    )
  )
)

server <- function(input, output, session) {
  output$diamonds <- renderText({
    data <- diamonds %>% filter(cut == input$cut)
    nrow(data)
  })

  output$data_table <- function() {
    data <- diamonds %>% filter(cut == input$cut)
    sample_n(data, 10)
  }

  input$carat_vs_price <- renderTable({
    data <- diamonds %>% filter(cut == cut)
    plot(data$carat, data$price)
  })
}

shinyApp(ui, server)
