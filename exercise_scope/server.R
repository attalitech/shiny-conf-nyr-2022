server <- function(input, output) {
  output$time_2 <- renderText({
    paste("Time 2:", Sys.time() %>% format_custom())
  })
}
