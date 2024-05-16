library(galah)
library(tidyverse)
library(ggridges)
library(here)

galah_config(email = "dax.kellie@csiro.au", atlas = "Australia")

search_taxa("Ptilonorhynchidae")

# download data
bowerbirds <- galah_call() |>
  galah_identify("Ptilonorhynchidae") |>
  galah_filter(year > 2000) |>
  galah_apply_profile(ALA) |>
  galah_select(eventDate, scientificName) |>
  atlas_occurrences()

# format date, extract month
bowerbirds_cleaned <- bowerbirds |>
  drop_na() |>
  mutate(
    eventDate = as_date(eventDate),
    month = month(eventDate, abbr = TRUE, label = TRUE),
    date_julian = lubridate::yday(eventDate)
  )

# bigger palette
custom_brew <- MetBrewer::met.brewer("Morgenstern", n=30)

## PLOT
ggplot(
  data = cuckoos_filtered,
  aes(
    x = date_julian,
    y = fct_reorder(scientificName, date_julian, .fun = mean),
    colour = fct_reorder(scientificName, date_julian, .fun = mean),
    fill = fct_reorder(scientificName, date_julian, .fun = mean)
  )) +
  ggridges::geom_density_ridges(
    bandwidth = 17,
    scale = 6.2,
    alpha = .8,
    size = .4,
    rel_min_height = 0.02
  ) +
  scale_x_continuous(
    breaks = c(1, 91, 182, 274),
    labels = c("Jan", "Apr", "Jul", "Oct")
  ) +
  scale_fill_manual(values = custom_brew[1:30]) +
  scale_colour_manual(values = custom_brew[1:30]) +
  pilot::theme_pilot(
    grid = "",
    axes = ""
  ) +
  theme(legend.position = "none",
        axis.title.y = element_blank(),
        axis.text.y = element_blank(),
        axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        # plot.background = element_rect(fill = "#212232", colour = NULL),
        # panel.background = element_rect(fill = "#212232", colour = NULL)
        plot.background = element_rect(fill = "#557163", colour = NULL),
        panel.background = element_rect(fill = "#557163", colour = NULL)
        # plot.background = element_rect(fill = "#7D4466", colour = NULL),
        # panel.background = element_rect(fill = "#7D4466", colour = NULL)
        )


# ---

# save
ggsave(here("images", "ridgeplot_bowerbirds.png"),
       dpi = 300,
       width = 9,
       height = 5.5)


