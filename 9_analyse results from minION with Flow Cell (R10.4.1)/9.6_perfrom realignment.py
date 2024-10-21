# use conda enviroment "general" to run this script

import glob
import os



directory_path = '/Volumes/lab-frattap/home/users/jeanz/Nanopore_sequencing/ELK1_UG_replaced_library_in_Dox_curve/'

FASTQ_files = glob.glob(directory_path + 'splitted_FASTQ_files/*.fastq.gz')

FASTA_files_directory = '/Users/jeanz/GitHub/replace_UG_in_first_800_bp_of_ELK1_extended_3_prime_UTR/9_analyse\ results\ from\ minION\ with\ Flow\ Cell\ \(R10.4.1\)/FASTA_files_for_realignment/'

output_path = directory_path + 'realigned_BAM_files/'
os.makedirs(output_path, exist_ok=True)  # exist_ok=True will prevent errors if the directory already exists

for FASTQ_file in FASTQ_files:
    
    # example FASTQ_file -> splitted_FASTQ_files/barcode02_____UG_removed---10%_#1---25%_#2.fastq.gz
    
    FASTQ_filename = FASTQ_file.split('/')[-1] # get the last element of the list
    #Nanopore_barcode = FASTQ_filename.split("_____")[0]
    insert = '_'.join(FASTQ_filename.split("_")[5:]).split('.')[0]
    
    
    
    reference = FASTA_files_directory + insert + '.fasta'
    BAM_file = output_path + FASTQ_filename.split('.')[0] + '.bam'
    
    command_line = f"minimap2 -ax splice {reference} {FASTQ_file} | samtools view -bS | samtools sort -o {BAM_file}"
        # the pipe (|) means the output of the minimap2 command is piped (passed directly) as input to the next command
        # -o: this option specifies the output filename where the file will be saved
    
    os.system(command_line)