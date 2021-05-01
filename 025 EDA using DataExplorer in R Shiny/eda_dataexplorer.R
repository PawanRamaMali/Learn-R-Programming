# DataExplorer: designed for fast exploratory data analysis

# LIBRARIES ----

library(DataExplorer)
library(tidyverse)
# DATA ----

gss_cat

gss_cat %>% glimpse()

# 1.0 EDA Report ----

gss_cat %>%
    create_report(
        output_file  = "gss_survey_data_profile_report",
        output_dir   = "/",
        y            = "rincome",
        report_title = "EDA Report - GSS Demographic Survey"
    )

# 2.0 Data Introduction ----

gss_cat %>% introduce()

gss_cat %>% plot_intro()

# 3.0 Missing Values ----

gss_cat %>% plot_missing()

gss_cat %>% profile_missing()

# 4.0 Continuous Features ----

gss_cat %>% plot_density()

gss_cat %>% plot_histogram()

# 5.0 Categorical Features ----

gss_cat %>% plot_bar()

# 6.0 Relationships ----

gss_cat %>% plot_correlation(maxcat = 15)

