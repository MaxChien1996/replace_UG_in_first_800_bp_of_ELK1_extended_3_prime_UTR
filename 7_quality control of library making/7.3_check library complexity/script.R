library(tidyverse)
library(Rsamtools)
library(here)



setwd(here())

path_of_filter_10_P_0 <- "7_quality control of library making/7.2_align_to_potential_combination/filter_10_P_0.sorted.bam"
path_of_filter_10_P_1 <- "7_quality control of library making/7.2_align_to_potential_combination/filter_10_P_1.sorted.bam"
path_of_filter_10_P_2 <- "7_quality control of library making/7.2_align_to_potential_combination/filter_10_P_2.sorted.bam"



read_BAM_file_in_and_filter_it <- function(path){
  
  df <- data.frame(scanBam(path)) %>% 
    filter(flag < 256) %>% # if flag >= 256, it means "not primary alignment"
    filter(flag != 4) # if flag is 4, it means "read unmapped"
  
  return(df)
  
}



filter_10_P_0 <- read_BAM_file_in_and_filter_it(path_of_filter_10_P_0)
filter_10_P_1 <- read_BAM_file_in_and_filter_it(path_of_filter_10_P_1)
filter_10_P_2 <- read_BAM_file_in_and_filter_it(path_of_filter_10_P_2)



check_unique_combination <- function(df){
  
  df <- df %>% 
    group_by(rname) %>% 
    mutate(n = n()) %>% 
    select(rname, n) %>% 
    unique() %>% 
    arrange(desc(n))
  
  return(df)
  
}



Comb_filter_10_P_0 <- check_unique_combination(filter_10_P_0)
Comb_filter_10_P_1 <- check_unique_combination(filter_10_P_1)
Comb_filter_10_P_2 <- check_unique_combination(filter_10_P_2)
