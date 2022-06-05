# library(shiny)
#
# ui <- fluidPage(
#   numericInput("mean", "Mean", 0),
#   numericInput("sd", "SD", 1),
#   sliderInput("nobs", "n", min = 100, max = 10000, value = 1000, ticks = FALSE),
#   plotOutput("plot")
# )
#
# server <- function(input, output, session) {
#   df <- reactive(data.frame(
#     values = rnorm(input$nobs, input$mean, input$sd)
#   ))
#   output$plot <- renderPlot({
#     data <- tidyr::pivot_longer(df(), cols = everything())
#     ggplot(data) +
#       geom_density(aes(x = value, fill = name, col = name), alpha = 0.3)
#   })
# }
#
# shinyApp(ui, server)

# library(shiny)
#
# params_ui <- function(id, num) {
#   ns <- NS(id)
#   tagList(
#     fluidRow(
#       column(
#         6,
#         h3("Parameters", num),
#         numericInput(ns("mean"), "Mean", 0),
#         numericInput(ns("sd"), "SD", 1),
#         sliderInput(ns("nobs"), "n", min = 10, max = 50000, value = 1000, ticks = FALSE)
#       ),
#       column(
#         6,
#         plotOutput(ns("plot"), height = 200)
#       )
#     ),
#     tags$hr()
#   )
# }
#
# params_server <- function(id) {
#   moduleServer(id, function(input, output, session) {
#     df <- reactive({
#       data.frame(
#         values = rnorm(input$nobs, input$mean, input$sd)
#       )
#     })
#
#     output$plot <- renderPlot({
#       ggplot(df()) +
#         geom_density(aes(x = values))
#     })
#
#     return(df)
#   })
# }
#
# ui <- fluidPage(
#   params_ui("set1", 1),
#   params_ui("set2", 2),
#   params_ui("set3", 3),
#   plotOutput("plot")
# )
#
# server <- function(input, output, session) {
#   set1 <- params_server("set1")
#   set2 <- params_server("set2")
#   set3 <- params_server("set3")
#
#   df <- reactive({
#     data.frame(
#       value = c(set1()$values, set2()$values, set3()$values),
#       name = c(rep("1", nrow(set1())), rep("2", nrow(set2())), rep("3", nrow(set3())))
#     )
#   })
#
#   output$plot <- renderPlot({
#     ggplot(df()) +
#       geom_density(aes(x = value, fill = name, col = name), alpha = 0.3)
#   })
# }
#
# shinyApp(ui, server)

# library(shiny)
# library(ggplot2)
#
# NUM_SETS <- 8
#
# params_ui <- function(id, num) {
#   ns <- NS(id)
#   tagList(
#     fluidRow(
#       column(
#         6,
#         h3("Parameters", num),
#         numericInput(ns("mean"), "Mean", 0),
#         numericInput(ns("sd"), "SD", 1),
#         sliderInput(ns("nobs"), "n", min = 10, max = 50000, value = 1000, ticks = FALSE)
#       ),
#       column(
#         6,
#         plotOutput(ns("plot"), height = 200)
#       )
#     ),
#     tags$hr()
#   )
# }
#
# params_server <- function(id) {
#   moduleServer(id, function(input, output, session) {
#     df <- reactive({
#       data.frame(
#         values = rnorm(input$nobs, input$mean, input$sd)
#       )
#     })
#
#     output$plot <- renderPlot({
#       ggplot(df()) +
#         geom_density(aes(x = values))
#     })
#
#     return(df)
#   })
# }
#
# ui <- fluidPage(
#   lapply(seq(NUM_SETS), function(x) params_ui(paste0("set", x), x)),
#   plotOutput("plot")
# )
#
# server <- function(input, output, session) {
#   sets <- lapply(seq(NUM_SETS), function(x) params_server(paste0("set", x)))
#
#   df <- reactive({
#     data.frame(
#       value = unlist(lapply(seq(NUM_SETS), function(x) sets[[x]]()$values)),
#       name = unlist(lapply(seq(NUM_SETS), function(x) rep(as.character(x), nrow(sets[[x]]()))))
#     )
#   })
#
#   output$plot <- renderPlot({
#     ggplot(df()) +
#       geom_density(aes(x = value, fill = name, col = name), alpha = 0.3)
#   })
# }
#
# shinyApp(ui, server)



