# why does setting a reactiveValues variable to itself+1 result in an infinite loop (when done without isolate)?

library(shiny)

nusers <- reactiveVal(0)

ui <- fluidPage(
  "Hello",
  textOutput("username", inline = TRUE),
  textOutput("nusers")
)

server <- function(input, output, session) {
  username <- uuid::UUIDgenerate()

  output$username <- renderText({
    username
  })

  isolate({
    message("Enter: ", username)
    nusers(nusers() + 1)
  })

  session$onSessionEnded(function() {
    isolate(nusers(nusers() - 1))
  })

  output$nusers <- renderText({
    nusers()
  })
}

shinyApp(ui, server)
