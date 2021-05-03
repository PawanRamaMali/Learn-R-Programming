# LIBRARIES ----

# Shiny
library(shiny)
library(bslib)

# Modeling
library(modeldata)
library(DataExplorer)

# Widgets
library(plotly)

# Core
library(tidyverse)


# LOAD DATASETS ----
utils::data("stackoverflow", "car_prices", "Sacramento", package = "modeldata")

data_list = list(
    "StackOverflow" = stackoverflow,
    "Car Prices"    = car_prices,
    "Sacramento Housing" = Sacramento
)

# 1.0 USER INTERFACE ----
ui <- navbarPage(

    title = "Data Explorer",

    theme = bslib::bs_theme(version = 4, bootswatch = "minty"),

    tabPanel(
        title = "Explore",

        sidebarLayout(

            sidebarPanel(
                width = 3,
                h1("Explore a Dataset"),

              
                shiny::selectInput(
                    inputId = "dataset_choice",
                    label   = "Data Connection",
                    choices = c("StackOverflow", "Car Prices", "Sacramento Housing")
                ),

             
                hr(),

                p("Learn Shiny Today!") %>%
                    a(
                        href = 'https://github.com/PawanRamaMali/',
                        target = "_blank",
                        class = "btn btn-lg btn-primary"
                    ) %>%
                    div(class = "text-center")


            ),

            mainPanel(
                h1("Correlation"),
                plotlyOutput("corrplot", height = 700)
            )
        )

    )


)

# 2.0 SERVER ----
server <- function(input, output) {

    # REACTIVE PROGRAMMING  ----
   
    rv <- reactiveValues()

    observe({

        rv$data_set <- data_list %>% pluck(input$dataset_choice)

    })

    output$corrplot <- renderPlotly({

        g <- DataExplorer::plot_correlation(rv$data_set)

        plotly::ggplotly(g)
    })

}

# Run the application
shinyApp(ui = ui, server = server)
