install.packages("maptools")
install.packages("rgdal")
install.packages("raster")
install.packages("rgdal")
install.packages("maps")
install.packages("mapdata")
install.packages("ggmap")
install.packages("Lattice")
install.packages("sp")
install.packages("dplyr")
library(dplyr)
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

#Objective 1 and two: Map of sampling area and sampling type, bubble map of frequency of fish pings across all receivers. 

install.packages('usmap', dependencies= TRUE)
library(usmap)

install.packages("gcookbook")
library(gcookbook)

register_google(key= "AIzaSyDmnvI2H2L3aVAOk4cdSaDLbYZPNn1DXyQ")
#Map for Obj 1
myLocation <- c(lon = -70.7833, lat = 43.0989)

my_points <- data.frame(lon = -70.7833, lat = 43.0989) #need to pull in CSV file earlier. Should be read in as a dataframe . Color=type
myMap <- get_googlemap(center= myLocation, maptype= "satellite", zoom=11) 

myMap2 <- get_googlemap(center= myLocation, maptype= "satellite", zoom=11, color="bw") 

#######

#Obj 1: Map of all locations, with specific marker colors, shapes, and sizes
lat_long <- read.csv("lat_longs_rfw.csv", stringsAsFactors = TRUE)

AllPoints <- data.frame(lat_long)

ggmap(myMap) + geom_point(data=AllPoints, aes(x=longitude, y=latitude, shape = type, color= type, size = type)) + scale_shape_manual (values= c(15,17,19), labels=c("Fyke Net (4)", "Receiver (22)", "Water Sample (13)")) + scale_size_manual(values = c(4,2,2), labels=c("Fyke Net (4)", "Receiver (22)", "Water Sample (13)")) + scale_color_manual (values=c("#D55E00", "#F0E442", "#56B4E9"), labels=c("Fyke Net (4)", "Receiver (22)", "Water Sample (13)")) + ggtitle("Map of Sampling Locations in Great Bay") + theme(plot.title = element_text(face = "bold", hjust = 0.5)) + labs(shape="Sampling Method", color="Sampling Method", size="Sampling Method") + ylab("Latitude") + xlab("Longitude") 

#Note that above, legend title and labels had to be added in 3 times to shape, color, and size to change label on plot. 

#Obj 2: Heat map based on receiver pings
require(dplyr)
library(dplyr)
#bring in data file
ReceiverPings <- read.csv("all_detection_data.csv", stringsAsFactors = TRUE)
LatLong <- read.csv("receiver_lat_long.csv")
#make file a data frame
ReceiverPings <- data.frame(ReceiverPings)
LatLong <- data.frame(LatLong)
#combine data frame with other data set to include lat and longs into new dataset "ReceiverPingLL"
ReceiverPingLL <- left_join(ReceiverPings, LatLong) #insert y based on X
View(ReceiverPingLL)
#create summary table with counts for receiver number 
ReceiverSummary <- ReceiverPingLL%>%
  select(receiver, latitude, longitude)%>%
  dplyr::count(vars= receiver, latitude, longitude, name = "Frequency") %>% arrange(desc(Frequency))

?mutate
View(ReceiverSummary)
#make map!

#install color package
install.packages("viridis")
library(viridis)


ggmap(myMap2) + geom_point(data=ReceiverSummary, aes(x=longitude, y=latitude, size=Frequency), color="white", fill="yellow", stroke= 1, pch=21, alpha=0.8) +   scale_size_continuous(range=c(1,12)) + ggtitle("Frequency of Smelt Detections in Great Bay") + theme(plot.title = element_text(face = "bold", hjust = 0.5)) + ylab("Latitude") +xlab("Longitude") 

FrequencyMap <- ggmap(myMap2) + geom_point(data=ReceiverSummary, aes(x=longitude, y=latitude, size=Frequency), color="white", fill="yellow", stroke= 1, pch=21, alpha=0.8) +   scale_size_continuous(range=c(1,12)) + ggtitle("Frequency of Smelt Detections in Great Bay") + theme(plot.title = element_text(face = "bold", hjust = 0.5)) + ylab("Latitude") +xlab("Longitude") 



       