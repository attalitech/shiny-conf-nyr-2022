# dont let users enter an empty name
# ensure users have unique names either by diallowing an existing name or by adding a unique ID
# dont let submitting an empty chat message
# clear the message after submitting it
# use enter to submit message (onevent, proxyclick from stackoverflow answer, accepted SO answer)

library(shiny)

users <- reactiveVal(c())
messages <- reactiveVal(list())

ui <- fluidPage(
  tags$head(tags$script(HTML(
    '$(document).keyup(function(event) {
    if ($("#message").is(":focus") && (event.key == "Enter")) {
        $("#send").click();
    }
});'

  ))),
  shinyjs::useShinyjs(),
  div(
    id = "intro",
    textInput("name", "Enter your username", ""),
    actionButton("enter", "Enter chat")
  ),
  shinyjs::hidden(
    div(
      id = "main_page",
      "Hello",
      textOutput("username", inline = TRUE),
      fluidRow(
        column(
          8,
          textInput("message", "Message", "", placeholder = "Type a message..."),
          actionButton("send", "Send"),
          br(), br(),
          verbatimTextOutput("chat")
        ),
        column(
          4,
          verbatimTextOutput("users")
        )
      )
    )
  )
)

server <- function(input, output, session) {
  observeEvent(input$enter, {
    if (nzchar(input$name)) {
      shinyjs::hide("intro")
      shinyjs::show("main_page")
      users(c(users(), username()))
    }
  })
  username <- reactive({
    paste0(input$name, " (", sample(1e10, 1), ")")
  })

  output$username <- renderText({
    username()
  })

  session$onSessionEnded(function() {
    isolate(users(setdiff(users(), username())))
  })

  output$users <- renderText({
    paste(users(), collapse = "\n")
  })

  observeEvent(input$send, {
    new_message <- paste0(username(), ": ", input$message)
    messages(c(messages(), new_message))
    updateTextInput(session, "message", value = "")
  })

  output$chat <- renderText({
    paste(messages(), collapse = "\n")
  })
}

shinyApp(ui, server)
