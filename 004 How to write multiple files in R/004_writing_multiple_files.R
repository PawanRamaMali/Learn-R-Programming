
#  Writing Multiple CSV Files with Map ----

# 1.0 LIBRARIES ----

library(tidyverse)
library(fs)

# 2.0 READING MULTIPLE CSV ----

directory_that_holds_files <- "E:\\Code\\2021\\Learn-R-Programming\\004 How to write multiple files in R\\car_data"

car_data_list <- directory_that_holds_files %>%
    dir_ls() %>%
    map(
        .f = function(path) {
            read_csv(
                path,
                col_types = cols(
                    manufacturer = col_character(),
                    model = col_character(),
                    displ = col_double(),
                    year = col_double(),
                    cyl = col_double(),
                    trans = col_character(),
                    drv = col_character(),
                    cty = col_double(),
                    hwy = col_double(),
                    fl = col_character(),
                    class = col_character()
                )
            )
        }
    )

# 3.0 BINDING DATA FRAMES ----

car_data_tbl <- car_data_list %>%
    set_names(dir_ls(directory_that_holds_files)) %>%
    bind_rows(.id = "file_path")

car_data_tbl


# 4.0 CREATE A DIRECTORY ----
# - fs package

new_directory <- "car_data_01"

dir_create(new_directory)

# 5.0 SPLITTING & WRITING CSV FILES ----


car_data_tbl %>%
    mutate(file_path = file_path %>% str_replace(directory_that_holds_files, new_directory)) %>%
    group_by(file_path) %>%
    group_split() %>%
    map(
        .f = function(data) {
            write_csv(data, path = unique(data$file_path))
        }
    )
