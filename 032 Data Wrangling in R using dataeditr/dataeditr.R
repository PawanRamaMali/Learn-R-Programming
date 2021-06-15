#  DataEditR: GUI for Data Wrangling in R ----

# LIBRARIES ----

library(DataEditR)
library(tidyverse)
library(tidyquant)

# DATA ----
mpg


# 1.0 DATA EDITING ----

# 1.1 data_edit() ----

mpg_subset <- data_edit(
    x = mpg
)

# 1.2 RStudio Add-In ----

# Addins > Interactive Data Editor

mpg %>%

    select(manufacturer, model, cty, hwy, class) %>%
    pivot_longer(cols = c(cty, hwy)) %>%
    mutate(
        model = fct_reorder(
            str_glue("{manufacturer} {model}") %>% str_to_title(),
            value
        ),
        name = str_to_upper(name)
    ) %>%

    ggplot(aes(x = model, y = value, fill = class)) +
    geom_boxplot() +
    facet_grid(cols = vars(name), scales = "free_y") +
    coord_flip() +
    scale_fill_tq() +
    theme_tq() +
    labs(title = "Fuel Economy by Model", y = "MPG", x = "")


