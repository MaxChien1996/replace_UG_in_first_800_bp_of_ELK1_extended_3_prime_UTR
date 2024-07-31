library(tidyverse)



# oPools_1 only contains upstream ELK1 3'-UTR

# wild type upstream ELK1 3'-UTR is the oPools_1 in the "../1_generate candidate sequences/oPool_regions.py"
wild_type <- "CAAAAGACTCCTGGGCTCACCTGTTAGCGCTGGCCCAGCCCAGGCCTTGGGACCTGGGGGTTGGTGATTTGGGGGACAGTGCTACACTCGTCTCCACTGTTTGTTTTACTTCCCCAAAATGGACCTTTTTTTTTTCTAAAGAGTCCCAGAGAATGGGGAATTGTTCCTGTAAATATATATTTTTCAAAGTGA"

# sequence from "../1_generate candidate sequences/1.2_UG_removed_upstream_ELK1_3_prime_UTR.ipynb"
UG_removed <- "CAAAAGACTCCTGGGCTCACCTGTTAGCGCACGCCCAGCCCAGGCCTAGGGACCAAGGGGTACGCAATTCGGGGGACAGCTCTACACTCGTCTCCACACTTTTTTTTACTTCCCCAAAAGCGACCTTTTTTTTTTCTAAAGAGTCCCAGAGAATCGGGAATTCTTCCTGTAAATATATATTTTTCAAAGTGA"

oPools_1 <- data_frame(
  `Pool name` = "ELK1_oPools_1", 
  oPools_1_sequence = c(wild_type, UG_removed), 
  sequence_name = c("wild_type", "UG_removed")
)





# extra UG version from:
# ~OneDrive-UniversityCollegeLondon/Lab note
# /PhD/2024.06.17_Put a 15-mer barcode right after mGreenLantern and start removing UG in ELK1 extended 3 prime-UTR
# /manually add more UG.dna
extra_UG_oPools_2 <- "TCCTGTAAATATATATTTTTCAAAGTGATGCTGTGGGCTGCTGGTGTGTTTTGTGTGATGTTGTGTGTGTGTGCTGTGCGTGGCTGGCATGTGTGTGTGTGTGGGGTGTGTGGCTGTGTGCTGTTGTGTGTGAATGGGTGTGATGGCGTGTGTGTGAAACAATAGTAGGGACTGCATATCGGTA"
extra_UG_oPools_3 <- "AAACAATAGTAGGGACTGCATATCGGTATGTGTGTGTGTGTGTGTGTGGTGTGATGCTGTGATTGTGTGTGTGTGTGTGTGTGTGTTGTGTGTGTGTGTGTTTGATGGTGTGTGTATGTGGTGAATTGTGGCTGTGTTTGTGAAAATAACTGTGCCTGTGTGAATTGTGATGTGTGTGTTGAATGTGCTGTGATGTGATGTGTGAAATAATGTGTACGAGAAGGGAACGGGGACTGCAGCCCT"

Gibson_assembly_overlapping_oPools_1_2 = "TCCTGTAAATATATATTTTTCAAAGTGA"
Gibson_assembly_overlapping_oPools_2_3 = "AAACAATAGTAGGGACTGCATATCGGTA"

extra_UG_whole_sequence <- paste0(str_remove(wild_type, Gibson_assembly_overlapping_oPools_1_2), 
                                  str_remove(extra_UG_oPools_2, Gibson_assembly_overlapping_oPools_2_3), 
                                  extra_UG_oPools_3)

selected_sequences <- read_csv("../4_pick sequences/selected_sequences.csv") %>% 
  # add the extra UG sequence
  rbind(list(portion = "200%", 
             replicate = "", 
             portions = "", 
             sequence = extra_UG_whole_sequence, 
             oPools_2_sequence = extra_UG_oPools_2, 
             oPools_3_sequence = extra_UG_oPools_3))





oPools_2 <- selected_sequences %>% 
  mutate(`Pool name` = "ELK1_oPools_2") %>% 
  mutate(sequence_name = paste0(portion, "_", replicate)) %>% 
  mutate(sequence_name = ifelse(sequence_name == "200%_", "200%_#1", sequence_name)) %>%
  select(`Pool name`, oPools_2_sequence, sequence_name) %>% 
  unique()

oPools_3 <- selected_sequences %>% 
  mutate(`Pool name` = "ELK1_oPools_3") %>% 
  mutate(sequence_name = paste0(portion, "_", replicate)) %>% 
  mutate(sequence_name = ifelse(sequence_name == "200%_", "200%_#1", sequence_name)) %>% 
  # because 10%___#1 is the same as 25%___#1
  mutate(sequence_name = ifelse(sequence_name == "10%_#1", "10%_25%_#1", sequence_name)) %>% 
  mutate(sequence_name = ifelse(sequence_name == "25%_#1", "10%_25%_#1", sequence_name)) %>%
  select(`Pool name`, oPools_3_sequence, sequence_name) %>% 
  unique()





# write a CSV file for ordering the oPools
write_csv(oPools_1, "ELK1_oPools_1.csv")
write_csv(oPools_2, "ELK1_oPools_2.csv")
write_csv(oPools_3, "ELK1_oPools_3.csv")
