## Function for handling DOIs

library(dplyr)
library(tidyr)

add_doi <- function(chapter, name, doi) {
  
  new <- tibble(chapter = {{chapter}},
                name = {{name}},
                doi = {{new_doi}})
  
  doi_table <- doi_table |>
    dplyr::rows_insert(new)
  
  
}

update_doi <- function(chapter, name, new_doi) {

  new <- tibble(chapter = {{chapter}},
                name = {{name}},
                doi = {{new_doi}})
  
  doi_table <- doi_table |>
    dplyr::rows_update(new)
  
}
