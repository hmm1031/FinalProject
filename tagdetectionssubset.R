require(dplyr)
require(tidyr)
require(stringr)

# fileEncoding = 'UTF-8-BOM' to remove double dotted i in labels
detections <- read.csv("VUE_Export_8_6_21.csv", stringsAsFactors = TRUE, fileEncoding = 'UTF-8-BOM')

detection <- subset(detections, select = -c(Transmitter.Name, Transmitter.Serial, Sensor.Value, Sensor.Unit, Station.Name, Latitude, Longitude, Transmitter.Type, Sensor.Precision))


detection <- detection %>%
  separate(Receiver, c("vr", "receiver"), "-")

detection <- detection %>%
  separate(Transmitter, c("Afreq", "a", "tag"), "-")

detection <- detection %>%
  separate(Date.and.Time..UTC., c("month", "day", "year"), "/")

detection <- detection %>%
  separate(year, c("year", "time"), " ")

detection180 <- subset(detection, 
                       vr == "VR2W180" & year== "2021", select= year:tag)


detection180tag <- subset(detection180, tag %in% c("53805", "53806", "53807", "53805", "53804", "53777", "53799", "53800", "53801", "53802", "53803", "53793", "53794", "53795", "53787", "53788", "53796", "53797", "53798", "53789", "53790", "53791", "53792", "53781", "53781", "53782", "53783", "53764", "53785", "53786", "53775", "53776", "53778", "53779", "53780", "53769", "53770", "53771", "53772", "53773", "53774", "53763", "53764", "53765", "53766", "53767"))
-
# can use detection180rec to subset for individual fish- already been subsetted to 180, 2021, specific tags, specific receivers
detection180rec <- subset(detection180tag, receiver %in% c("301894", "302995", "301886", "301889", "301892", "301890", "301887", "301893", "301884", "301891", "302950", "302953", "302954", "302949", "301888", "302951", "302947", "301883", "302956", "302948", "302952"))

#rivers = lamprey, squamscott, bellamy, oyster, cocheco
rivers <- subset(detection180rec, receiver %in% c("301894", "302995", "301886", "301893", "301887"))

#great bay = gbc, adam, adam
great_bay <- subset(detection180rec, receiver %in% c("301889", "301892", "301890"))

#upper piscataqua = goat, goat, carloni, USGS1, USGS2
upper_piscataqua <- subset(detection180rec, receiver %in% c("301884", "301891", "302950", "302953", "302954"))

#exit = marina, shiller, gerrish, fishing, southern exit, USGS 3, USGS 4, aquafort
exit <- subset(detection180rec, receiver %in% c("302949", "301888", "302951", "302947", "301883", "302956", "302948", "302952"))

detection53786 <- subset(detection180rec, tag %in% c("53786"))

detection53774 <- subset(detection180rec, tag %in% c("53774"))

detection53792 <- subset(detection180rec, tag %in% c("53792"))

detection53801 <- subset(detection180rec, tag %in% c("53801"))
