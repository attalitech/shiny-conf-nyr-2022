library(shiny)

players <- read.csv("data/nba2018.csv")

ui <- fluidPage(
  title = "NBA 2018/19 Stats",
  h1("NBA 2018/19 Player Stats"),
  h2("Exploring all player stats from the NBA 2018/19 season"),
  strong(
    "There are",
    nrow(players),
    "players in the dataset"
  )
)

server <- function(input, output, session) {

}

shinyApp(ui, server)
