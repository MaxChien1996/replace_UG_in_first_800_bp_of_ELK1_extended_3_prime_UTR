library(tidyverse)



selected_sequences <- read_csv("../4_pick sequences/selected_sequences.csv")

upstream_ELK1_3_prime_UTR <- "CAAAAGACTCCTGGGCTCACCTGTTAGCGCTGGCCCAGCCCAGGCCTTGGGACCTGGGGGTTGGTGATTTGGGGGACAGTGCTACACTCGTCTCCACTGTTTGTTTTACTTCCCCAAAATGGACCTTTTTTTTTTCTAAAGAGTCCCAGAGAATGGGGAATTGTTCCTGTAAATATATATTTTTCAAAGTGA"

# sequence from "../1_generate candidate sequences/1.2_UG_removed_upstream_ELK1_3_prime_UTR.ipynb"
UG_removed_upstream_ELK1_3_prime_UTR <- "CAAAAGACTCCTGGGCTCACCTGTTAGCGCCAGCCCAGCCCAGGCCTCCGGACCCAGGGGTAAGCAATTCAGGGGACAGCCCTACACTCGTCTCCACTATTACTTTTACTTCCCCAAAAGCGACCTTTTTTTTTTCTAAAGAGTCCCAGAGAAACGGGAATAATTCCCATAAATATATATTTTTCAAAGCAA"

# the overlapping region between oPools_1 and oPools_2 is "linker_6_7_two"
linker_6_7_two = "AAACAATAGTAGGGACTGCATATCGGTA"



df_with_UG_removed_upstream_ELK1_3_prime_UTR <- selected_sequences %>% 
  mutate(oPools_1_with_UG_removed_upstream_ELK1_3_prime_UTR = str_replace(oPools_1_sequence, upstream_ELK1_3_prime_UTR, UG_removed_upstream_ELK1_3_prime_UTR)) %>% 
  select(-oPools_1_sequence) %>% 
  mutate(sequence = paste0(str_remove(oPools_1_with_UG_removed_upstream_ELK1_3_prime_UTR, linker_6_7_two), oPools_2_sequence)) %>%
  select(portion, replicate, portions, sequence, oPools_1_with_UG_removed_upstream_ELK1_3_prime_UTR, everything()) %>% 
  dplyr::rename(oPools_1_sequence = oPools_1_with_UG_removed_upstream_ELK1_3_prime_UTR) %>% 
  mutate(remove_UG_in_upstream_ELK1_3_prime_UTR = TRUE)





# sequences of manually add UG in truncated extended 3'-UTR
extra_UG_oPools_1 <- "CAAAAGACTCCTGGGCTCACCTGTTAGCGCTGGCCCAGCCCAGGCCTTGGGACCTGGGGGTTGGTGATTTGGGGGACAGTGCTACACTCGTCTCCACTGTTTGTTTTACTTCCCCAAAATGGACCTTTTTTTTTTCTAAAGAGTCCCAGAGAATGGGGAATTGTTCCTGTAAATATATATTTTTCAAAGTGATGCTGTGGGCTGCTGGTGTGTTTTGTGTGATGTTGTGTGTGTGTGCTGTGCGTGGCTGGCATGTGTGTGTGTGTGGGGTGTGTGGCTGTGTGCTGTTGTGTGTGAATGGGTGTGATGGCGTGTGTGTGAAACAATAGTAGGGACTGCATATCGGTA"
extra_UG_oPools_2 <- "AAACAATAGTAGGGACTGCATATCGGTATGTGTGTGTGTGTGTGTGTGGTGTGATGCTGTGATTGTGTGTGTGTGTGTGTGTGTGTTGTGTGTGTGTGTGTTTGATGGTGTGTGTATGTGGTGAATTGTGGCTGTGTTTGTGAAAATAACTGTGCCTGTGTGAATTGTGATGTGTGTGTTGAATGTGCTGTGATGTGATGTGTGAAATAATGTGTACGAGAAGGGAACGGGGACTGCAGCCCT"
extra_UG_whole_sequence <- paste0(str_remove(extra_UG_oPools_1, linker_6_7_two), extra_UG_oPools_2)





# create the whole data frame
df_all <- bind_rows(selected_sequences, df_with_UG_removed_upstream_ELK1_3_prime_UTR) %>% 
  mutate(remove_UG_in_upstream_ELK1_3_prime_UTR = ifelse(is.na(remove_UG_in_upstream_ELK1_3_prime_UTR), FALSE, remove_UG_in_upstream_ELK1_3_prime_UTR)) %>% 
  rbind(list(portion = "200%", 
            replicate = "", 
            portions = "", 
            sequence = extra_UG_whole_sequence, 
            oPools_1_sequence = extra_UG_oPools_1, 
            oPools_2_sequence = extra_UG_oPools_2, 
            remove_UG_in_upstream_ELK1_3_prime_UTR = FALSE))





ELK1_oPools_1 <- df_all %>% 
  select(-sequence, -oPools_2_sequence) %>% 
  dplyr::rename(Sequence = oPools_1_sequence) %>% 
  mutate(`Pool name` = "ELK1_oPools_1") %>% 
  select(`Pool name`, Sequence, everything())

ELK1_oPools_2 <- df_all %>% 
  select(-sequence, -oPools_1_sequence) %>% 
  dplyr::rename(Sequence = oPools_2_sequence) %>% 
  mutate(`Pool name` = "ELK1_oPools_2") %>% 
  select(`Pool name`, Sequence, everything())

write_csv(ELK1_oPools_1, "ELK1_oPools_1.csv")
write_csv(ELK1_oPools_2, "ELK1_oPools_2.csv")
