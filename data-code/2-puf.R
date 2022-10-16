# Title: Collecting PUF data
# Project: assignment-2-and-data
# Author: Noah MacDonald
# Date Created: October 16, 2022
# Last Edited: October 16, 2022

# Loading required packages
if (!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse)

# Loading in PUF data from 2012-2017
for (y in 2012:2017) {
puf.data <- read_tsv(paste0("data/input/PUF/", 
                           "Medicare_Provider_Util_Payment_PUF_CY", 
                           y, ".txt"))
puf.data <- puf.data %>% 
  rename_with(tolower) %>%
  select(npi, nppes_credentials, average_medicare_allowed_amt, line_srvc_cnt, 
         bene_unique_cnt, hcpcs_code) %>%
  filter(!is.na(hcpcs_code)) %>%
  filter(nppes_credentials == "M.D." | nppes_credentials == "MD") %>%
  mutate(total_spending = average_medicare_allowed_amt*line_srvc_cnt,
         total_claims = line_srvc_cnt,
         total_patients = bene_unique_cnt,
         year = y) %>%
  select(npi, hcpcs_code, year, total_spending, total_claims, total_patients)

  assign(paste0("puf.", y), puf.data)
  rm(puf.data)
}

# Appending PUF data from 2012-2017 together
puf <- puf.2012
rm(puf.2012) 
for (y in 2013:2017) {
  puf <- bind_rows(puf, get(paste0("puf.",y)))
}

# Removing redundant files so we can save some space in our working memory
rm(puf.2013, puf.2014, puf.2015, puf.2016, puf.2017)

# Saving this file so we don't have to do all that again
write_tsv(puf,'data/output/puf.txt', append=FALSE, col_names=TRUE)

# Removing remaining files
rm(puf)