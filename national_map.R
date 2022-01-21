# National site illustration map
#--------------------------------

library(rnaturalearth) 
library(tidyverse)
library(ggplot2)
library(mapdata)
library(raster)
library(sf)
theme_set(theme_bw()) # set ggplot theme

# load coordinates from site_coords.R if necessary
# specify point and polygon locations for sites
pts_seedclim <- data.frame(longitude=c(plot_lon),latitude=c(plot_lat))
pts_laticemip <- data.frame(longitude=c(latice_lon),latitude=c(latice_lat))

# download background map 
europe <- ne_countries(scale='medium', 
											 continent = 'Europe', 
											 returnclass = 'sf')

# plot map with points for sites
ggplot(data = europe) + 
		geom_sf(fill = "darkgrey") + 
		geom_point(data = pts_seedclim, 
							 aes(x = longitude, y = latitude), 
							 size = 1, shape = 16, color = "red") +
		geom_point(data = pts_laticemip, 
							 aes(x = longitude, y = latitude), 
							 size = 1, shape = 16, color = "blue") +
		coord_sf(xlim = c(4,31.5), ylim = c(57.5,71))+
  	xlab('') + ylab('')
