import random





def generate_random_2_mer_but_not_TG():
    
    nucleotides = ['A', 'T', 'C', 'G']
    random_sequence = ''.join(random.choices(nucleotides, k = 2)) # random.choices: picks k random elements with replacement (elements can repeat)
    
    while random_sequence == 'TG':
        
        random_sequence = ''.join(random.choices(nucleotides, k = 2))
    
    return random_sequence



def replace_TG_with_random_2_mer(seq, n):
    
    original_seq = seq
    
    positions = []
    
    for i in range(len(seq)-1):
        
        if seq[i:i+2] == 'TG':
            
            positions.append(i)
    
    #print(positions)
    
    bottle_necked_positions = random.sample(positions, k = n) # random.sample: picks k unique random elements without replacement (elements cannot repeat)
    
    for pos in bottle_necked_positions:
        
        seq = seq[:pos] + generate_random_2_mer_but_not_TG() + seq[pos+2:]
    
    # check if the new generated sequence doesn't have new TG
    while seq.count('TG') > (original_seq.count('TG') - n):
        
        for pos in bottle_necked_positions:
            
            seq = seq[:pos] + generate_random_2_mer_but_not_TG() + seq[pos+2:]
    
    return seq



def calculate_gc_content(seq):
    
    gc_count = seq.count('G') + seq.count('C')
    
    return gc_count / len(seq)



def replace_TG_but_maintain_same_GC_content(seq, n):
    
    gc_content_of_input = calculate_gc_content(seq)

    TG_replaced_seq = replace_TG_with_random_2_mer(seq, n)
    
    # check if the new generated sequence has the same GC content as the input sequence
    while (abs(calculate_gc_content(TG_replaced_seq) - gc_content_of_input) > 0.0001):
        
        TG_replaced_seq = replace_TG_with_random_2_mer(seq, n)
    
    return TG_replaced_seq