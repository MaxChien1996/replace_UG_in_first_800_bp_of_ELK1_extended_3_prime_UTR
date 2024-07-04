library(tidyverse)



full_library_splice_site_probabilities <- read_csv("~/GitHub/replace_UG_in_first_800_bp_of_ELK1_extended_3_prime_UTR/3_/full_library_splice_site_probabilities.csv.gz")
# acceptor_prob: the probability of the splicing acceptor
# donor_prob: the probability of the splicing donor
# nt_pos: the position of the nucleotide in the sequence; position number 0 is the first nucleotide of the sequence








df_1 <- full_library_splice_site_probabilities %>% 
  mutate(prob = ifelse(acceptor_prob > donor_prob, acceptor_prob, donor_prob)) %>%  # the probability of the nucleotide becoming splice site
  mutate(No = paste0(No))
  
ggplot(df_1, aes(nt_pos, No)) + 
  geom_tile(aes(fill = prob)) + 
  scale_fill_viridis_c()


df_2 <- df_1 %>% 
  filter(prob > 0.01)

ggplot(df_2, aes(nt_pos, No)) + 
geom_tile(aes(fill = prob)) + 
scale_fill_viridis_c()
