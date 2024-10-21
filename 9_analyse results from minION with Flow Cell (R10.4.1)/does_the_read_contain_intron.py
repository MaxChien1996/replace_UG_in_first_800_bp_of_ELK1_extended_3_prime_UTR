def does_the_read_contain_intron(read, intron_minimum_length = 50):
    
    import pysam
    
    intron = "no_intron"
    
    cigar_tuples = read.cigartuples # (operation, length)
    
    for (cigar_op, cigar_len) in cigar_tuples:
        
        if cigar_op == 3 and cigar_len > intron_minimum_length:
            
            # operation = 3 (skipped region from the reference, idicating intron)
            
            intron = "we_got_an_intron"
    
    
    
    if intron == "we_got_an_intron":
        
        return True
    
    else:
        
        return False