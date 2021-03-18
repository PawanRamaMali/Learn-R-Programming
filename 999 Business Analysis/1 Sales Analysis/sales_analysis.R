# Required Libraries ----

#install.packages('readxl')
library(readxl)
library(dplyr)
library(tidyr)

library(tidyquant)
library(ggplot2)

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

bike_orderlines_wrangled_tbl <- bike_orderlines_joined_tbl %>%

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

    # * Reorganize ----
    select(-...1, -location, -description) %>%
    select(-ends_with('.id')) %>%

    bind_cols(bike_orderlines_joined_tbl %>%
                  select(order.id)) %>%

    # * Reorder columns ----
    select(contains('date'),
           contains('id'),
           contains('order'),
           quantity,
           price,
           total.price,
           everything()) %>%

    # * Rename columns ----
    rename( order_date = order.date) %>%
    rlang::set_names(names(.) %>%
                         stringr::str_replace_all("\\.", "_")) %>%

    glimpse()

    #View()

bike_orderlines_wrangled_tbl %>% glimpse()


# Business Insights ----


#*  Manipulate ----

sales_by_year_tbl <- bike_orderlines_wrangled_tbl %>%

    # Selecting columns to focus on and adding a year column
    select(order_date, total_price) %>%
    mutate(year = year(order_date)) %>%

    # Grouping by year and summarizing sales
    group_by(year) %>%
    summarize(sales = sum(total_price)) %>%
    ungroup() %>%

    # $ Format Text
    mutate(sales_text = scales::dollar(sales))


sales_by_year_tbl

#* Visualize

sales_by_year_tbl %>%

    # Setup canvas with year (x-axis) and sales (y-axis)
    ggplot(aes(x = year, y = sales)) +

    # Geometries
    geom_col(fill = "cornflowerblue")+
    geom_label(aes(label = sales_text))+
    geom_smooth(method = "lm", se = FALSE) +

   # palette_light() #A6CEE3

    # Formatting
    theme_tq() +
        scale_y_continuous(labels = scales::dollar)+
        labs(
            title = "Revenue by year",
            subtitle = "Upward Trend",
            x = "",
            y = "Revenue"
        )


# Sales by Year and Category 2 ----

#*  Manipulate ----

sales_by_year_cat_2_tbl <- bike_orderlines_wrangled_tbl %>%

    #Selecting columns and add a year
    select(order_date, total_price,category_2) %>%
    mutate(year = year(order_date)) %>%

    #Groupby and Summarize year and category 2
    group_by(year, category_2) %>%
    summarise(sales = sum(total_price)) %>%
    ungroup() %>%

    # Format $ Text
    mutate(sales_text = scales::dollar(sales))


sales_by_year_cat_2_tbl

#* Visualize ----

sales_by_year_cat_2_tbl %>%

    # Setup x, y,fill
    ggplot(aes(x= year,y=sales, fill= category_2))+

    # Geometries
    geom_col()+
    geom_smooth(method = "lm",se = FALSE)+

    # Facet
    facet_wrap(~ category_2, ncol = 3,scales = "free_y" )+

    # Formatting
    theme_tq()+
    scale_fill_tq()+
    scale_y_continuous(labels = scales::dollar)+
    labs(
        title = "Revenue by Year and Category 2",
        subtitle = "Each product category has an upward trend",
        x = "",
        y = "Revenue",
        fill = "Product Secondary  Category"
        )






















