##Module 1 PR##
#load packages
library(ggplot2)
library(tidyverse)
#working directory already set manually
#load dataset
dat <- read.csv("scales.csv")
#Dataf summary
dim(dat)
head(dat)
#Data classes + operations
sapply(dat,class)
#Constructing summary dataframe for species count in dataset
dat$species <- as.factor(dat$species)
species <- levels(dat$species)
species
length(species)
##Number of Punctures for each Species
species.n <- dat %>%
  group_by(species) %>%
  summarise(n = n())
species.n
##Number of Specimens Sampled For Each Species
dat %>% 
  count(species,specimen) %>%
  print() %>%
  count(species,name = "n.specimens")
##Compile PDF
for(i in species){
  p <- dat %>%
    filter(species==i)%>%
    ggplot()+geom_boxplot(aes(x=quadrant,y=N))+ggtitle(i)
  print(p)
}
pdf("Andrew_Gans_species_quadrant.pdf")
for(i in species){
  p <- dat %>%
    filter(species==i) %>%
    ggplot() + geom_boxplot(aes(x=quadrant,y=N)) + ggtitle(i)
  print(p)
}
dev.off()
list.files(pattern = ".pdf")
##End##
