#!/bin/bash
# Step: Explore population metadata
# Goal: understand sample sizes per population and superpopulation,
# so we can choose which populations to compare later.

cd data/raw/1000_genomes

echo "=== First lines of panel file ==="
head integrated_call_samples_v3.20130502.ALL.panel.txt

echo ""
echo "=== Samples per population ==="
awk '{print $2}' integrated_call_samples_v3.20130502.ALL.panel.txt | sort | uniq -c | sort -rn

echo ""
echo "=== Samples per superpopulation ==="
awk '{print $3}' integrated_call_samples_v3.20130502.ALL.panel.txt | sort | uniq -c | sort -rn