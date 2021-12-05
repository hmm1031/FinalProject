data <- read.csv("tag_otolith.csv")

require(dplyr)
require(ggplot2)
require(plotrix)
require(readxl)
require(lubridate)
require(stringr)

data_otoliths <- subset(data, Collection.Method %in% c("fyke net", "creel survey"))
data_tag <- subset(data, Collection.Method %in% c("Fyke Net"))

#number collected split by river, collection method, male vs female
ggplot(data = data_otoliths,
       mapping = aes(x = Location, y = Sex, fill = Sex)) +
  geom_bar(stat = "identity", position = position_dodge()) +
  theme_classic() +
  labs(x = "River", y = "Number Collected") +
  theme(axis.title.y = element_text(vjust = 2.5), 
        axis.title.x = element_text(vjust = -0.3), 
        axis.text.y = element_text(color = "black"), 
        axis.text.x = element_text(color = "black", angle = 90))+ 
  facet_wrap(~Collection.Method)

otoliths_grouped <- group_by(data_otoliths, Location, Sex, Collection.Method, Date)

smry <- summarize(otoliths_grouped,
                  mean_tl = mean(TL..mm.), 
                  se_tl = std.error(TL..mm.))

#Mean tl with se split by river, collection method, male vs female
## need to capitalize the creel and fyke labels
ggplot(data = smry, 
       mapping = aes(x = Location, y = mean_tl, ymin = mean_tl- se_tl, ymax = mean_tl+ se_tl, fill = Sex)) +
  geom_bar(stat = "identity", position = position_dodge()) + 
  geom_errorbar(colour = "black", stat = "identity", position = position_dodge(0.65), width = 0.4) +
  theme_classic() +
  labs(x = "River", y = "Mean total length (mm)", color = "Sex") +
  theme(axis.title.y = element_text(vjust = 2.5), 
        axis.title.x = element_text(vjust = -0.3), 
        axis.text.y = element_text(color = "black"), 
        axis.text.x = element_text(color = "black", angle = 90))+ 
  facet_wrap(~Collection.Method)

#this is for the first data graph figure (Fig. 6)
# for the chunk: r, echo = FALSE, warning = FALSE, fig.align = "center", 
# fig.cap = "Mean total length of rainbow smelt sampled for tagging verus otolith microchemistry analysis. 
# Samples taken across four rivers (n= 7, 21, 18 for tagged fish from the Bellamy, Oyster, and Squamscott River, respectively; 
# n= 11, 29, 31, 8 for otolith fish from the Bellamy, Oyster, Squamscott, and Winnicut River, respectively). 
#Error bars represent standard error."

data <- read.csv("tag_otolith.csv")

require(dplyr)
require(ggplot2)
require(plotrix)
require(readxl)
require(lubridate)
require(stringr)

# remove river so sites called by just name, not name+river
data$Location <- sub("Squamscott River", "Squamscott", data$Location)
data$Location <- sub("Squamscott", "Squamscott River", data$Location)

data$Location <- sub("Oyster River", "Oyster", data$Location)
data$Location <- sub("Oyster", "Oyster River", data$Location)

data$Location <- sub("Bellamy River", "Bellamy", data$Location)
data$Location <- sub("Bellamy", "Bellamy River", data$Location)

data$Location <- sub("Winnicut River", "Winnicut", data$Location)
data$Location <- sub("Winnicut", "Winnicut River", data$Location)

total_grouped <- group_by(data, type, Sex, Location)

total_smry <- summarize(total_grouped,
                        mean_tl = mean(TL..mm.), 
                        se_tl = std.error(TL..mm.))



#TL of otoliths vs tagged fish by river and sex
ggplot(data = total_smry, 
       mapping = aes(x = type, y = mean_tl, ymin = mean_tl- se_tl, ymax = mean_tl+ se_tl, fill = Sex)) +
  geom_bar(stat = "identity", position = position_dodge()) + 
  geom_errorbar(colour = "black", stat = "identity", position = position_dodge(0.65), width = 0.4) +
  theme_classic() +
  labs(x = "", y = "Mean total length (mm)", color = "Sex") +
  theme(axis.title.y = element_text(vjust = 2.5), 
        axis.title.x = element_text(vjust = -0.3), 
        axis.text.y = element_text(color = "black"), 
        axis.text.x = element_text(color = "black"))+
  facet_wrap(~Location)

