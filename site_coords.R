# Site coordinates
#---------------------

######### SeedClim Sites
plot_lat <- c(61.0243,60.8231,60.8328,60.9335,60.8203,60.8760,61.0866,60.5445,61.0355,60.8803,60.6652,60.6901)
plot_lon <- c(8.12343,7.27596,7.17561,6.41504,8.70466,7.17666,6.63028,6.51468,9.07876,7.16982,6.33738,5.96487)
plot_name <- c("ALP1","ALP2","ALP3","ALP4","SUB1","SUB2","SUB3","SUB4","BOR1","BOR2","BOR3","BOR4")

xfloor=plot_lon-0.005
xceil =plot_lon+0.005
yfloor=plot_lat-0.005
yceil =plot_lat+0.005

# corner coordinates (sw=southwest, etc)
sw <- data.frame(plot_name,corner=c(rep(1,12)),x=xfloor,y=yfloor)
se <- data.frame(plot_name,corner=c(rep(2,12)),x=xceil,y=yfloor)
ne <- data.frame(plot_name,corner=c(rep(3,12)),x=xceil,y=yceil)
nw <- data.frame(plot_name,corner=c(rep(4,12)),x=xfloor,y=yceil)
sw2 <- data.frame(plot_name,corner=c(rep(5,12)),x=xfloor,y=yfloor)

######### LATICE-MIP sites
latice_lat <- c(60.59383774, 61.10516357,	61.1115036, 69.3408715 , 59.660278, 60.372387)
latice_lon <- c(7.527008533,12.25481033,12.25089836, 25.29547425, 10.781667, 11.078142)
latice_name <- c('finseflux', 'hisaasen_upper', 'hisaasen_lower', 'iskoras', 'aas', 'hurdal')

xfloor=latice_lon-0.005 # Is this the correct gridcell size for the LATICE-MIP sites too? 
xceil =latice_lon+0.005
yfloor=latice_lat-0.005
yceil =latice_lat+0.005