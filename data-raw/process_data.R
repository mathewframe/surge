library(dplyr)
library(janitor)


raw_data <- read.csv("data-raw/raw_aeso.csv") # reads csv file


market_data <- raw_data %>%
  clean_names() %>%
  select(price = actual_pool_price, load = actual_ail) %>%
  filter(!is.na(price)) # remove empty rows


usethis::use_data(market_data, overwrite = TRUE)
