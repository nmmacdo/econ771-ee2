# Title: Collecting MD-PPAS data
# Project: assignment-2-and-data
# Author: Noah MacDonald
# Date Created: October 14, 2022
# Last Edited: October 16, 2022

# Loading required packages
if (!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse)

# Loading in 2009 MD-PPAS data
taxid.base <- read.csv("data/input/MDPPAS/PhysicianData_2009.csv") %>%
  select(npi, group1) # %>% mutate(npi = as.character(npi))
write_tsv(taxid.base,'data/output/taxidbase.txt', append=FALSE, col_names=TRUE)
rm(taxid.base)


# Loading in 2012-2017 MD-PPAS data
for (y in 2012:2017) {
  ppas.data <- read_csv(paste0("data/input/MDPPAS/PhysicianData_", y, ".csv"))
  
  ppas.data <- ppas.data %>%
    select(Year, npi, pos_office, pos_opd, pos_asc, group1) %>%
    group_by(Year, npi) %>%
    mutate(pos_opd = ifelse(is.na(pos_opd), 0, pos_opd),
           pos_office = ifelse(is.na(pos_office), 0, pos_office),
           pos_asc = ifelse(is.na(pos_asc), 0, pos_asc),
           int = ifelse(pos_opd/(pos_opd+pos_office+pos_asc) >= 0.75, 1, 0)) %>%
    select(Year, npi, int, group1) %>%
    rename_with(tolower)
    
  assign(paste0("ppas.",y), ppas.data)
  rm(ppas.data)
}

# Appending MD-PPAS data from 2012-2017 together
ppas <- ppas.2012
rm(ppas.2012) 
for (y in 2013:2017) {
  ppas <- bind_rows(ppas, get(paste0("ppas.",y)))
}

# Removing redundant files so we can save some space in our working memory
rm(ppas.2013, ppas.2014, ppas.2015, ppas.2016, ppas.2017)

# Saving this file so we don't have to do all that again
write_tsv(ppas,'data/output/ppas.txt', append=FALSE, col_names=TRUE)

# Removing remaining files
rm(ppas)