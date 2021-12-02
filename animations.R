install.packages("maptools")
install.packages("rgdal")
install.packages("raster")
install.packages("rgdal")
install.packages("maps")
install.packages("mapdata")
install.packages("ggmap")
install.packages("Lattice")
install.packages("sp")
install.packages('gifski')
install.packages('png')
library(sp)
library(maptools)
library(rgdal)
library(maptools)
library(rgdal)
library(raster)
library(maps)
library(mapdata)
library(ggmap)
library(marmap)
library(lattice)
library(ggplot2)
library(tidyverse)
library(gganimate)
library(gifski)
library(png)

register_google(key= "AIzaSyDmnvI2H2L3aVAOk4cdSaDLbYZPNn1DXyQ")

myLocation <- c(lon = -70.7833, lat = 43.0989)

myMap <- get_googlemap(center= myLocation, maptype= "satellite", zoom=11)

ggmap(myMap)

lat_long <- read.csv("receiver_lat_long.csv")

all_detections <- read.csv("detections_animations.csv")

detections <- left_join(all_detections, lat_long)

#fish1 is 53786
fish1 <- subset(detections, tag %in% c("53786"))
#%R is equal to hour:minute
fish1$date <- as.POSIXct(fish1$date, format = "%m/%d/%Y %R")

anim <- ggmap(myMap) + 
  geom_point(data=fish1, aes(x=longitude, y=latitude), color = "orange", size = 3)+
  transition_time(date)+
  theme(plot.title= element_text(face = "bold")) +
  theme(plot.title = element_text(hjust = 0.5)) +
  labs(x= "Longitude", y = "Latitude", title = "{frame_time}")+
  shadow_wake(wake_length= 0.2, alpha = FALSE)+
  theme(panel.background = element_rect(color = "black"))
  
animate(anim, nframes= length(unique(fish1$date)), detail = 5, end_pause= 30)

anim_save(filename = "fish53786.mp4", anim)








  


