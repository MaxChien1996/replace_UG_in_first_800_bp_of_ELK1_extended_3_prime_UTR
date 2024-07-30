library(tidyverse)
source("../4_pick sequences/choose_lowest_splicing_possibility.R")
source("../4_pick sequences/turn_FASTA_into_dataframe.R")





# 10 percent first replicate
CSV_of_10_percent_first_replicate <- "../3_splicing possibility of generated sequences/full_library_splice_site_probabilities_10_percent_first_replicate.csv.gz"
candidates_of_10_percent_first_replicate <- choose_lowest_splicing_possibility(CSV_of_10_percent_first_replicate)

insert_sequences_of_10_percent_first_replicate <- read_csv("../1_generate candidate sequences/output/insert_sequences_of_10_percent_first_replicate.csv") %>% 
  filter(candidates %in% candidates_of_10_percent_first_replicate) %>% 
  head(1)

oPools_2_of_10_percent_first_replicate <- turn_FASTA_into_dataframe("../1_generate candidate sequences/output/oPools_2_of_10_percent_first_replicate.fasta") %>% 
  filter(candidates %in% insert_sequences_of_10_percent_first_replicate$candidates) %>% 
  dplyr::rename(oPools_2_sequence = sequence)

oPools_3_of_10_percent_first_replicate <- turn_FASTA_into_dataframe("../1_generate candidate sequences/output/oPools_3_of_10_percent_first_replicate.fasta") %>% 
  filter(candidates %in% insert_sequences_of_10_percent_first_replicate$candidates) %>% 
  dplyr::rename(oPools_3_sequence = sequence)

portions_of_10_percent_first_replicate <- read_csv("../1_generate candidate sequences/output/portions_of_10_percent_first_replicate.csv") %>% 
  dplyr::rename(candidates = portion_replicate) %>% 
  filter(candidates %in% insert_sequences_of_10_percent_first_replicate$candidates)

df_10_percent_first_replicate <- left_join(insert_sequences_of_10_percent_first_replicate, oPools_2_of_10_percent_first_replicate) %>%
  left_join(oPools_3_of_10_percent_first_replicate) %>% 
  left_join(portions_of_10_percent_first_replicate) %>% 
  mutate(portion = "10%") %>% 
  mutate(replicate = "#1")



# 10 percent second and third replicates
CSV_of_10_percent_second_and_third_replicates <- "../3_splicing possibility of generated sequences/full_library_splice_site_probabilities_10_percent_second_and_third_replicates.csv.gz"
candidates_of_10_percent_second_and_third_replicates <- choose_lowest_splicing_possibility(CSV_of_10_percent_second_and_third_replicates)

insert_sequences_of_10_percent_second_and_third_replicates <- read_csv("../1_generate candidate sequences/output/insert_sequences_of_10_percent_second_and_third_replicates.csv") %>% 
  filter(candidates %in% candidates_of_10_percent_second_and_third_replicates) %>% 
  head(2)

oPools_2_of_10_percent_second_and_third_replicates <- turn_FASTA_into_dataframe("../1_generate candidate sequences/output/oPools_2_of_10_percent_second_and_third_replicates.fasta") %>% 
  filter(candidates %in% insert_sequences_of_10_percent_second_and_third_replicates$candidates) %>% 
  dplyr::rename(oPools_2_sequence = sequence)

oPools_3_of_10_percent_second_and_third_replicates <- turn_FASTA_into_dataframe("../1_generate candidate sequences/output/oPools_3_of_10_percent_second_and_third_replicates.fasta") %>% 
  filter(candidates %in% insert_sequences_of_10_percent_second_and_third_replicates$candidates) %>% 
  dplyr::rename(oPools_3_sequence = sequence)

portions_of_10_percent_second_and_third_replicates <- read_csv("../1_generate candidate sequences/output/portions_of_10_percent_second_and_third_replicates.csv") %>% 
  dplyr::rename(candidates = portion_replicate) %>% 
  filter(candidates %in% insert_sequences_of_10_percent_second_and_third_replicates$candidates)

