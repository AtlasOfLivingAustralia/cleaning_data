# Title: galah_radius example query & map

library(galah)
library(ozmaps)
library(sf)
library(ggplot2)
library(maps) # to get cities
library(ggtext)
library(ggrepel)

galah_config(email = "dax.kellie@csiro.au")

# Download kookaburra occurrence records in 40 km radius
birds <-
  galah_call(type = "occurrences") |>
  identify("dacelo") |>
  filter(year == 2023) |>
  galah_geolocate(lon = 151,
                  lat = -34,
                  radius = 60, # in km
                  type = "radius") |>
  collect()

birds_bigger <-
  galah_call(type = "occurrences") |>
  identify("dacelo") |>
  filter(year == 2023) |>
  galah_geolocate(lon = 151,
                  lat = -34,
                  radius = 100, # in km
                  type = "radius") |>
  collect()


birds_bigger_sf <- birds_bigger |>
  st_as_sf(coords = c("decimalLongitude", "decimalLatitude"), crs = 4326)



## Cities

selected_cities <- c("Sydney", "Wollongong", "Canberra", "Batemans Bay", "Tamworth", "Port Macquarie")

# download cities and filter to only selected cities
cities <- world.cities |>
  filter(country.etc == "Australia") |>
  filter(name %in% selected_cities)

# convert to sf
cities_sf <- cities |>
  st_as_sf(coords = c("long", "lat"), crs = 4326)



## Buffer

# create point
point <- st_point(c(151, -34)) |> st_sfc(crs = 4326)

# create circle with buffer radius
circle <- sf::st_buffer(point, dist = 40050)


# which points intersect
birds_bigger_intersect <- birds_bigger_sf |>
  mutate(
    in_circle = pmap_lgl(.l = list(x = birds_bigger_sf$geometry),
                     .f = function(x) {
                       st_intersects(x, circle) |>
                         as.logical()
                     })
  )

# convert to usable column
birds_bigger_out <- birds_bigger_intersect |>
  mutate(
    in_circle = case_when(in_circle == TRUE ~ "in",
                          .default = "out")
  ) |>
  filter(in_circle == "out") |>
  # assign to random colour groups
  mutate(
    group = sample(rep(c("1", "2", "3"), length=n()))
  )

# Font

library(showtext)
font_add_google("Roboto", "roboto")

showtext_auto()

library(ggnewscale)
## MAP

ggplot() +
  geom_sf(data = ozmaps::ozmap_states |>
            st_transform(crs = st_crs(4326)),
          colour = "grey60",
          fill = "#0D160B") +
  geom_sf(data = circle,
          fill = "grey15",
          colour = "grey50") +
  geom_point(data = birds,
             aes(x = decimalLongitude,
                 y = decimalLatitude),
             colour = "#f064a4",
             alpha = 0.3,
             size = 1.4) +
  ggnewscale::new_scale_colour() +
  geom_sf(data = birds_bigger_out,
          aes(group = group,
              colour = group),
          alpha = 0.8,
          size = 1.4) +
  scale_colour_manual(values = c("#f064a4",
                                 "#F6A2C8",
                                 "#DF4848")) +
  # geom_sf(data = cities_sf) +
  # ggrepel::geom_text_repel(data = cities,
  #                          aes(x = long,
  #                              y = lat,
  #                              label = name,
  #                              family = "roboto"),
  #                          size = 5,
  #                          colour = "#222322",
  #                          nudge_x = 0.8) +
  coord_sf(xlim = c(142, 155),
           ylim = c(-31.6, -38)) +
  theme_void() +
  theme(text = element_text(family = "roboto", size = 18),
        legend.position = "none",
        panel.background = element_rect(fill = "#006D77"))


# save
showtext_opts(dpi = 320)
ggsave(here::here("images/map_galah_radius.png"),
       dpi = 320,
       height = 4.8, width = 8)
