library(shiny)

players <- read.csv("data/nba2018.csv")

ui <- fluidPage(
  "NBA 2018/19 Player Stats",
  "Exploring all player stats from the NBA 2018/19 season"
  "There are",
  nrow(players),
  "players in the dataset"
)

server <- function(input, output, session) {

}

shinyApp(ui, server)
