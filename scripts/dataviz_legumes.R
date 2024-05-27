
library(ggplot2)
library(galah)
library(dplyr)

# This dataviz was inspired by this wonderful blog by Liz Roten. Thanks Liz!
# https://www.lizroten.com/post/rtistry-with-contour/

library(showtext)
font_add_google("Dosis", "dosis")
showtext_auto()


galah_config(email = "dax.kellie@csiro.au")

# Legumes
search_taxa("Fabaceae")


# Top 5 most recorded legume species
legume_counts <- galah_call() |>
  identify("Parkinsonia aculeata",
           "Acacia melanoxylon",
           "Glycine clandestina",
           "Senna artemisioides",
           "Hardenbergia violacea") |>
  filter(year > 1950) |>
  group_by(species, year) |>
  count() |>
  collect()


legume_edited <- legume_counts |>
  mutate(
    xend = rep(0,nrow(mimosa_counts)),
    yend = rep(0,nrow(mimosa_counts))
  )

increment <- 1.2
circle = tibble(
  x = seq(from = 0, to = nrow(mimosa_counts)/5, by = increment + increment),
  xend = seq(from = 0, to = nrow(mimosa_counts)/5, by = increment + increment),
  y = -1,
  yend = -0.1,
  type = LETTERS[2])

ggplot() +
  # swoopy lines
  geom_segment(data = legume_edited,
               aes(x = year,
                   y = log10(count),
                   xend = xend,
                   yend = yend,
                   colour = species
                   ),
               # color = "white",
               alpha = 0.5,
           stat = "identity") +
  geom_point(data = legume_edited,
             aes(x = year,
                 y = log10(count),
                 colour = species
                 ),
             size = 0.5) +
  scale_color_manual(values = c("#2C2359",
                               "#3C2A3F",
                               "#5B3B5B",
                               "#D5C0C3",
                               "#DEA774"
                               )) +
  # circle
  ggnewscale::new_scale_color() + 
  geom_segment(data = circle,
               aes(x = x, 
                   y = y,
                   xend = xend, 
                   yend = yend),
               colour = "#FBC55F",
               show.legend = F) + 
  labs(caption = "Dax Kellie") + 
  coord_radial(inner.radius = 0.0, r.axis.inside = FALSE) + 
  theme_void() +
  theme(legend.position = "none",
        plot.background = element_rect(fill = "#1D1621", colour = NA),
        panel.background = element_rect(fill = "#1D1621", colour = NA),
        plot.caption = element_text(family = "dosis",
                                    color = "#DEA774",
                                    hjust = 1,
                                    size = 7),
        plot.margin = unit(c(0.5, 3, 0.5, 3), "cm")
        )

# save
showtext_opts(dpi = 350)
ggsave(here::here("images", "circlular-lines_legumes.png"),
       dpi = 350,
       width = 9,
       height = 5.5)
