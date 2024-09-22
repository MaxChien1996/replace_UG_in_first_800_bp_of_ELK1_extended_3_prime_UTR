library(tidyverse)
library(here)



setwd(here())

library_10_P_1 <- read_csv("7_quality control of library making/7.5_check barcode complexity of 10_P_1 library/10_P_1_barcodes.csv") %>% 
  group_by(barcode) %>% 
  mutate(n = n()) %>% 
  ungroup() %>% 
  select(barcode, n) %>% 
  unique() %>% 
  arrange(desc(n))

library_10_P_2 <- read_csv("7_quality control of library making/7.5_check barcode complexity of 10_P_1 library/10_P_2_barcodes.csv") %>% 
  group_by(barcode) %>% 
  mutate(n = n()) %>% 
  ungroup() %>% 
  select(barcode, n) %>% 
  unique() %>% 
  arrange(desc(n))










# unique barcodes are detected in the 10_P_1
n  <- as.numeric(nrow(library_10_P_1))
# barcodes are detected twice in the 10_P_1
barcode_detected_twice <- as.numeric(sum(library_10_P_1$n == 2))



# create a data frame simulate correlation between the library size and the number of barcodes detected twice
# the library size is the number of unique barcodes in the 10_P_1
df <- data_frame(library_size = numeric(), detected_twice = numeric())

# assume the size is "x"
# "n" means how many times I conduct the detection
for (x in n:5000){
  
  # question will be: 
  # when the library size is "x", and I conduct the detection "n" times
  # how many barcodes would be detected twice?
  answer <- n - mean(replicate(3000, length(unique(sample(1:x, n, replace = T)))))
    # "sample()": takes a sample of the specified size elements
    # "replace = T": sampling with replacement, mean that the same element can be selected more than once
    # because in the 10_P_1, the plasmid containing barcode can exist more than one molecule
    # "replicate()": repeat the same function multiple times, in this case 100 times
  
  df <- add_row(df, library_size = x , detected_twice = answer)
}

ggplot(df, aes(x = detected_twice, y = library_size)) +
  geom_point() +
  ylim(0,NA) + 
  geom_vline(xintercept = barcode_detected_twice, linetype = "dashed", colour = "red")



# by changing the assume library size of unique barcodes in the 10_P_1
# I can see how many barcodes will be detected twice
# then I will find out the real size
