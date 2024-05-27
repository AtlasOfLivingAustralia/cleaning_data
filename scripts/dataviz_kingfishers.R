# Title: galah_radius example query & map

library(galah)
library(ozmaps)
library(sf)
library(ggplot2)
library(maps) # to get cities
library(ggtext)
library(ggrepel)
library(dplyr)
library(tidyr)

galah_config(email = "dax.kellie@csiro.au")

# Download kookaburra occurrence records in 40 km radius
birds <-
  galah_call(type = "occurrences") |>
  identify("dacelo") |>
  filter(year == 2023) |>
  galah_geolocate(lon = 151,
                  lat = -34,
                  radius = 500, # in km
                  type = "radius") |>
  collect()


birds_sf <- birds |>
  st_as_sf(coords = c("decimalLongitude", "decimalLatitude"), crs = 4326) |>
  drop_na()

## Buffer

# create point
point <- st_point(c(151, -34)) |> st_sfc(crs = 4326)

# create circle with buffer radius
circle <- sf::st_buffer(point, dist = 40050)
circle_bigger <- sf::st_buffer(point, dist = 120050)

birds_circle <- birds_sf |>
  mutate(
    in_circle = ifelse(sf::st_contains(circle, birds_sf, sparse = FALSE)[1,], "Yes", "No"),
    in_circle_bigger = ifelse(sf::st_contains(circle_bigger, birds_sf, sparse = FALSE)[1,], "Yes", "No"),
    circle = case_when(
      in_circle == "No" & in_circle_bigger == "Yes" ~ "big",
      in_circle == "No" & in_circle_bigger == "No" ~ "none",
      .default = "small"),
    group = sample(1:3,nrow(birds_sf), replace = TRUE)
    )




# Font

library(showtext)
font_add_google("Roboto", "roboto")

showtext_auto()
showtext_end()

## MAP

ggplot() +
  geom_sf(data = ozmaps::ozmap_states |>
            st_transform(crs = st_crs(4326)),
          colour = "grey60",
          fill = "#0C121E") +
  geom_sf(data = circle,
          fill = NA,
          colour = "grey50") +
  geom_sf(data = birds_circle |> filter(circle == "small"),
             colour = "#2C897E",
             alpha = 0.3,
             size = 1.2) +
  ggnewscale::new_scale_color() +
  geom_sf(data = birds_circle |> filter(circle == "big"),
          aes(colour = as.factor(group)),
          alpha = 0.5,
          size = 1.2) +
  scale_colour_manual(values = c("#9CC6BF",
                                 "#97BE93",
                                 "#CFDF9B"
  )) +
  ggnewscale::new_scale_color() +
  geom_sf(data = birds_circle |> filter(circle == "none"),
          colour = "#CFDF9B",
          alpha = 0.1,
          size = 1.2) +
  coord_sf(xlim = c(142, 160.5),
           ylim = c(-29.6, -39)) +
  theme_void() +
  theme(legend.position = "non",
        # text = element_text(family = "roboto", size = 18),
        plot.background = element_rect(fill = "#1B263A", colour = NA),
        panel.background = element_rect(fill = "#1B263A", colour = NA)
  )

# save
showtext_opts(dpi = 350)
ggsave(here::here("images", "map_kingfishers.png"),
       dpi = 350,
       width = 9,
       height = 5.5)
