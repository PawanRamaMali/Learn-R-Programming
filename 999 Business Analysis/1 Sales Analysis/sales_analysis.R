# Required Libraries ----

#install.packages('readxl')
library(readxl)
library(dplyr)

# Read Files ----

?read_excel

bikes_tbl <- read_excel('data/bikes.xlsx')

bikeshops_tbl <- read_excel('data/bikeshops.xlsx')

orderlines_tbl <- read_excel('data/orderlines.xlsx')

# View Data ----

bikes_tbl

bikeshops_tbl

orderlines_tbl

# Join Data ----

?left_join

left_join(orderlines_tbl,
          bikes_tbl ,
          by = c('product.id' = 'bike.id'))


bike_orderlines_joined_tbl <- orderlines_tbl %>%
    left_join(bikes_tbl,
              by = c("product.id" = "bike.id")) %>%
    left_join(bikeshops_tbl,
              by = c('customer.id' = 'bikeshop.id'))


bike_orderlines_joined_tbl %>% glimpse()
