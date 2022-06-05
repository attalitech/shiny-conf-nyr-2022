library(shiny)
library(magrittr)

time_1 <- Sys.time() %>% format_custom()
Sys.sleep(1)

ui <- fluidPage(
  h4(paste("Time 1:", time_1)),
  h4(textOutput("time_2")),
  h4(paste("Time 3:", Sys.time() %>% format_custom())),
  h4(paste("Time 4:", time_4))
)
