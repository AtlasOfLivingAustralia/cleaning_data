# ---------------------------------------------------------------------------- #
# Use this script to generate data DOIs for all galah queries in this book
# ---------------------------------------------------------------------------- #

### TO UPDATE ALL DOIs (when re-rendering book):
#  - Run this entire script.

### TO UPDATE ONE DOI ONLY:
#  - 1. Download the data you wish to update with galah
#  - 2. Uncomment the code below and fill in with desired dataframe chapter name & dataframe name
#  - 3. Run the uncommented lines below

# library(galah)
# library(here)
# library(arrow)
# source(here::here("scripts", "doi-functions.R"))
# doi_table <- here::here("data", "galah-dois", "doi_table") |>
#   arrow::open_dataset() |>
#   collect()
#
# doi_table <- update_doi("chapter-name", "df-name", attributes(df)$doi)


# --------

library(galah)
library(here)
library(readr)
library(arrow)
source(here::here("scripts", "doi-functions.R"))

galah_config(email = Sys.getenv("ALA_EMAIL"),
             username = Sys.getenv("GBIF_USERNAME"),
             password = Sys.getenv("GBIF_PWD"),
             verbose = FALSE)

# create blank table
doi_table <- tibble(chapter = character(),
                    name = character(),
                    doi = character())



### Inspect ---------------------


birds <- galah_call() |>
  identify("alcedinidae") |>
  filter(year == 2022) |>
  select(group = "basic", 
         family, genus, species, 
         cl22, eventDate, year) |>
  atlas_occurrences(mint_doi = TRUE)

# add to table
doi <- attributes(birds)$doi
doi_table <- add_doi("Inspect", "birds", doi)


### Summarise ---------------------


birds <- galah_call() |>
  identify("alcedinidae") |>
  filter(year == 2022) |>
  select(group = "basic", 
         family, genus, species, cl22, eventDate, month) |>
  atlas_occurrences(mint_doi = TRUE)

# add to table
doi <- attributes(birds)$doi
doi_table <- add_doi("Summarise", "birds", doi)




### Column classes & names ---------------------


frogs <- galah_call() |>
  identify("Litoria") |>
  filter(year >= 2020, 
         cl22 == "Tasmania") |>
  select(group = "basic", genus, species) |>
  atlas_occurrences(mint_doi = TRUE)

# add to table
doi <- attributes(frogs)$doi
doi_table <- add_doi("Column classes", "frogs", doi)



### Duplicates ---------------------


birds <- galah_call() |>
  identify("alcedinidae") |>
  filter(year == 2023) |>
  select(group = "basic", 
         family, genus, species, cl22, eventDate, month) |>
  atlas_occurrences(mint_doi = TRUE)

# add to table
doi <- attributes(birds)$doi
doi_table <- add_doi("Duplicates", "birds", doi)



### Missing values ---------------------


geckos <- galah_call() |>
  identify("Gekkonidae") |>
  filter(year >= 2009) |>
  select(group = "basic",
         kingdom, phylum, order, class, 
         family, genus, species, cl22, 
         eventDate, month) |>
  atlas_occurrences(mint_doi = TRUE)

# add to table
doi <- attributes(geckos)$doi
doi_table <- add_doi("Missing values", "geckos", doi)



### Strings ---------------------


tree_kangaroo <- galah_call() |>
  identify("Dendrolagus") |>
  atlas_occurrences(mint_doi = TRUE)

# add to table
doi <- attributes(tree_kangaroo)$doi
doi_table <- add_doi("Strings", "tree_kangaroo", doi)



### Dates ---------------------


plants <- galah_call() |>
  identify("grevillea") |>
  atlas_occurrences(mint_doi = TRUE)

# add to table
doi <- attributes(plants)$doi
doi_table <- add_doi("Dates", "plants", doi)



### Taxonomic Validation ---------------------


birds <- galah_call() |>
  identify("alcedinidae") |>
  filter(year == 2022) |>
  select(group = "basic", 
         family, genus, species, 
         cl22, eventDate, year) |>
  atlas_occurrences(mint_doi = TRUE)

# add to table
doi <- attributes(birds)$doi
doi_table <- add_doi("Taxonomic validation", "birds", doi)


legless_lizards <- galah_call() |>
  identify("pygopodidae") |>
  filter(year > 2020) |>
  select(group = "basic") |>
  atlas_occurrences(mint_doi = TRUE)

# add to table
doi <- attributes(legless_lizards)$doi
doi_table <- add_doi("Taxonomic validation", "legless_lizards", doi)


eucalypts <- galah_call() |>
  identify("Eucalyptus") |>
  filter(eventDate > "2014-01-01T00:00:00Z",
         eventDate < "2014-06-01T00:00:00Z") |>
  select(group = "basic", 
         kingdom, phylum, class, order, 
         family, genus, species, taxonRank) |>
  atlas_occurrences(mint_doi = TRUE)

