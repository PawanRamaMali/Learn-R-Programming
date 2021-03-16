#install.packages('readxl')

library(readxl)

# Read Files ----

bikes_tbl <- read_excel('data/bikes.xlsx')

bikeshops_tbl <- read_excel('data/bikeshops.xlsx')

orderlines_tbl <- read_excel('data/orderlines.xlsx')

# View Data ----

bikes_tbl
bikeshops_tbl
orderlines_tbl
