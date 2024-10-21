import pysam



def extract_barcodes_from_BAM_file(BAM_file, barcode_start_in_Ref, barcode_end_in_Ref):
    
    dict = {}
    
    with pysam.AlignmentFile(BAM_file) as bam:
        
        for record in bam:
            
            if record.is_supplementary or record.is_secondary or record.is_unmapped:
                
                continue
            
            
            
            query_name = record.query_name
            query_sequence = record.query_sequence
            query_qualities = list(record.query_qualities) # .query_qualities is a byte_array, so convert to list
            alignment = record.get_aligned_pairs()
            
            
                        
            barcode_start = query_sequence.find('ATAAGCCC')
            barcode_end = query_sequence.find('GGGCCTAC')
            
            barcode = 'NA'
            qualities = 'NA'
            
            if barcode_start != -1 and barcode_end != -1:
                
                barcode = query_sequence[barcode_start+8:barcode_end]
                
                if len(barcode) == 15:
                    
                    qualities = query_qualities[barcode_start+8:barcode_end]
            
            if barcode == 'NA' or len(barcode) != 15:
                
                barcode = ''
                
                for i in range(len(alignment)):
                    
                    for j in (range(barcode_start_in_Ref, barcode_end_in_Ref+1)):
                        
                        if alignment[i][1] == j:
                            
                            if alignment[i][0] == None:
                                
                                barcode = barcode + '-'
                            
                            else:
                                
                                barcode = barcode + query_sequence[alignment[i][0]]
                
                if barcode.find('-') != -1: # only preserve the barcode if it is 15 nucleotides long
                    
                    barcode = 'NA'
            
            
            
            dict[query_name] = {'barcode': barcode, 'qualities': qualities}
    
    return dict