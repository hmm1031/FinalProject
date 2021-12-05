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

fish1anim <- ggmap(myMap) + 
  geom_point(data=fish1, aes(x=longitude, y=latitude), color = "orange", size = 3)+
  transition_time(date)+
  theme(plot.title= element_text(face = "bold")) +
  theme(plot.title = element_text(hjust = 0.5)) +
  labs(x= "Longitude", y = "Latitude", title = "{frame_time}")+
  shadow_wake(wake_length= 0.2, alpha = FALSE, colour = "white")
  
animate(fish1anim, nframes= length(unique(fish1$date)), detail = 5, end_pause= 30)

#having issues saving
anim_save(filename = "fish53786.mp4", fish1anim)


#fish2 is 53792
fish2 <- subset(detections, tag %in% c("53792"))
#%R is equal to hour:minute
fish2$date <- as.POSIXct(fish2$date, format = "%m/%d/%Y %R")

fish2anim <- ggmap(myMap) + 
  geom_point(data=fish2, aes(x=longitude, y=latitude), color = "purple", size = 3)+
  transition_time(date)+
  theme(plot.title= element_text(face = "bold")) +
  theme(plot.title = element_text(hjust = 0.5)) +
  labs(x= "Longitude", y = "Latitude", title = "{frame_time}")+
  shadow_wake(wake_length= 0.2, 
              alpha = FALSE, 
              colour = "white", 
              falloff = "linear")

animate(fish2anim, nframes= length(unique(fish2$date)), detail = 5, end_pause= 30, fps = 3)

#having issues saving
anim_save(filename = "fish53786.mp4", fish2anim)


#fish2 is 53774
fish3 <- subset(detections, tag %in% c("53774"))
#%R is equal to hour:minute
fish3$date <- as.POSIXct(fish3$date, format = "%m/%d/%Y %R")

fish3anim <- ggmap(myMap) + 
  geom_point(data=fish3, aes(x=longitude, y=latitude), color = "turquoise", size = 3)+
  transition_time(date)+
  theme(plot.title= element_text(face = "bold")) +
  theme(plot.title = element_text(hjust = 0.5)) +
  labs(x= "Longitude", y = "Latitude", title = "{frame_time}")+
  shadow_wake(wake_length= 0.2, alpha = FALSE, colour = "white")

animate(fish3anim, nframes= length(unique(fish3$date)), detail = 5, end_pause= 50)

#having issues saving
anim_save(filename = "fish53786.mp4", fish2anim)


#fish4 is 53801
fish4 <- subset(detections, tag %in% c("53801"))
#%R is equal to hour:minute
fish4$date <- as.POSIXct(fish4$date, format = "%m/%d/%Y %R")

fish4anim <- ggmap(myMap) + 
  geom_point(data=fish4, aes(x=longitude, y=latitude), color = "pink", size = 3)+
  transition_time(date)+
  theme(plot.title= element_text(face = "bold")) +
  theme(plot.title = element_text(hjust = 0.5)) +
  labs(x= "Longitude", y = "Latitude", title = "{frame_time}")+
  shadow_wake(wake_length= 0.2, alpha = FALSE, color = "white")

animate(fish4anim, nframes= length(unique(fish4$date)), detail = 5, end_pause= 30)

#having issues saving
anim_save(filename = "fish53786.mp4", fish2anim)


#fish4 is 53801
all <- detections
#%R is equal to hour:minute
all$date <- as.POSIXct(all$date, format = "%m/%d/%Y %R")

allanim <- ggmap(myMap) + 
  geom_point(data=all, aes(x=longitude, y=latitude), color = "tag", size = 3)+
  transition_time(date)+
  theme(plot.title= element_text(face = "bold")) +
  theme(plot.title = element_text(hjust = 0.5)) +
  labs(x= "Longitude", y = "Latitude", title = "{frame_time}")+
  shadow_wake(wake_length= 0.2, alpha = FALSE)

animate(allanim, nframes= length(unique(all$date)), detail = 5, end_pause= 30)

#having issues saving
anim_save(filename = "fish53786.mp4", fish2anim)


