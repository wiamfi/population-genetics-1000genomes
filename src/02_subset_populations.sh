#!/bin/bash
# Step: Subset the VCF to only YRI, CEU, CHB samples
# Goal: shrink the dataset from 2,504 samples to ~310, 
# so all later processing is faster and focused on our comparison.

cd ~/bioinfo_projects/projet1_population_genetics

PANEL=data/raw/1000_genomes/integrated_call_samples_v3.20130502.ALL.panel.txt
VCF=data/raw/1000_genomes/ALL.chr22.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz

# Extract sample IDs for our 3 populations of interest
awk '$2=="YRI" || $2=="CEU" || $2=="CHB" {print $1}' $PANEL > data/processed/samples_of_interest.txt

echo "=== Number of samples selected ==="
wc -l data/processed/samples_of_interest.txt

echo "=== First few sample IDs ==="
head data/processed/samples_of_interest.txt

echo ""
echo "=== Subsetting VCF to selected samples ==="

bcftools view -S data/processed/samples_of_interest.txt \
    -Oz -o data/processed/chr22_YRI_CEU_CHB.vcf.gz \
    $VCF

echo "=== Indexing the new subset VCF ==="
tabix -p vcf data/processed/chr22_YRI_CEU_CHB.vcf.gz

echo "=== Confirming subset file ==="
bcftools query -l data/processed/chr22_YRI_CEU_CHB.vcf.gz | wc -l