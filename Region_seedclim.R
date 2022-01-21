# Regional site illustration map - SeedClim sites
#--------------------------------------------------

library(rnaturalearth) 
library(tidyverse) # for piping, arrange()
library(rasterVis) # for gplot() 
library(ggplot2)
library(mapdata)
library(raster)
library(sf)
theme_set(theme_bw()) # set ggplot theme

# load coordinates from site_coords.R if necessary
# specify point and polygon locations for sites
pts_seedclim <- data.frame(longitude=c(plot_lon),latitude=c(plot_lat))
poly_seedclim <- rbind(sw,se,ne,nw,sw2) %>%
	arrange(plot_name,corner)
poly_seedclim <- st_polygon(list(cbind(poly_seedclim$x,poly_seedclim$y)))

# get extent (use to set xlim and ylim in plot - remove last decimal to get a slightly larger extent than the site borders)
print(c(min(xfloor), max(xceil), min(yfloor), max(yceil)))
# 5.95987  9.08376  60.53950  61.09160

# get elevation (digital terrain model) data and crop to region
dtm_Norway <- getData('worldclim', var='alt', res=2.5) # for better resolution, download res=0.5 elevation from worldclim.org
dtm_Norway <- raster('C:/Users/evaler/OneDrive - Universitetet i Oslo/Eva/PHD/Div/GIS/WorldClim/wc2.1_30s_elev.tif') # better resolution
region <- as(extent(5.9,9.1,60.2,61.4), 'SpatialPolygons')
dtm_region <- crop(dtm_Norway,region)

# plot the map (terrain detail, raster)
gplot(dtm_region) +
	geom_raster(aes(fill=value)) +
	scale_fill_gradient(low = 'black', high = 'white')+
	coord_equal() +
	geom_polygon(data = poly_seedclim, 
							 aes(x = x, y = y, group = plot_name),
							 color = "red") +
	xlab('') + ylab('') + 
	ggtitle("SeedClim sites in western Norway \n over digital terrain model") +
	theme(legend.position = "none")

# plot the map -- alternative (simpler, vector)
europe <- ne_countries(scale='medium', 
											 continent = 'Europe', 
											 returnclass = 'sf') # downloads map from naturalearth

ggplot(data = europe) +
	geom_sf(fill = "darkgrey") +
	geom_polygon(data = poly_seedclim, # add square polygons for gridcell locations with real extent
							 aes(x = x, y = y, group = plot_name),
							 fill = 'transparent', color = "red") +
	coord_sf(xlim = c(5.9598,9.0837), ylim = c(60.5,61.3))+ # zoom in on region
	xlab('') + ylab('') + 
	ggtitle("SeedClim sites in western Norway") 
