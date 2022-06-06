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
      plotOutput("mpg_vs_hp"),
      plotOutput("disp_vs_hp"),
      plotOutput("wt_vs_hp"),
      plotOutput("wt_vs_mpg")
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
