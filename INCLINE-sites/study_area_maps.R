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

setwd('C:/Users/evaler/OneDrive - Universitetet i Oslo/Eva/PHD/Innlevering/')

# specify site coordinates
site_lat <- c(61.0243,60.8231,60.8328,60.9335)
site_lon <- c(8.12343,7.27596,7.17561,6.41504)
site_code <- c("ALP1","ALP2","ALP3","ALP4")
site_name <- c("Ulvehaugen", "Lavisdalen", "Gudmedalen", "Skjellingahaugen")

pointdata <- data.frame(site_lat,
                   site_lon,
                   site_code,
                   site_name)

# get extent of study region as square polygon by specifying corner points
polygon_points <- st_polygon(list(rbind(
  c(min(site_lon), min(site_lat)),
  c(max(site_lon), min(site_lat)),
  c(max(site_lon), max(site_lat)),
  c(min(site_lon), max(site_lat)),
  c(min(site_lon), min(site_lat))
)))

print(polygon_points)
st_crs(polygon_points) <- 4326
st_set_crs(polygon_points, 4326)

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
           ylim = c(47, 65)) +
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
# 
# # plot map with box around area
# fig1_a <- ggplot(data = europe) +
#   geom_sf(fill = "darkgrey",
#           size = 1) +
#   geom_polygon(data = polygon_points, 
#                aes(),
#                color = "red") +
#   coord_sf(xlim = c(-6, 23),
#            ylim = c(45, 70)) +
#   xlab('') + ylab('') +
#   theme_minimal() +
#   theme(axis.text = element_blank()
#   )
fig1_a



# 4. Sites in SW Norway
# -------------------------------------------

#geom_point(
#  data = alp4_coords,
#  aes(x = longitude, y = latitude),
#  size = 1,
#  shape = 19,
#  color = "red"
#) +

# combine the maps
# -------------------------------------

composite_plot <- plot_grid(fig1_a, 
                            fig1_b,
                            labels = c('a', 'b'),
                            nrow = 1, ncol = 2,
                            #rel_widths = c(1, 1, 0.5),
                            align = "hv")


# save the figure
ggsave("figure_1.jpeg",
       plot = fig1_map,
       device = "jpeg",
       width = 500, 
       height = 750,
       dpi = "print",
       units = "px")
