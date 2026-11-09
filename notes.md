## Population selection
Chose 3 populations for comparison, one per continent, with comparable sample sizes:
- YRI (Yoruba, Nigeria) — 108 samples — African ancestry
- CEU (Utah residents) — 99 samples — European ancestry
- CHB (Han Chinese, Beijing) — 103 samples — East Asian ancestry

Verified counts in notebooks/01_population_overview.ipynb, chart saved to results/sample_sizes.png 

## Final summary
- Subsetted chr22 VCF to 310 samples (YRI, CEU, CHB)
- Calculated per-population allele frequencies, merged and ranked by max pairwise difference
- Selected 15 non-redundant variants (50 kb spacing), annotated with VEP (GRCh37)
- Findings: no missense variants, mostly intronic/UTR, linked clusters in TNRC6B and CELSR1
- Deliverables: REPORT.md, results/final_variant_annotations.csv, figures in results/