cd /Volumes/lab-frattap/home/users/jeanz/Nanopore_sequencing/079_barcode_quality_check_before_we_go/

cat 01/20240919_1851_MN41644_APP891_8b3c52b8/fastq_pass/*.fastq.gz > combined_01.fastq.gz
cat 02/20240920_0003_MN41644_APP891_cd3b31a6/fastq_pass/*.fastq.gz > combined_02.fastq.gz
cat 03/20240920_1340_MN41644_APP891_96b60c74/fastq_pass/*.fastq.gz > combined_03.fastq.gz

cat *.fastq.gz > combined_all.fastq.gz

rm combined_01.fastq.gz
rm combined_02.fastq.gz
rm combined_03.fastq.gz