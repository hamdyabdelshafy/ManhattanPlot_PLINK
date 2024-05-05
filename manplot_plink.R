# Author: Hamdy Abdel-Shafy
# Date: May 2024
# Affiliation: Department of Animal Production, Cairo University, Faculty of Agriculture

# Description:
# This script generates a Manhattan plot using PLINK output data and the qqman package in R.
# It calculates Bonferroni and suggestive significance thresholds and saves the plot as a PDF file.


# Step 1: Check if necessary packages are installed, if not, install them
if (!requireNamespace("qqman", quietly = TRUE)) {
  install.packages("qqman")
}
library(qqman)

# Step 2: Load PLINK Output
# Set the working directory to where your data is located
setwd("YOUR WORKING DIRECTORY")

# Read the PLINK output file
# Replace "RESULTS OUTPUT file" with the actual file name
plink_output <- read.table("RESULTS OUTPUT file", header = TRUE)


# Step 3: Determine the Bonferroni corrected significance threshold
# Bonferroni correction: divide alpha by the number of SNPs in the file
alpha <- 0.05
num_snps <- nrow(plink_output)
bonferroni_threshold <- -log10(alpha / num_snps)

# Step 4: Calculate Suggestive Significance Threshold
# Suggestive value: divide 1 by the number of SNPs in the file
# The suggestive level was proposed by Lander and Kruglyak (1995), Nat Genet 11, 241-247. https://doi.org/10.1038/ng1195-241 
# It represents the threshold where, under the null hypothesis, one false positive is expected per genome scan.

suggestive_threshold <- -log10(1 / num_snps)

# Step 5: Save the Plot as PDF with Adjusted Font Size and Plot Dimensions
pdf("Manhattan_plot.pdf", width = 10, height = 6)  # Adjust dimensions as needed

# Step 6: Create Manhattan Plot with Adjusted Font Size
# Use the manhattan() function from qqman package to create the plot
# Provide the column names for chromosome, base pair position, SNP identifier, and p-value
manhattan(plink_output, chr = "CHR", bp = "BP", snp = "SNP", p = "P", 
          ylim = c(0, max(-log10(plink_output$P), na.rm = TRUE) + 1),
          col = c("blue", "red"),       # Specify colors for threshold lines
          cex = 0.6,                     # Reduce point size for better visibility
          suggestiveline = suggestive_threshold,   # Set suggestive threshold line
          genomewideline = bonferroni_threshold,  # Set genome-wide threshold line to Bonferroni corrected threshold
          main = "Manhattan Plot",      # Add a title to the plot
          xlab = "Chromosome",          # Label x-axis
          ylab = "-log10(p-value)",     # Label y-axis
          cex.axis = 1.2,               # Adjust font size of axis labels
          cex.lab = 1.2)                # Adjust font size of axis titles

# End PDF Device
dev.off()
