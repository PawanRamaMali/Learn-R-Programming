# skimr: designed for data quality

# LIBRARIES ----

library(skimr)
library(tidyverse)

# DATA ----

starwars

# SKIMMING! ----
# - Gives a super-helpful diagnostic report
# - Great for understanding missing data
# - Great for quickly understanding your data composition (numeric, date, factor, etc)

# * Starwars / Missing Data & Lists ----
starwars %>% skim()

starwars %>% filter(is.na(birth_year))

# * Storms / Missing Data & Categorical ----
storms %>% skim()

# * Economics / Time Series (Date) ----
economics %>% skim()

# * Economics Long / Grouped Data ----
economics_long %>% group_by(variable) %>% skim()




