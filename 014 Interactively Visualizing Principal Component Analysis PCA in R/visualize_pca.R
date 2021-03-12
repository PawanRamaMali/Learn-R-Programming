# - PCA - Principal Component Analysis
# - Interactively Visualizing PCA 

# LIBRARIES ----

library(broom)
library(ggfortify)
library(plotly)
library(tidyverse)

# DATA ----
mpg

# DATA WRANGLING ----

# * Extract Target (Y) ----
y_tbl <- mpg %>%
    select(manufacturer, model) %>%
    mutate(vehicle = str_c(manufacturer, "_", model)) %>%
    rowid_to_column()

y_tbl

# * Encode Features (X) ----
x_tbl <- mpg %>%

    # Get features for consideration
    select(displ:class) %>%

    # Add Row ID to maintain order
    rowid_to_column() %>%

    # One Hot Encode: transmission
    mutate(
        trans_auto = str_detect(trans, "auto") %>% as.numeric(),
        trans_man  = str_detect(trans, "man") %>% as.numeric()
    ) %>%
    select(-trans) %>%

    # One Hot Encode: drv
    mutate(val_drv = 1) %>%
    pivot_wider(
        names_from  = drv,
        values_from = val_drv,
        values_fill = 0,
        names_prefix = "drv_"
    ) %>%

    # One Hot Encode: class
    mutate(val_class = 1) %>%
    pivot_wider(
        names_from  = class,
        values_from = val_class,
        values_fill = 0,
        names_prefix = "class_"
    ) %>%

    # One Hot Encode: fl
    mutate(val_fl = 1) %>%
    pivot_wider(
        names_from  = fl,
        values_from = val_fl,
        values_fill = 0,
        names_prefix = "fl_"
    )

x_tbl %>% glimpse()


# PCA  ----
# - Modeling the Principal Components

fit_pca <- prcomp(
    formula = ~ . - rowid,
    data    = x_tbl,
    scale.  = TRUE
)

fit_pca

fit_pca %>% tidy()



# VISUALIZE PCA ----

g <- autoplot(

    object = fit_pca,
    x = 1,
    y = 2,

    # Labels
    data = y_tbl,
    label = TRUE,
    label.label = "vehicle",
    label.size = 3,

    # LOADINGS
    loadings.label = TRUE,
    loadings.label.size = 7,

    scale = 0
) +
    labs(title = "Visualizing PCA in R")+
    theme_minimal()

g

plotly::ggplotly(g)

