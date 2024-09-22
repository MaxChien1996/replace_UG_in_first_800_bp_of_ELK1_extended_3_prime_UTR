# just a record of the commands I used to run the alignment

conda activate general

cd ~/GitHub/replace_UG_in_first_800_bp_of_ELK1_extended_3_prime_UTR/7_quality\ control\ of\ library\ making

sh ~/GitHub/General/align_Nanopore_sequencing_raw_reads_without_splicing.sh 7.4_align_to_079_and_look_on_IGV/079_barcoded_UG_replaced_ELK1_3_prime_UTR_reporters.fa 7.1_filter\ reads\ based\ on\ read\ length/filter_FASTQ_10_P_0.fastq.gz 7.4_align_to_079_and_look_on_IGV/filter_10_P_0_to_079
sh ~/GitHub/General/align_Nanopore_sequencing_raw_reads_without_splicing.sh 7.4_align_to_079_and_look_on_IGV/079_barcoded_UG_replaced_ELK1_3_prime_UTR_reporters.fa 7.1_filter\ reads\ based\ on\ read\ length/filter_FASTQ_10_P_1.fastq.gz 7.4_align_to_079_and_look_on_IGV/filter_10_P_1_to_079
sh ~/GitHub/General/align_Nanopore_sequencing_raw_reads_without_splicing.sh 7.4_align_to_079_and_look_on_IGV/079_barcoded_UG_replaced_ELK1_3_prime_UTR_reporters.fa 7.1_filter\ reads\ based\ on\ read\ length/filter_FASTQ_10_P_2.fastq.gz 7.4_align_to_079_and_look_on_IGV/filter_10_P_2_to_079