# library(shiny)
# library(ggplot2)
#
# NUM_SETS <- 8
#
# params_ui <- function(id, num) {
#   ns <- NS(id)
#   tagList(
#     fluidRow(
#       column(
#         6,
#         h3("Parameters", num),
#         numericInput(ns("mean"), "Mean", 0),
#         numericInput(ns("sd"), "SD", 1),
#         sliderInput(ns("nobs"), "n", min = 10, max = 50000, value = 1000, ticks = FALSE)
#       ),
#       column(
#         6,
#         plotOutput(ns("plot"), height = 200)
#       )
#     ),
#     tags$hr()
#   )
# }
#
# params_server <- function(id) {
#   moduleServer(id, function(input, output, session) {
#     df <- reactive({
#       data.frame(
#         values = rnorm(input$nobs, input$mean, input$sd)
#       )
#     })
#
#     output$plot <- renderPlot({
#       ggplot(df()) +
#         geom_density(aes(x = values))
#     })
#
#     return(df)
#   })
# }
#
# ui <- fluidPage(
#   lapply(seq(NUM_SETS), function(x) params_ui(paste0("set", x), x)),
#   plotOutput("plot")
# )
#
# server <- function(input, output, session) {
#   sets <- lapply(seq(NUM_SETS), function(x) params_server(paste0("set", x)))
#
#   df <- reactive({
#     data.frame(
#       value = unlist(lapply(seq(NUM_SETS), function(x) sets[[x]]()$values)),
#       name = unlist(lapply(seq(NUM_SETS), function(x) rep(as.character(x), nrow(sets[[x]]()))))
#     )
#   })
#
#   output$plot <- renderPlot({
#     ggplot(df()) +
#       geom_density(aes(x = value, fill = name, col = name), alpha = 0.3)
#   })
# }
#
# shinyApp(ui, server)

# library(shiny)
# library(ggplot2)
#
# NUM_SETS <- 8
#
# params_ui <- function(id, num) {
#   ns <- NS(id)
#   tagList(
#     fluidRow(
#       column(
#         6,
#         h3("Parameters", num),
#         numericInput(ns("mean"), "Mean", 0),
#         numericInput(ns("sd"), "SD", 1),
#         sliderInput(ns("nobs"), "n", min = 10, max = 50000, value = 1000, ticks = FALSE)
#       ),
#       column(
#         6,
#         plotOutput(ns("plot"), height = 200)
#       )
#     ),
#     tags$hr()
#   )
# }
#
# params_server <- function(id) {
#   moduleServer(id, function(input, output, session) {
#     df <- reactive({
#       data.frame(
#         values = rnorm(input$nobs, input$mean, input$sd)
#       )
#     })
#
#     output$plot <- renderPlot({
#       ggplot(df()) +
#         geom_density(aes(x = values))
#     })
#
#     return(df)
#   })
# }
#
# ui <- fluidPage(
#   plotOutput("plot"),
#   tabsetPanel(
#     !!!lapply(seq(NUM_SETS), function(x) tabPanel(paste0("set", x), params_ui(paste0("set", x), x)))
#   )
# )
#
# server <- function(input, output, session) {
#   sets <- lapply(seq(NUM_SETS), function(x) params_server(paste0("set", x)))
#
#   df <- reactive({
#     data.frame(
#       value = unlist(lapply(seq(NUM_SETS), function(x) sets[[x]]()$values)),
#       name = unlist(lapply(seq(NUM_SETS), function(x) rep(as.character(x), nrow(sets[[x]]()))))
#     )
#   })
#
#   output$plot <- renderPlot({
#     ggplot(df()) +
#       geom_density(aes(x = value, fill = name, col = name), alpha = 0.3)
#   })
# }
#
# shinyApp(ui, server)


