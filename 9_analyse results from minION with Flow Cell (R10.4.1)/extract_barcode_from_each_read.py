import pysam



def extract_barcode_from_each_read(query_sequence, alignment, barcode_start_in_Ref, barcode_end_in_Ref):
    
    barcode_start = query_sequence.find('ATAAGCCC')
    barcode_end = query_sequence.find('GGGCCTAC')
    
    barcode = 'NA'
    
    if barcode_start != -1 and barcode_end != -1:
        
        barcode = query_sequence[barcode_start+8:barcode_end]
        
        if len(barcode) == 15:
            
            return barcode
    
    if barcode == 'NA' or len(barcode) != 15:
        
        barcode = ''
        
        for i in range(len(alignment)):
            
            for j in (range(barcode_start_in_Ref, barcode_end_in_Ref+1)):
                
                if alignment[i][1] == j:
                    
                    if alignment[i][0] == None:
                        
                        barcode = barcode + '-'
                    
                    else:
                        
                        barcode = barcode + query_sequence[alignment[i][0]]
        
        if barcode.find('-') != -1 or barcode == '': # only preserve the barcode if it is 15 nucleotides long
            
            barcode = 'NA'
            
            return barcode
        
        else:
                
            return barcode