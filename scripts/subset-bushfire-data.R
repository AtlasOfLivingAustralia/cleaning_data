## Original code from Fonti to generate subsets of Curated Plant and Invertebrate Data for Bushfire Modelling

# To create data used in this chapter taken from bushfire data

inverts <- open_dataset("../data_cleaning_workflows/ignore/Curated_Plant_and_Invertebrate_Data_for_Bushfire_Modelling/invertebrate.data.csv", format = "csv")

inverts |>
  filter(family == "apidae") |>
  write_parquet(sink = "data/dap/bees.parquet")

# Smaller subset of the dataset
set.seed(5)

inverts |>
  collect() |>
  sample_frac(0.05) |>
  write_parquet(sink = "data/dap/inverts_subset")


# Plants data with errors
plants <- read_csv("../data_cleaning_workflows/ignore/Curated_Plant_and_Invertebrate_Data_for_Bushfire_Modelling/vascularplant.data.csv")

plants |>
  select(record_id:longitude_used) |>
  rename(latitude = latitude_used,
         longitude = longitude_used) |>
  sample_frac(0.05) |>
  write_parquet("data/dap/plants_subset")