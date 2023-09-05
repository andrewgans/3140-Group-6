#download packages
library(ggplot2)
library(tidyverse)

#set working directory and upload data
setwd("/Users/katiemiller/Desktop/EMOB F23")

dat <- read.csv("scales.csv")

#data information
dim(dat) #lines,columns
head(dat)

#classes
class(dat$N)
class(dat$quadrant)
class(dat$species)
class(dat$specimen)

mean(dat$N)
#mean(dat$quadrant)

#determine classes in one command
sapply(dat,class)

#turning species column into factors and sorting
dat$species <- as.factor(dat$species)
species <- levels(dat$species)
species

length(species)

#selecting data from dat to move into respective species variables (HARD CODING)
  #dat$species==species[1]
  #dat$species[dat$species==species[1]] 
A.rup <- length(dat$species[dat$species==species[1]] )
L.gib <- length(dat$species[dat$species==species[2]] )
L.mac <- length(dat$species[dat$species==species[3]] )
M.sal <- length(dat$species[dat$species==species[4]] )
M.sax <- length(dat$species[dat$species==species[5]] )
P.fla <- length(dat$species[dat$species==species[6]] )

  #creating new data frame with results
species.obs <- data.frame(sp=species,n=c(A.rup,L.gib,L.mac,M.sal,M.sax,P.fla))
species.obs

#creating the same data frame in less lines and saving to variable
species.n <- dat %>% #specifies the data being PASSED THROUGH
  group_by(species) %>% #takes dat$species and organizes it by group and PASSES the data THROUGH
  summarise(n = n()) #to count the number of occurrences of each group/species

species.n

#summarizing how many specimens there are of each species
dat %>%
  count(species,specimen) %>%
  print() %>%
  count(species,name = "n.specimens")

#looping
#for (i in 1:10) print(i)
for(i in species){
  p <- dat %>%
    filter(species==i) %>%
    ggplot()+geom_boxplot(aes(x=quadrant,y=N))+ggtitle(i)
  print(p)
}

#saving loop into a pdf
pdf("Katie_Miller_species_quadrant.pdf")
for(i in species){
  p <- dat %>%
    filter(species==i) %>%
    ggplot()+geom_boxplot(aes(x=quadrant,y=N))+ggtitle(i)
  print(p)
}
dev.off()

list.files(pattern=".pdf")