df_10_percent_second_and_third_replicates <- left_join(insert_sequences_of_10_percent_second_and_third_replicates, oPools_2_of_10_percent_second_and_third_replicates) %>%
  left_join(oPools_3_of_10_percent_second_and_third_replicates) %>% 
  left_join(portions_of_10_percent_second_and_third_replicates) %>% 
  mutate(portion = "10%") %>% 
  mutate(i = 2:3) %>% 
  mutate(replicate = paste0("#", i)) %>% 
  select(-i)



# 25 percent first replicate
CSV_of_25_percent_first_replicate <- "../3_splicing possibility of generated sequences/full_library_splice_site_probabilities_25_percent_first_replicate.csv.gz"
candidates_of_25_percent_first_replicate <- choose_lowest_splicing_possibility(CSV_of_25_percent_first_replicate)

insert_sequences_of_25_percent_first_replicate <- read_csv("../1_generate candidate sequences/output/insert_sequences_of_25_percent_first_replicate.csv") %>% 
  filter(candidates %in% candidates_of_25_percent_first_replicate) %>% 
  head(1)

oPools_2_of_25_percent_first_replicate <- turn_FASTA_into_dataframe("../1_generate candidate sequences/output/oPools_2_of_25_percent_first_replicate.fasta") %>% 
  filter(candidates %in% insert_sequences_of_25_percent_first_replicate$candidates) %>% 
  dplyr::rename(oPools_2_sequence = sequence)

oPools_3_of_25_percent_first_replicate <- turn_FASTA_into_dataframe("../1_generate candidate sequences/output/oPools_3_of_25_percent_first_replicate.fasta") %>% 
  filter(candidates %in% insert_sequences_of_25_percent_first_replicate$candidates) %>% 
  dplyr::rename(oPools_3_sequence = sequence)

portions_of_25_percent_first_replicate <- read_csv("../1_generate candidate sequences/output/portions_of_25_percent_first_replicate.csv") %>% 
  dplyr::rename(candidates = portion_replicate) %>% 
  filter(candidates %in% insert_sequences_of_25_percent_first_replicate$candidates)

df_25_percent_first_replicate <- left_join(insert_sequences_of_25_percent_first_replicate, oPools_2_of_25_percent_first_replicate) %>% 
  left_join(oPools_3_of_25_percent_first_replicate) %>% 
  left_join(portions_of_25_percent_first_replicate) %>% 
  mutate(portion = "25%") %>% 
  mutate(replicate = "#1")



# 25 percent second and third replicates
CSV_of_25_percent_second_and_third_replicates <- "../3_splicing possibility of generated sequences/full_library_splice_site_probabilities_25_percent_second_and_third_replicates.csv.gz"
candidates_of_25_percent_second_and_third_replicates <- choose_lowest_splicing_possibility(CSV_of_25_percent_second_and_third_replicates)

insert_sequences_of_25_percent_second_and_third_replicates <- read_csv("../1_generate candidate sequences/output/insert_sequences_of_25_percent_second_and_third_replicates.csv") %>% 
  filter(candidates %in% candidates_of_25_percent_second_and_third_replicates) %>% 
  head(2)

oPools_2_of_25_percent_second_and_third_replicates <- turn_FASTA_into_dataframe("../1_generate candidate sequences/output/oPools_2_of_25_percent_second_and_third_replicates.fasta") %>% 
  filter(candidates %in% insert_sequences_of_25_percent_second_and_third_replicates$candidates) %>% 
  dplyr::rename(oPools_2_sequence = sequence)

oPools_3_of_25_percent_second_and_third_replicates <- turn_FASTA_into_dataframe("../1_generate candidate sequences/output/oPools_3_of_25_percent_second_and_third_replicates.fasta") %>% 
  filter(candidates %in% insert_sequences_of_25_percent_second_and_third_replicates$candidates) %>% 
  dplyr::rename(oPools_3_sequence = sequence)