# library(shiny)
# library(ggplot2)
#
# NUM_SETS <- 3
#
# params_ui <- function(id, num) {
#   ns <- NS(id)
#   tagList(
#     fluidRow(
#       column(
#         6,
#         h3("Parameters", num),
#         numericInput(ns("mean"), "Mean", 0),
#         numericInput(ns("sd"), "SD", 1),
#         sliderInput(ns("nobs"), "n", min = 10, max = 50000, value = 1000, ticks = FALSE)
#       ),
#       column(
#         6,
#         plotOutput(ns("plot"), height = 200)
#       )
#     ),
#     tags$hr()
#   )
# }
#
# params_server <- function(id) {
#   moduleServer(id, function(input, output, session) {
#     df <- reactive({
#       req(input$nobs)
#       data.frame(
#         values = rnorm(input$nobs, input$mean, input$sd)
#       )
#     })
#
#     output$plot <- renderPlot({
#       ggplot(df()) +
#         geom_density(aes(x = values))
#     })
#
#     return(df)
#   })
# }
#
# ui <- fluidPage(
#   plotOutput("plot"),
#   actionButton("add", "Add"),
#   tabsetPanel(
#     id = "sets",
#     !!!lapply(seq(NUM_SETS), function(x) tabPanel(paste0("set", x), params_ui(paste0("set", x), x)))
#   )
# )
#
# server <- function(input, output, session) {
#   num_sets <- reactive({
#     input$add + NUM_SETS
#   })
#   sets <- reactive({
#     lapply(seq(num_sets()), function(x) params_server(paste0("set", x)))
#   })
#
#   observeEvent(num_sets(), ignoreInit = TRUE, {
#     insertTab("sets",
#               tabPanel(paste0("set", num_sets()), params_ui(paste0("set", num_sets()), num_sets())))
#   })
#
#   df <- reactive({
#     req()
#     message(num_sets())
#     data.frame(
#       value = unlist(lapply(seq(num_sets()), function(x) sets()[[x]]()$values)),
#       name = unlist(lapply(seq(num_sets()), function(x) rep(as.character(x), nrow(sets()[[x]]()))))
#     )
#   })
#
#   output$plot <- renderPlot({
#     ggplot(df()) +
#       geom_density(aes(x = value, fill = name, col = name), alpha = 0.3)
#   })
# }
#
# shinyApp(ui, server)

library(shiny)
library(ggplot2)

NUM_SETS <- 3

params_ui <- function(id, num) {
  ns <- NS(id)
  tagList(
    fluidRow(
      column(
        6,
        h3("Parameters", num),
        numericInput(ns("mean"), "Mean", 0),
        numericInput(ns("sd"), "SD", 1),
        sliderInput(ns("nobs"), "n", min = 10, max = 50000, value = 1000, ticks = FALSE)
      ),
      column(
        6,
        plotOutput(ns("plot"), height = 200)
      )
    ),
    tags$hr()
  )
}

params_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    df <- reactive({
      req(input$nobs)
      data.frame(
        values = rnorm(input$nobs, input$mean, input$sd)
      )
    })

    output$plot <- renderPlot({
      ggplot(df()) +
        geom_density(aes(x = values))
    })

    return(list(df = df, remove = reactive(input$remove)))
  })
}

ui <- fluidPage(
  plotOutput("plot"),
  actionButton("add", "Add", icon("plus")), br(), br(),
  radioButtons("choose_to_remove", NULL, choices = c(""), inline = TRUE),
  actionButton("remove", "Remove", icon("trash")), br(),
  tabsetPanel(
    id = "sets",
    !!!lapply(seq(NUM_SETS), function(x) tabPanel(paste0("set", x), params_ui(paste0("set", x), x)))
  )
)

server <- function(input, output, session) {
  set_numbers <- reactiveVal(as.character(seq(NUM_SETS)))

  observeEvent(input$add, {
    new_num <- max(as.numeric(set_numbers())) + 1
    set_numbers(c(set_numbers(), new_num))

    insertTab(
      "sets",
      tabPanel(paste0("set", new_num), params_ui(paste0("set", new_num), new_num))
    )

    sets[[as.character(new_num)]] <<- params_server(paste0("set", new_num))
  })

  sets <- sapply(as.character(seq(NUM_SETS)), USE.NAMES = TRUE, simplify = FALSE, function(x) params_server(paste0("set", x)))

  observeEvent(set_numbers(), {
    updateRadioButtons(session, "choose_to_remove", choices = set_numbers(), inline = TRUE)
  })

  observeEvent(input$remove, {
    removeTab("sets", paste0("set", input$choose_to_remove))
    set_numbers(setdiff(set_numbers(), input$choose_to_remove))
  })

  df <- reactive({
    data.frame(
      value = unlist(lapply(set_numbers(), function(x) (sets[[x]]$df)()$values)),
      name = unlist(lapply(set_numbers(), function(x) rep(as.character(x), nrow((sets[[x]]$df)()))))
    )
  })

  output$plot <- renderPlot({
    ggplot(df()) +
      geom_density(aes(x = value, fill = name, col = name), alpha = 0.3)
  })
}

shinyApp(ui, server)


