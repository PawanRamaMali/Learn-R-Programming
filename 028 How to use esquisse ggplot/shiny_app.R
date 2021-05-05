# LIBRARIES ----

library(esquisse)
library(modeldata)
library(shiny)

data("drinks")
data("mpg")

ui <- fluidPage(

    titlePanel("Use esquisse as a Shiny module"),

    sidebarLayout(
        sidebarPanel(
            radioButtons(
                inputId = "data",
                label = "Data to use:",
                choices = c("drinks", "mpg"),
                inline = TRUE
            )
        ),
        mainPanel(
            tabsetPanel(
                tabPanel(
                    title = "esquisse",
                    esquisserUI(
                        id = "esquisse",
                        header = FALSE, # dont display gadget title
                        choose_data = FALSE # dont display button to change data
                    )
                ),
                tabPanel(
                    title = "output",
                    verbatimTextOutput("module_out")
                )
            )
        )
    )
)


server <- function(input, output, session) {

    data_r <- reactiveValues(data = drinks, name = "drinks")

    observeEvent(input$data, {
        if (input$data == "drinks") {
            data_r$data <- drinks
            data_r$name <- "drinks"
        } else {
            data_r$data <- mpg
            data_r$name <- "mpg"
        }
    })

    result <- callModule(
        module = esquisse_server,
        id = "esquisse",
        data = data_r
    )

    output$module_out <- renderPrint({
        str(reactiveValuesToList(result))
    })

}

shinyApp(ui, server)