portions_of_25_percent_second_and_third_replicates <- read_csv("../1_generate candidate sequences/output/portions_of_25_percent_second_and_third_replicates.csv") %>% 
  dplyr::rename(candidates = portion_replicate) %>% 
  filter(candidates %in% insert_sequences_of_25_percent_second_and_third_replicates$candidates)

df_25_percent_second_and_third_replicates <- left_join(insert_sequences_of_25_percent_second_and_third_replicates, oPools_2_of_25_percent_second_and_third_replicates) %>% 
  left_join(oPools_3_of_25_percent_second_and_third_replicates) %>% 
  left_join(portions_of_25_percent_second_and_third_replicates) %>% 
  mutate(portion = "25%") %>% 
  mutate(i = 2:3) %>% 
  mutate(replicate = paste0("#", i)) %>% 
  select(-i)



# 50 percent first replicate
CSV_of_50_percent_first_replicate <- "../3_splicing possibility of generated sequences/full_library_splice_site_probabilities_50_percent_first_replicate.csv.gz"
candidates_of_50_percent_first_replicate <- choose_lowest_splicing_possibility(CSV_of_50_percent_first_replicate)

insert_sequences_of_50_percent_first_replicate <- read_csv("../1_generate candidate sequences/output/insert_sequences_of_50_percent_first_replicate.csv") %>% 
  filter(candidates %in% candidates_of_50_percent_first_replicate) %>% 
  head(1)

oPools_2_of_50_percent_first_replicate <- turn_FASTA_into_dataframe("../1_generate candidate sequences/output/oPools_2_of_50_percent_first_replicate.fasta") %>% 
  filter(candidates %in% insert_sequences_of_50_percent_first_replicate$candidates) %>% 
  dplyr::rename(oPools_2_sequence = sequence)

oPools_3_of_50_percent_first_replicate <- turn_FASTA_into_dataframe("../1_generate candidate sequences/output/oPools_3_of_50_percent_first_replicate.fasta") %>% 
  filter(candidates %in% insert_sequences_of_50_percent_first_replicate$candidates) %>% 
  dplyr::rename(oPools_3_sequence = sequence)

portions_of_50_percent_first_replicate <- read_csv("../1_generate candidate sequences/output/portions_of_50_percent_first_replicate.csv") %>% 
  dplyr::rename(candidates = portion_replicate) %>% 
  filter(candidates %in% insert_sequences_of_50_percent_first_replicate$candidates)

df_50_percent_first_replicate <- left_join(insert_sequences_of_50_percent_first_replicate, oPools_2_of_50_percent_first_replicate) %>% 
  left_join(oPools_3_of_50_percent_first_replicate) %>% 
  left_join(portions_of_50_percent_first_replicate) %>% 
  mutate(portion = "50%") %>% 
  mutate(replicate = "#1")



# 50 percent second and third replicates
CSV_of_50_percent_second_and_third_replicates <- "../3_splicing possibility of generated sequences/full_library_splice_site_probabilities_50_percent_second_and_third_replicates.csv.gz"
candidates_of_50_percent_second_and_third_replicates <- choose_lowest_splicing_possibility(CSV_of_50_percent_second_and_third_replicates)

insert_sequences_of_50_percent_second_and_third_replicates <- read_csv("../1_generate candidate sequences/output/insert_sequences_of_50_percent_second_and_third_replicates.csv") %>% 
  filter(candidates %in% candidates_of_50_percent_second_and_third_replicates) %>% 
  head(2)

oPools_2_of_50_percent_second_and_third_replicates <- turn_FASTA_into_dataframe("../1_generate candidate sequences/output/oPools_2_of_50_percent_second_and_third_replicates.fasta") %>% 
  filter(candidates %in% insert_sequences_of_50_percent_second_and_third_replicates$candidates) %>% 
  dplyr::rename(oPools_2_sequence = sequence)

