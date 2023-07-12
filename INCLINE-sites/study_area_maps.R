#--------------------------------
# Study area maps
#--------------------------------

# modified from https://github.com/evalieungh/map_scripts
# 2023-06-30

# make two maps: 
# 1. Study area in N Europe
# 2. Study sites in SW Norway

{
library(rnaturalearth) 
library(tidyverse)
library(cowplot)
library(ggplot2)
library(mapdata)
library(raster)
library(sf)
}

setwd('C:/Users/evaler/OneDrive - Universitetet i Oslo/Eva/PHD/Innlevering/kappe/')

# 1. Study area in N Europe
# -------------------------------------------
# download background map 
europe <- ne_countries(scale='medium', 
											 continent = 'Europe', 
											 returnclass = 'sf')

# plot map with box marking region
fig1_a <- ggplot(data = europe) +
  geom_sf(fill = "darkgrey") +
  coord_sf(xlim = c(-5, 25), 
           ylim = c(49, 65)) +
  xlab('') + ylab('') +
  # mark region with broader extent coordinates
  geom_rect(aes(
    xmin = 6.3,
    xmax = 8.2,
    ymin = 60.6,
    ymax = 61.3
  ),
  colour = "red",
  fill = NA)
fig1_a



# 4. Sites in SW Norway
# -------------------------------------------
# download background map 
norway <- ne_countries(scale ='large', 
                       country = "Norway",
                       returnclass = 'sf')

# specify site coordinates
x <- c(8.12343,7.27596,7.17561,6.41504)
y <- c(61.0243,60.8231,60.8328,60.9335)
name <- c("Ulvehaugen", "Lavisdalen", "Gudmedalen", "Skjellingahaugen")

pointdata <- data.frame(x,
                        y,
                        name)

# set some axis parameters
tick_positions <- c(5.7, 6, 6.5, 7, 7.5, 8, 8.5)
tick_label_breaks <- c(6, 7, 8)

# plot
(fig1_b <-
    # plot background map
    ggplot(data = norway) +
    geom_sf(fill = "darkgrey") +
    # zoom in on region
    coord_sf(xlim = c(5.5, 8.4),
             ylim = c(60.3, 61.5)) +
    # scale_x_continuous(
    #   breaks = tick_label_breaks,
    #   sec.axis = sec_axis( ~ ., breaks = tick_positions, labels = "")
    # ) +
    xlab('') + ylab('') +
    # add site points
    geom_point(
      data = pointdata,
      aes(x = x,
          y = y,
          group = name),
      pch = 21,
      color = "black",
      fill = "red"
    ) +
    ggrepel::geom_text_repel(
      data = pointdata,
      aes(x = x,
          y = y,
          label = name))
)

# combine the maps
# -------------------------------------

(fig1 <- plot_grid(
  fig1_a,
  fig1_b,
  labels = c('a', 'b'),
  nrow = 1,
  ncol = 2,
  #rel_widths = c(1, 1.1),
  align = "hv"
))


# save the figure
ggsave("figure_1.jpeg",
       plot = fig1,
       device = "jpeg",
       width = 2000, 
       height = 1000,
       dpi = "print",
       units = "px")
