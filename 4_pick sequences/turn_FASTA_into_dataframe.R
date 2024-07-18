turn_FASTA_into_dataframe <- function(FASTA_file_path){
  
  library(Biostrings)
  
  
  
  FASTA <- readDNAStringSet(FASTA_file_path)
  candidates = names(FASTA)
  sequence = paste(FASTA)
  df <- data_frame(candidates, sequence)
  
  return(df)
}
