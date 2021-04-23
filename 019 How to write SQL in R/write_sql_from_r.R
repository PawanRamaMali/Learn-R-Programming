
# LIBRARIES ----

library(DBI)
library(RSQLite)
library(tidyverse)

# 1.0 CONNECT TO SQL DB ----

con <- DBI::dbConnect(
    RSQLite::SQLite(),
    dbname = "mpg.sqlite"
)

con

DBI::dbListTables(con)

# 2.0 WRITE SQL USING R ----

manufacturer_aggregations_tblcon <- tbl(con, "MPG") %>%
    group_by(manufacturer) %>%
    summarise(
        N = n(),
        across(.cols = c(displ, cty, hwy),
               .fns  = list(mean, median), na.rm = TRUE)
    )

manufacturer_aggregations_tblcon %>% show_query()

# 3.0 RUNNING THE TRANSFORMATION ON THE DATABASE ----

manufacturer_aggregations_tblcon %>% collect()

# 4.0 GETTING SQL AS TEXT ----

manufacturer_aggregations_tblcon %>%
    show_query() %>%
    capture.output() %>%
    .[2:length(.)] %>%
    str_replace_all("`", "") %>%
    str_c(collapse = " ")


