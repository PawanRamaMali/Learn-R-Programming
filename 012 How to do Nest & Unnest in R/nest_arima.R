#  Tidyverse Features: Nest & Unnest ----
# - map()
# - modeltime + ARIMA


# LIBRARIES ----
library(modeltime)
library(tidymodels)
library(timetk)
library(tidyverse)

# DATA ----
# - Time Series Visualization - 

walmart_sales_weekly

walmart_sales_weekly %>%
    group_by(id) %>%
    plot_time_series(Date, Weekly_Sales, .facet_ncol = 2)

# 1.0 NESTING 101 ----

# Nesting
data_nested <- walmart_sales_weekly %>%
    select(id, Date, Weekly_Sales) %>%
    nest(nested_column = -id)

data_nested$nested_column

# Unnesting
data_nested %>%
    unnest(nested_column)

# 2.0 MULTIPLE ARIMA FORECASTS ----
# - Modeltime (ARIMA) 

# * Making Multiple ARIMA Models ----
model_table <- data_nested %>%

    # Map Fitted Models
    mutate(fitted_model = map(nested_column, .f = function(df) {

        arima_reg(seasonal_period = 52) %>%
            set_engine("auto_arima") %>%
            fit(Weekly_Sales ~ Date, data = df)

    })) %>%

    # Map Forecasts
    mutate(nested_forecast = map2(fitted_model, nested_column,
                                  .f = function(arima_model, df) {

        modeltime_table(
            arima_model
        ) %>%
            modeltime_forecast(
                h = 52,
                actual_data = df
            )
    }))

model_table

# * Unnest ----

model_table %>%
    select(id, nested_forecast) %>%
    unnest(nested_forecast) %>%
    group_by(id) %>%
    plot_modeltime_forecast(.facet_ncol = 2)
