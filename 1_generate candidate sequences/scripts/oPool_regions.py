# define the sequence which will be replaced by oPools
# in the seqeucne, there are 12 UG-rich regions
# sequence from barcoded_ELK1_3_prime_UTR_regulated_APA_reporter (No. 69)



oPools_1 = 'CAAAAGACTCCTGGGCTCACCTGTTAGCGCTGGCCCAGCCCAGGCCTTGGGACCTGGGGGTTGGTGATTTGGGGGACAGTGCTACACTCGTCTCCACTGTTTGTTTTACTTCCCCAAAATGGACCTTTTTTTTTTCTAAAGAGTCCCAGAGAATGGGGAATTGTTCCTGTAAATATATATTTTTCAAAGTGA'
#print(oPools_1)

Gibson_assembly_overlapping_oPools_1_2 = 'TCCTGTAAATATATATTTTTCAAAGTGA'

UG_rich_region_1 = 'TGCTGGAGGCTGCTG'
linker_1_2 = 'GCACTTTTTCTC'
UG_rich_region_2 = 'TGATGTTG'
linker_2_3 = 'TCAGGACTAGC'
UG_rich_region_3 = 'TGAGCGTG'
linker_3_4 = 'GCACGCA'
UG_rich_region_4 = 'TGACTGTGTGTGGAGGGTGTG'
linker_4_5 = 'AGGCAGAGGTCG'
UG_rich_region_5 = 'ATTGTGAG'
linker_5_6 = 'AGAAACGG'
UG_rich_region_6 = 'TGTGATGGCGTGTGTG'
linker_6_7_one = 'AG'
linker_6_7_two = 'AAACAATAGTAGGGACTGCATATCGGTA'

oPools_2 = UG_rich_region_1 + linker_1_2 + UG_rich_region_2 + linker_2_3 + UG_rich_region_3 + linker_3_4 + UG_rich_region_4 + linker_4_5 + UG_rich_region_5 + linker_5_6 + UG_rich_region_6 + linker_6_7_one + linker_6_7_two
#print(oPools_2)

Gibson_assembly_overlapping_oPools_2_3 = linker_6_7_two

linker_6_7_three = 'ACCA'
UG_rich_region_7 = 'TGTGTGTG'
linker_7_8 = 'TCAGAGACGTGGAAAGC'
UG_rich_region_8 = 'TGTGATTGTGTGTGAGAGTGTGCAGAAGTTGTG'
linker_8_9 = 'ACCACAGACTTT'
UG_rich_region_9 = 'TGATGGTGTGTCTATGTG'
linker_9_10 = 'GGAAAT'
UG_rich_region_10 = 'TGTGGCTGTG'
linker_10_11 = 'TTTCAGAAAATAAC'
UG_rich_region_11 = 'TGAGCCTGGATG'
linker_11_12 = 'AATAGTCAAGGTACTGTACAAGAACC'
UG_rich_region_12 = 'TGTGATGGTATG'
after_UG_rich_region_12 = 'CACAAAATAATGTCTACGAGAAGGGAACGGGGACTGCAGCCCT'

oPools_3 = linker_6_7_two + linker_6_7_three + UG_rich_region_7 + linker_7_8 + UG_rich_region_8 + linker_8_9 + UG_rich_region_9 + linker_9_10 + UG_rich_region_10 + linker_10_11 + UG_rich_region_11 + linker_11_12 + UG_rich_region_12 + after_UG_rich_region_12
#print(oPools_3)

original_seq = oPools_1 + UG_rich_region_1 + linker_1_2 + UG_rich_region_2 + linker_2_3 + UG_rich_region_3 + linker_3_4 + UG_rich_region_4 + linker_4_5 + UG_rich_region_5 + linker_5_6 + UG_rich_region_6 + linker_6_7_one + linker_6_7_two + linker_6_7_three + UG_rich_region_7 + linker_7_8 + UG_rich_region_8 + linker_8_9 + UG_rich_region_9 + linker_9_10 + UG_rich_region_10 + linker_10_11 + UG_rich_region_11 + linker_11_12 + UG_rich_region_12 + after_UG_rich_region_12
#print(original_seq)

total_TG_amount_in_UG_rich_regions = UG_rich_region_1.count('TG') + UG_rich_region_2.count('TG') + UG_rich_region_3.count('TG') + UG_rich_region_4.count('TG') + UG_rich_region_5.count('TG') + UG_rich_region_6.count('TG') + UG_rich_region_7.count('TG') + UG_rich_region_8.count('TG') + UG_rich_region_9.count('TG') + UG_rich_region_10.count('TG') + UG_rich_region_11.count('TG') + UG_rich_region_12.count('TG')
#print(TG_amount_in_UG_rich_regions)