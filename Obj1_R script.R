install.packages("maptools")
install.packages("rgdal")
install.packages("raster")
install.packages("rgdal")
install.packages("maps")
install.packages("mapdata")
install.packages("ggmap")
install.packages("Lattice")
install.packages("sp")
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

register_google(key= "AIzaSyDmnvI2H2L3aVAOk4cdSaDLbYZPNn1DXyQ")

myLocation <- c(lon = -70.7833, lat = 43.0989)
my_points <- data.frame(lon = -70.7833, lat = 43.0989) #need to pull in CSV file earlier. Should be read in as a dataframe . Color=type


myMap <- get_googlemap(center= myLocation, maptype= "satellite", zoom=11) 

lat_long <- read.csv("lat_longs_rfw.csv", stringsAsFactors = TRUE)

AllPoints <- data.frame(lat_long)

#Map of all locations, with specific marker colors, shapes, and sizes

ggmap(myMap) + geom_point(data=AllPoints, aes(x=longitude, y=latitude, shape = type, color= type, size = type)) + scale_shape_manual (values= c(15,17,19)) + scale_size_manual(values = c(4,2,2)) + scale_color_manual (values=c("tomato1", "deeppink3", "turquoise")) + ggtitle("Map of Sampling Locations in Great Bay") + theme(plot.title = element_text(face = "bold")) + theme (plot.title = element_text(hjust = 0.5)) 

+ scale_fill_discrete(breaks=c("Fyke net","Receiver","Water Sample"))
+ guides(fill="Type")


#Heat map based on receiver pings

ReceiverPings <- 




