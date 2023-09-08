##Module 1 PR##
#load packages
library(ggplot2)
library(tidyverse)
#working directory already set manually
##Question 1 - A dat variable containing the scales dataset##
#load dataset
dat <- read.csv("scales.csv")
##Question 2 - A line of code which reports the class of each column in the dataset##
sapply(dat,class)
##Question 3 - A line of code which reports the dimensions of the dataset##
dim(dat)
###Question 4 - Code that produces a summary of the number of scales punctured for each species##
#Number of Punctures for each Species
species.n <- dat %>%
  group_by(species) %>%
  summarise(n = n())
species.n
##Question 5 - Code that produces a summary of the number of specimens sampled for each species##
#Number of Specimens Sampled For Each Species
dat %>% 
  count(species,specimen) %>%
  print() %>%
  count(species,name = "n.specimens")
##Question 6 - Code that produces a PDF file containing 6 figures##
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
##End##
