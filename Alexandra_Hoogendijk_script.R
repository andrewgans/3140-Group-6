#Module 1 Project

#to begin you must load packages
library(ggplot2)
library(tidyverse)
#set directory session - set working directory - choose directory - Module 1 Project EMOB

#Question 1: A dat variable containing the scales dataset.
dat <- read.csv("scales.csv")

#Question 3: A line of code which reports the dimensions of the dataset.
dim(dat)

#Question 2: A line of code which reports the class of each column in the dataset.
sapply(dat,class)

#Code that produces a summary of the number of scales punctured for each species.
dat %>%
  group_by(species) %>%
  summarise(n = n())

#Code that produces a summary of the number of specimens sampled for each species.
species.n<- dat %>%
  group_by(species) %>%
  summarise(n = n())
species.n

#Code that produces a summary of the number of scales punctured for each species.
dat %>% 
  count(species,specimen) %>%
  print() %>%
  count(species,name = "n.specimens")

##Code that produces a PDF file containing 6 figures, one for each species that includes a boxplot of puncture force verus quadrant.
for(i in species){
  p <- dat %>%
    filter(species==i)%>%
    ggplot()+geom_boxplot(aes(x=quadrant,y=N))+ggtitle(i)
  print(p)
}

pdf("Alexandra_Hoogendijk_species_quandrant.pdf")
for(i in species){
  p <- dat %>%
    filter(species==i)%>%
    ggplot()+geom_boxplot(aes(x=quadrant,y=N))+ggtitle(i)
  print(p)
}
dev.off()

list.files(pattern=".pdf")
