# This script builds all information stored within galaxias/R/sysdata.rda
# storing of such code in /data-raw is recommended in 'R Packages' by
# Hadley Wickham, section 8.3 'Internal data'
# https://r-pkgs.org/data.html

# library(xml2) # convert example XML to list
library(usethis) # adding content to sysdata.rda


library(readr)
doi_table <- read_csv("./data-raw/doi_table.csv")

# add to r/sysdata.rda
use_data(
  doi_table,
  internal = TRUE,
  overwrite = TRUE)