oPools_3_of_50_percent_second_and_third_replicates <- turn_FASTA_into_dataframe("../1_generate candidate sequences/output/oPools_3_of_50_percent_second_and_third_replicates.fasta") %>% 
  filter(candidates %in% insert_sequences_of_50_percent_second_and_third_replicates$candidates) %>% 
  dplyr::rename(oPools_3_sequence = sequence)

portions_of_50_percent_second_and_third_replicates <- read_csv("../1_generate candidate sequences/output/portions_of_50_percent_second_and_third_replicates.csv") %>% 
  dplyr::rename(candidates = portion_replicate) %>% 
  filter(candidates %in% insert_sequences_of_50_percent_second_and_third_replicates$candidates)

df_50_percent_second_and_third_replicates <- left_join(insert_sequences_of_50_percent_second_and_third_replicates, oPools_2_of_50_percent_second_and_third_replicates) %>% 
  left_join(oPools_3_of_50_percent_second_and_third_replicates) %>% 
  left_join(portions_of_50_percent_second_and_third_replicates) %>% 
  mutate(portion = "50%") %>% 
  mutate(i = 2:3) %>% 
  mutate(replicate = paste0("#", i)) %>% 
  select(-i)



# 100 percent three replicates
CSV_of_100_percent_three_replicates <- "../3_splicing possibility of generated sequences/full_library_splice_site_probabilities_100_percent_three_replicates.csv.gz"
candidates_of_100_percent_three_replicates <- choose_lowest_splicing_possibility(CSV_of_100_percent_three_replicates)

insert_sequences_of_100_percent_three_replicates <- read_csv("../1_generate candidate sequences/output/insert_sequences_of_100_percent_three_replicates.csv") %>% 
  filter(candidates %in% candidates_of_100_percent_three_replicates) %>% 
  head(3)

oPools_2_of_100_percent_three_replicates <- turn_FASTA_into_dataframe("../1_generate candidate sequences/output/oPools_2_of_100_percent_three_replicates.fasta") %>% 
  filter(candidates %in% insert_sequences_of_100_percent_three_replicates$candidates) %>% 
  dplyr::rename(oPools_2_sequence = sequence)

oPools_3_of_100_percent_three_replicates <- turn_FASTA_into_dataframe("../1_generate candidate sequences/output/oPools_3_of_100_percent_three_replicates.fasta") %>% 
  filter(candidates %in% insert_sequences_of_100_percent_three_replicates$candidates) %>% 
  dplyr::rename(oPools_3_sequence = sequence)

portions_of_100_percent_three_replicates <- read_csv("../1_generate candidate sequences/output/portions_of_100_percent_three_replicates.csv") %>% 
  dplyr::rename(candidates = portion_replicate) %>% 
  filter(candidates %in% insert_sequences_of_100_percent_three_replicates$candidates)

df_100_percent_three_replicates <- left_join(insert_sequences_of_100_percent_three_replicates, oPools_2_of_100_percent_three_replicates) %>% 
  left_join(oPools_3_of_100_percent_three_replicates) %>% 
  left_join(portions_of_100_percent_three_replicates) %>% 
  mutate(portion = "100%") %>% 
  mutate(i = 1:3) %>% 
  mutate(replicate = paste0("#", i)) %>% 
  select(-i)



# combine all data frames
df <- bind_rows(df_10_percent_first_replicate, df_10_percent_second_and_third_replicates, df_25_percent_first_replicate, df_25_percent_second_and_third_replicates, df_50_percent_first_replicate, df_50_percent_second_and_third_replicates, df_100_percent_three_replicates) %>% 
  select(-candidates) %>% 
  select(portion, replicate, portions, everything())

write_csv(df, "selected_sequences.csv")
