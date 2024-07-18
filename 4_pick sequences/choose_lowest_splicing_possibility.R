choose_lowest_splicing_possibility <- function(CSV_file_path){
  
  library(tidyverse)
  
  
  
  
  original_sequence_splicing_possibility <- read_csv("../2_SpliceAI prediction of original sequence/original_sequence_splicing_possibility.csv.gz") %>% 
    mutate(prob = ifelse(acceptor_prob > donor_prob, acceptor_prob, donor_prob)) %>% 
    mutate(No = paste0(No)) %>% 
    filter(prob > 0.01)
  
  highly_possible_splice_site_positions_of_original_sequence <- original_sequence_splicing_possibility$nt_pos
  
  
  
  
  
  full_library_splice_site_probabilities <- read_csv(CSV_file_path)
  
  df_1 <- full_library_splice_site_probabilities %>% 
    #mutate(prob = ifelse(acceptor_prob > donor_prob, acceptor_prob, donor_prob)) %>%  # the probability of the nucleotide becoming splice site
    mutate(No = paste0(No))
  
  
  
  # remove the candidate has more "highly possible splice sites" than the original sequence
  df_2 <- df_1 %>% 
    #filter(prob > 0.01) %>% 
    group_by(No) %>% 
    filter(n() > length(highly_possible_splice_site_positions_of_original_sequence))
  
  list_df_2 <- unique(df_2$No)
  
  
  
  # 
  df_3 <- df_1 %>% 
    filter(nt_pos %in% highly_possible_splice_site_positions_of_original_sequence) %>% 
    #dplyr::select(-acceptor_prob, -donor_prob) %>%
    pivot_wider(names_from = nt_pos, values_from = prob) %>% 
    filter(`2`>= 0.02749825 | 
             `306` >= 0.01252290 | 
             `335` >= 0.04010332 | 
             `449` >= 0.01699433 | 
             `909` >= 0.08304509 | 
             `986` >= 0.01743731 | 
             `1148` >= 0.05660611 | 
             `2857` >= 0.01971377)
  
  list_df_3 <- unique(df_3$No)
  
  
  candidates_preserved <- df_1 %>% 
    filter(! No %in% list_df_2) %>%
    filter(! No %in% list_df_3)
  
  list_of_candidates_preserved <- unique(candidates_preserved$No)

  return(list_of_candidates_preserved)
}