# add to table
doi <- attributes(eucalypts)$doi
doi_table <- add_doi("Taxonomic validation", "eucalypts", doi)



### Geospatial investigation ---------------------


banksia <- galah_call() |>
  identify("banksia serrata") |>
  filter(year > 2022) |>
  select(group = "basic",
         coordinatePrecision, 
         coordinateUncertaintyInMeters) |>
  atlas_occurrences(mint_doi = TRUE)

# add to table
doi <- attributes(banksia)$doi
doi_table <- add_doi("Geospatial investigation", "banksia", doi)


quokkas <- galah_call() |>
  identify("Setonix brachyurus") |>
  galah_select(group = "basic", 
               dataGeneralizations) |>
  atlas_occurrences(mint_doi = TRUE)

# add to table
doi <- attributes(quokkas)$doi
doi_table <- add_doi("Geospatial investigation", "quokkas", doi)



### Geospatial cleaning ---------------------


desert_plant <- galah_call() |>
  identify("Eremophila macdonnellii") |>
  select(group = "basic", 
         PRESUMED_SWAPPED_COORDINATE) |> # add assertion column
  atlas_occurrences(mint_doi = TRUE)

# add to table
doi <- attributes(desert_plant)$doi
doi_table <- add_doi("Geospatial cleaning", "desert_plant", doi)


frogs <- galah_call() |>
  identify("Litoria chloris") |>
  filter(year == 2013) |>
  select(group = "basic",
         countryCode, locality,
         family, genus, species, 
         cl22, eventDate) |>
  atlas_occurrences(mint_doi = TRUE)

# add to table
doi <- attributes(frogs)$doi
doi_table <- add_doi("Geospatial cleaning", "frogs", doi)


native_mice <- galah_call() |>
  identify("Dasyuroides byrnei") |>
  select(scientificName, decimalLongitude, decimalLatitude,
         eventDate,
         country, countryCode, locality, 
         COUNTRY_COORDINATE_MISMATCH,
         group = "assertions") |>
  atlas_occurrences(mint_doi = TRUE)

# add to table
doi <- attributes(native_mice)$doi
doi_table <- add_doi("Geospatial cleaning", "native_mice", doi)


acacias <- galah_call() |>
  identify("acacia aneura") |>
  select(group = "basic",
         ZERO_COORDINATE, # add assertion column
         countryCode, locality) |>
  atlas_occurrences(mint_doi = TRUE)

# add to table
doi <- attributes(acacias)$doi
doi_table <- add_doi("Geospatial cleaning", "acacias", doi)


butterflies <- galah_call() |>
  identify("Heteronympha merope") |>
  filter(year == 2014,
         decimalLatitude < 0) |>
  select(group = "basic",
         COORDINATES_CENTRE_OF_COUNTRY, # add assertion column
         COORDINATES_CENTRE_OF_STATEPROVINCE, # add assertion column
         countryCode, locality) |>
  atlas_occurrences(mint_doi = TRUE)

# add to table
doi <- attributes(butterflies)$doi
doi_table <- add_doi("Geospatial cleaning", "butterflies", doi)


bitter_peas <- galah_call() |>
  identify("Daviesia ulicifolia") |>
  atlas_occurrences(mint_doi = TRUE)

# add to table
doi <- attributes(bitter_peas)$doi
doi_table <- add_doi("Geospatial cleaning", "bitter_peas", doi)



# Big data ---------------------


pardalotes <- galah_call() |>
  identify("Pardalotus") |>
  filter(year >= 2015) |>
  select(genus, 
         species, 
         scientificName, 
         cl22,
         year,
         month, 
         decimalLatitude,
         decimalLongitude) |> 
  atlas_occurrences(mint_doi = TRUE)

# add to table
doi <- attributes(pardalotes)$doi
doi_table <- add_doi("Big data", "pardalotes", doi)

# update pardalotes.csv for Big data chapter
readr::write_csv(pardalotes,
                 here::here("data", "pardalotes.csv"))

### Joins ---------------------


pardalotes <- galah_call() |>
  identify("Pardalotus") |>
  filter(year == 2015) |>
  select(genus, 
         species, 
         scientificName, 
         cl22,
         year,
         month, 
         decimalLatitude,
         decimalLongitude) |> 
  atlas_occurrences(mint_doi = TRUE)

# add to table
doi <- attributes(pardalotes)$doi
doi_table <- add_doi("Joins", "pardalotes", doi)



# SAVE ----------------------------------------------

# write csv
arrow::write_parquet(doi_table,
                     here::here("data", "galah-dois", "doi_table"))
