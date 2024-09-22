# just a record of the commands I used to run the alignment

conda activate general

cd ~/GitHub/replace_UG_in_first_800_bp_of_ELK1_extended_3_prime_UTR/7_quality\ control\ of\ library\ making

sh ~/GitHub/General/align_Nanopore_sequencing_raw_reads_without_splicing.sh ~/GitHub/replace_UG_in_first_800_bp_of_ELK1_extended_3_prime_UTR/6_potential\ combination\ after\ Gibson\ assembly/potential_combination_of_inserts.fasta 7.1_filter\ reads\ based\ on\ read\ length/filter_FASTQ_10_P_0.fastq.gz 7.2_align_to_potential_combination/filter_10_P_0
sh ~/GitHub/General/align_Nanopore_sequencing_raw_reads_without_splicing.sh ~/GitHub/replace_UG_in_first_800_bp_of_ELK1_extended_3_prime_UTR/6_potential\ combination\ after\ Gibson\ assembly/potential_combination_of_inserts.fasta 7.1_filter\ reads\ based\ on\ read\ length/filter_FASTQ_10_P_1.fastq.gz 7.2_align_to_potential_combination/filter_10_P_1
sh ~/GitHub/General/align_Nanopore_sequencing_raw_reads_without_splicing.sh ~/GitHub/replace_UG_in_first_800_bp_of_ELK1_extended_3_prime_UTR/6_potential\ combination\ after\ Gibson\ assembly/potential_combination_of_inserts.fasta 7.1_filter\ reads\ based\ on\ read\ length/filter_FASTQ_10_P_2.fastq.gz 7.2_align_to_potential_combination/filter_10_P_2