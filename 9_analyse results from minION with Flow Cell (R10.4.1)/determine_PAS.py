def determine_PAS(query_sequence, alignment):
    
    polyA_in_query = query_sequence.find("A" * 10)
    polyA_start = polyA_in_query - 15
    # polyA start position in the query sequence might not be aligned to the reference sequence, so I need to take the position of 15 nucleotides upstream
    
    polyA_in_reference = 'None'
    
    for first, second in alignment:
        
        if first == polyA_start:
            
            polyA_in_reference = second
    
    #print(query_name, polyA_in_query, polyA_in_reference)
    
    
    
    if type(polyA_in_reference) == int:
        
        #if polyA_in_reference > 2000 and polyA_in_reference < 2100 and query_length >= 1300 and query_length <= 1550:
            
        #    PAS = 'canonical'
        
        #if polyA_in_reference > 3025 and polyA_in_reference < 3125 and query_length >= 2350 and query_length <= 2600:
            
        #    PAS = 'cryptic'
        
        # use query_length to filter out the reads that have wired splicing, which might caused shorter read length
        
        PAS = polyA_in_reference
    
    else:
            
        PAS = 'NA'
    
    
    
    return PAS