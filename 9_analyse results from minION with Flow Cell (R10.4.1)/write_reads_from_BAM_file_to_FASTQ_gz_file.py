import gzip
import pysam



def write_reads_from_BAM_file_to_FASTQ_gz_file(FASTQ_gz_file, reads):
    
    with gzip.open(FASTQ_gz_file, "wt") as file:
        
        # reads are extracted by pysam.AlignmentFile
        # so I can use pysam functions to extract information from the reads
        
        for read in reads:
            
            # FASTQ files is composed by 4 lines
                # 1. sequence identifier
                # 2. sequence
                # 3. +
                # 4. sequencing quality
            
            query_name = read.query_name
            query_sequence = read.query_sequence
            query_qualities = read.query_qualities
            query_qualities_string = "".join([chr(q + 33) for q in query_qualities])
                # convert quality scores to ASCII string
                    # the quality scores are stored as integers in BAM files, but FASTQ file requires them to be represented as ASCII characters
                    # the constant 33 is added because the ASCII codes used in FASTQ file are starting from character 33
            
            file.write(f"@{query_name}\n{query_sequence}\n+\n{query_qualities_string}\n")