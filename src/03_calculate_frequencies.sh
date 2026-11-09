#!/bin/bash
# Step: Calculate allele frequency per population
# Goal: get, for every variant, the frequency of the alternate allele
# separately in YRI, CEU, and CHB, so we can compare them.

cd ~/bioinfo_projects/projet1_population_genetics

PANEL=data/raw/1000_genomes/integrated_call_samples_v3.20130502.ALL.panel.txt
SUBSET_VCF=data/processed/chr22_YRI_CEU_CHB.vcf.gz

# Create one sample-ID list per population
awk '$2=="YRI" {print $1}' $PANEL > data/processed/samples_YRI.txt
awk '$2=="CEU" {print $1}' $PANEL > data/processed/samples_CEU.txt
awk '$2=="CHB" {print $1}' $PANEL > data/processed/samples_CHB.txt

echo "Sample counts:"
wc -l data/processed/samples_YRI.txt data/processed/samples_CEU.txt data/processed/samples_CHB.txt

echo ""
echo "=== Calculating allele frequencies per population ==="

for POP in YRI CEU CHB; do
    echo "Processing $POP..."
    bcftools view -S data/processed/samples_${POP}.txt $SUBSET_VCF | \
    bcftools +fill-tags -- -t AF | \
    bcftools query -f '%CHROM\t%POS\t%ID\t%REF\t%ALT\t%INFO/AF\n' \
    > data/processed/freq_${POP}.txt
done

echo "=== Done. Preview of YRI frequencies ==="
head data/processed/freq_YRI.txt