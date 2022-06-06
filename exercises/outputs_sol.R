library(shiny)
library(dplyr)

ui <- fluidPage(
  h2("Silly exploration of 'mtcars'"),
  sidebarLayout(
    sidebarPanel(
      selectInput("cyl", "How many cylinders?", unique(mtcars$cyl)),
      textOutput("num_cars", inline = TRUE),
      "such cars"
    ),
    mainPanel(
      tableOutput("data_table"),
      plotOutput("mpg_vs_hp")
    )
  )
)

server <- function(input, output, session) {
  output$num_cars <- renderText({
    data <- mtcars %>% filter(cyl == input$cyl)
    nrow(data)
  })

  output$data_table <- renderTable({
    mtcars %>% filter(cyl == input$cyl)
  })

  output$mpg_vs_hp <- renderPlot({
    data <- mtcars %>% filter(cyl == input$cyl)
    plot(data$mpg, data$hp)
  })
}

shinyApp(ui, server)
