library(tidyverse)
library(Rsamtools)



CSV_files_of_barcode_and_PAS_site <- Sys.glob("/Users/jeanz/GitHub/replace_UG_in_first_800_bp_of_ELK1_extended_3_prime_UTR/9_analyse results from minION with Flow Cell (R10.4.1)/*.csv.gz")
for (i in 1:length(CSV_files_of_barcode_and_PAS_site)) {
  
  file_path <- CSV_files_of_barcode_and_PAS_site[i]
  CSV_file_name <- sub("\\.csv\\.gz$", "", basename(file_path))
  
  barcode_and_PAS_site <- read_csv(CSV_files_of_barcode_and_PAS_site[i]) %>% 
    mutate(file_name = CSV_file_name)
  
  if (i == 1) {
    ALL_barcode_and_PAS_site <- barcode_and_PAS_site
  } else {
    ALL_barcode_and_PAS_site <- bind_rows(ALL_barcode_and_PAS_site, barcode_and_PAS_site)
  }
}

barcode_insert_pair <- read_csv("/Users/jeanz/GitHub/replace_UG_in_first_800_bp_of_ELK1_extended_3_prime_UTR/8_get each insert corresponding barcodes by Nanopore sequencing 10_P_1 library/barcode_insert_library.csv.gz") %>% 
  dplyr::rename(insert = rname) %>% 
  select(-read_counts)
each_insert_UG_remain <- read_csv("/Users/jeanz/GitHub/replace_UG_in_first_800_bp_of_ELK1_extended_3_prime_UTR/6_potential combination after Gibson assembly/CSV_file_of_potential_combination_of_inserts.csv") %>% 
  dplyr::rename(insert = name) %>% 
  select(insert, portion_of_UG_remained) %>% 
  mutate(portion_of_UG_remained = as.numeric(sub("%", "", portion_of_UG_remained)))



BAM_files <- Sys.glob("/Volumes/lab-frattap/home/users/jeanz/Nanopore_sequencing/ELK1_UG_replaced_library_in_Dox_curve/*.sorted.bam")

extract_cryptic_PAS_ratio <- function(BAM_file_path){
  
  BAM_file_name <- sub("\\.sorted\\.bam$", "", basename(BAM_file_path))
  
  print(paste("start processing", BAM_file_name))
  
  barcode_and_PAS_site <- ALL_barcode_and_PAS_site %>% 
    filter(file_name == BAM_file_name) %>% 
    select(-file_name)
  
  
  
  df_1 <- data.frame(scanBam(BAM_file_path))
  
  df_2 <- df_1 %>% 
    filter(mapq > 0) %>% # mapq: mapping quality score
    
    filter(flag < 256) %>% # if flag >= 256, it means "not primary alignment"
    filter(flag != 4) %>% # if flag is 4, it means "read unmapped"
    
    filter(pos > 650) %>% 
    filter(pos < 724) %>% 
    filter(qwidth > 1000) %>% 
    
    select(qname, rname, qwidth)
  
  df_3 <- df_2 %>% 
    left_join(barcode_and_PAS_site, by = c("qname" = "query_name")) %>% 
    filter(!is.na(barcode) & !is.na(PAS))
  
  df_4 <- df_3 %>% 
    left_join(barcode_insert_pair, by = "barcode") %>% 
    dplyr::rename(PAS_begin = PAS) %>% 
    filter(!is.na(insert)) %>% 
    
    mutate(rname_by_insert = sub("---.*", "", insert)) %>% 
    filter(rname == rname_by_insert) %>% 
    select(-rname_by_insert, -rname) %>% 
    
    # check each read belong to which PAS site
    mutate(PAS = ifelse(PAS_begin > 2000, ifelse(PAS_begin < 2100, "canonical", NA), NA )) %>% 
    mutate(PAS = ifelse(PAS_begin > 3025, ifelse(PAS_begin < 3125, "cryptic", PAS), PAS)) %>% 
    filter(!is.na(PAS)) %>% 
    # not only use PAS site to determine PAS, but also use read length QC it
    filter(ifelse(PAS == "canonical", ifelse(qwidth >= 1300, ifelse(qwidth <= 1550, TRUE , FALSE), FALSE), ifelse(qwidth >= 2350, ifelse(qwidth <= 2600, TRUE, FALSE), FALSE))) %>% 
    select(-qwidth, -PAS_begin)
  
  df_5 <- df_4 %>% 
    # calculate how many reads of each barcode get
    group_by(barcode, PAS, insert) %>% 
    mutate(n = n()) %>% 
    ungroup() %>% 
    select(-qname) %>% 
    unique()
  
  df_6 <- df_5 %>% 
    select(-barcode) %>% 
    group_by(insert, PAS) %>% 
    mutate(count = sum(n)) %>% 
    ungroup() %>% 
    select(-n) %>% 
    unique() %>% 
    pivot_wider(names_from = PAS, values_from = count) %>% 
    mutate(ratio = cryptic / (canonical + cryptic))
  
  df_7 <- df_6 %>% 
    left_join(each_insert_UG_remain, by = "insert") %>% 
    mutate(oPools_1 = sub("---.*", "", insert))
  
  
  
  return(df_7)
}

for (i in 1:length(BAM_files)){
  
  BAM_file_path <- BAM_files[i]
  BAM_file_name <- sub("\\.sorted\\.bam$", "", basename(BAM_file_path))
  
  df <- extract_cryptic_PAS_ratio(BAM_files[i])
  df <- df %>% 
    mutate(barcode = BAM_file_name)
  
  if (i == 1) {
    all_df <- df
  } else {
    all_df <- bind_rows(all_df, df)
  }
  
}



x <- all_df %>% 
  
  filter(canonical > 1 & cryptic > 1) %>% 
  
  select(-canonical, -cryptic) %>% 
  #group_by(barcode, oPools_1, portion_of_UG_remained) %>%
  #mutate(mean_ratio = mean(ratio)) %>% 
  #ungroup() %>%
  mutate(portion_of_UG_remained = as.factor(as.numeric(portion_of_UG_remained))) %>% 
  
  # reordering insert based on portion_of_UG_remained
  arrange(portion_of_UG_remained) %>%
  mutate(insert = factor(insert, levels = unique(insert[order(portion_of_UG_remained)])))

ggplot(x %>% 
         filter(oPools_1 == "wild_type"))+ 
  geom_tile(aes(x = barcode, y = insert, fill = ratio))
