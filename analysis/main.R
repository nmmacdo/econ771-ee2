# Title: Assignment 2 Analysis (main.R)
# Project: assignment-2-and-data
# Author: Noah MacDonald
# Date Created: October 16, 2022
# Last Edited: October 16, 2022

# Loading required packages
if (!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse, modelsummary)

# Reading in data
taxid.base <- read_tsv("data/output/taxidbase.txt")
ppas.data <- read_tsv("data/output/ppas.txt")
puf.data <- read_tsv("data/output/puf.txt")
pfs.data <- read_tsv("data/input/PFS_update_data.txt")

### Question 1 ----------------------------------------------------------------

# Creating a table of summary statistics
MD.dat <- puf.data %>%
  group_by(npi) %>%
  summarise(total_spending = sum(total_spending),
         total_claims = sum(total_claims),
         total_patients = sum(total_patients))

tab1 <- datasummary(total_spending + total_claims + total_patients ~ 
                      Mean + SD + Min + Max, data = MD.dat, output = 'latex')

