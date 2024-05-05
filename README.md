# Manhattan Plot Script

### Author: Hamdy Abdel-Shafy
### Date: May 2024
### Affiliation: Department of Animal Production, Cairo University, Faculty of Agriculture


## Instructions:
1. Place the PLINK output file in the same directory as this script.
2. Update the file path accordingly in the script if necessary.
3. Run the script in R or RStudio to generate the Manhattan plot.


## Description:
- The script loads PLINK output data containing association results.
- It calculates the Bonferroni corrected significance threshold and the suggestive significance threshold.
- The Manhattan plot is created using the qqman package, displaying SNP associations across chromosomes.
- Two threshold lines are included: one for genome-wide significance and one for suggestive significance.
