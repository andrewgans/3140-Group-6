#Module 1 Project

#to begin you must load packages
library(ggplot2)
library(tidyverse)
#set directory session - set working directory - choose directory - Module 1 Project EMOB

#A dat variable containing the scales dataset.
dat <- read.csv("scales.csv")

#A line of code which reports the dimensions of the dataset.
dim(dat)

class(dat$N)
class(dat$quadrant)
class(dat$species)
class(dat$specimen)
class(dat[,1])
class(dat[,2])
class(dat[,3])
class(dat[,4])

mean(dat$N)

#A line of code which reports the class of each column in the dataset.
sapply(dat,class)

dat$species <- as.factor(dat$species)
species <- levels(dat$species)
species

length(species)

dat$species==species[1]

dat$species[dat$species==species[1]]

#Code that produces a summary of the number of scales punctured for each species.
A.rup<-length(dat$species[dat$species==species[1]])
L.gib<-length(dat$species[dat$species==species[2]])
L.mac<-length(dat$species[dat$species==species[3]])
M.sal<-length(dat$species[dat$species==species[4]])
M.sax<-length(dat$species[dat$species==species[5]])
P.fla<-length(dat$species[dat$species==species[6]])

species.obs <- data.frame(sp=species,n=c(A.rup,L.gib,L.mac,M.sal,M.sax,P.fla))
species.obs

dat %>%
  group_by(species) %>%
  summarise(n = n())

#Code that produces a summary of the number of specimens sampled for each species.
species.n<- dat %>%
  group_by(species) %>%
  summarise(n = n())
species.n

dat %>% 
  count(species,specimen) %>%
  print() %>%
  count(species,name = "n.specimens")

for(i in 1:10) print(i)

for(i in species){
  p <- dat %>%
    filter(species==i)%>%
    ggplot()+geom_boxplot(aes(x=quadrant,y=N))+ggtitle(i)
  print(p)
}

#Code that produces a PDF file containing 6 figures, one for each species that includes a boxplot of puncture force verus quadrant.
pdf("Alexandra_Hoogendijk_species_quandrant.pdf")
for(i in species){
  p <- dat %>%
    filter(species==i)%>%
    ggplot()+geom_boxplot(aes(x=quadrant,y=N))+ggtitle(i)
  print(p)
}
dev.off()

list.files(pattern=".pdf")
