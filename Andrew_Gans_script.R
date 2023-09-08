##Module 1 PR##
#load packages
library(ggplot2)
library(tidyverse)
#working directory already set manually
##Question 1- Load dat variable with scales dataset##
#load dataset
dat <- read.csv("scales.csv")

##Question 2 - Report Class of Each Column##
#Data classes + operations
sapply(dat,class)

##Question 3 - Dimensions of Dataset##
dim(dat)

##Question 4 - Number of Punctures for each Species##
species.n <- dat %>%
  group_by(species) %>%
  summarise(n = n())
species.n

##Question 5 - Number of Specimens Sampled For Each Species##
dat %>% 
  count(species,specimen) %>%
  print() %>%
  count(species,name = "n.specimens")

##Question 6 - Compile PDF File with plots 
#Compile PDF
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
