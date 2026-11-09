#!/bin/bash
# Step: keep only biallelic SNPs that are polymorphic in our 310 samples
# Goal: lighter input for scikit-allel (FST + frequency cross-check)

cd ~/bioinfo_projects/projet1_population_genetics

IN=data/processed/chr22_YRI_CEU_CHB.vcf.gz
OUT=data/processed/chr22_YRI_CEU_CHB_snps.vcf.gz

bcftools view -m2 -M2 -v snps -c 1:minor $IN -Oz -o $OUT
tabix -p vcf $OUT

echo "Variants kept:"
bcftools index -n $OUT