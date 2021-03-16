# Required Libraries ----

#install.packages('readxl')
library(readxl)
library(dplyr)
library(tidyr)

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

# Wrangling Data ----

?separate

bike_orderlines_joined_tbl %>%

    # Separate description into category 1, category 2 and frame material
    separate(col = description,
             into = c('category.1','category.2',
                      'frame.material'),
             sep = " - ",
             remove = FALSE) %>%


    # Separate location into city and state
    separate(location,
             into = c('city','state'),
             sep = ', ',
             remove = FALSE) %>% #glimpse()

    # price extended
    mutate(total.price = price * quantity) %>%

    # Reorganize
    select(-...1, -location) %>%
    select(-ends_with('.id')) %>%


    glimpse()

    #View()


