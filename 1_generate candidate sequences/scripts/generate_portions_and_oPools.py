from replace_TG_but_maintain_same_GC_content import *
from oPool_regions import *
import random





# replace certain amount of TG in UG-rich regions
# for example, if portion = 0.25, replace 25% of TG

def generate_portions(portion):
    
    if portion == 1: # avoid the loop keep running
        
        portions = [UG_rich_region_1.count('TG'), UG_rich_region_2.count('TG'), UG_rich_region_3.count('TG'), UG_rich_region_4.count('TG'), UG_rich_region_5.count('TG'), UG_rich_region_6.count('TG'), UG_rich_region_7.count('TG'), UG_rich_region_8.count('TG'), UG_rich_region_9.count('TG'), UG_rich_region_10.count('TG'), UG_rich_region_11.count('TG'), UG_rich_region_12.count('TG')]
    
    else:
        
        TG_amount_want_to_replace = round(total_TG_amount_in_UG_rich_regions * portion) # TG amount need to be integer
        
        # randomly choose the amount of TG to replace in each UG-rich region
        portions = random.choices(range(0, UG_rich_region_1.count('TG') + 1), k = 1) + random.choices(range(0, UG_rich_region_2.count('TG') + 1), k = 1) + random.choices(range(0, UG_rich_region_3.count('TG') + 1), k = 1) + random.choices(range(0, UG_rich_region_4.count('TG') + 1), k = 1) + random.choices(range(0, UG_rich_region_5.count('TG') + 1), k = 1) + random.choices(range(0, UG_rich_region_6.count('TG') + 1), k = 1) + random.choices(range(0, UG_rich_region_7.count('TG') + 1), k = 1) + random.choices(range(0, UG_rich_region_8.count('TG') + 1), k = 1) + random.choices(range(0, UG_rich_region_9.count('TG') + 1), k = 1) + random.choices(range(0, UG_rich_region_10.count('TG') + 1), k = 1) + random.choices(range(0, UG_rich_region_11.count('TG') + 1), k = 1) + random.choices(range(0, UG_rich_region_12.count('TG') + 1), k = 1)
        
        while sum(portions) != TG_amount_want_to_replace: # make sure the total amount of TG replaced is equal to the amount wanted to be replaced
            
            portions = random.choices(range(0, UG_rich_region_1.count('TG') + 1), k = 1) + random.choices(range(0, UG_rich_region_2.count('TG') + 1), k = 1) + random.choices(range(0, UG_rich_region_3.count('TG') + 1), k = 1) + random.choices(range(0, UG_rich_region_4.count('TG') + 1), k = 1) + random.choices(range(0, UG_rich_region_5.count('TG') + 1), k = 1) + random.choices(range(0, UG_rich_region_6.count('TG') + 1), k = 1) + random.choices(range(0, UG_rich_region_7.count('TG') + 1), k = 1) + random.choices(range(0, UG_rich_region_8.count('TG') + 1), k = 1) + random.choices(range(0, UG_rich_region_9.count('TG') + 1), k = 1) + random.choices(range(0, UG_rich_region_10.count('TG') + 1), k = 1) + random.choices(range(0, UG_rich_region_11.count('TG') + 1), k = 1) + random.choices(range(0, UG_rich_region_12.count('TG') + 1), k = 1)
    
    return portions



def generate_oPools(portions):
    
    oPools_2 = Gibson_assembly_overlapping_oPools_1_2 + replace_TG_but_maintain_same_GC_content(UG_rich_region_1, portions[0]) + linker_1_2 + replace_TG_but_maintain_same_GC_content(UG_rich_region_2, portions[1]) + linker_2_3 + replace_TG_but_maintain_same_GC_content(UG_rich_region_3, portions[2]) + linker_3_4 + replace_TG_but_maintain_same_GC_content(UG_rich_region_4, portions[3]) + linker_4_5 + replace_TG_but_maintain_same_GC_content(UG_rich_region_5, portions[4]) + linker_5_6 + replace_TG_but_maintain_same_GC_content(UG_rich_region_6, portions[5]) + linker_6_7_one + linker_6_7_two
    oPools_3 = linker_6_7_two + linker_6_7_three + replace_TG_but_maintain_same_GC_content(UG_rich_region_7, portions[6]) + linker_7_8 + replace_TG_but_maintain_same_GC_content(UG_rich_region_8, portions[7]) + linker_8_9 + replace_TG_but_maintain_same_GC_content(UG_rich_region_9, portions[8]) + linker_9_10 + replace_TG_but_maintain_same_GC_content(UG_rich_region_10, portions[9]) + linker_10_11 + replace_TG_but_maintain_same_GC_content(UG_rich_region_11, portions[10]) + linker_11_12 + replace_TG_but_maintain_same_GC_content(UG_rich_region_12, portions[11]) + after_UG_rich_region_12
    
    return oPools_2, oPools_3