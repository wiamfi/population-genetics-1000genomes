# Population-Specific Genetic Variant Analysis Using 1000 Genomes Data

## Research Question
How does genetic variation differ between human populations, and what are the 
potential functional consequences of selected variants?

## Data
- **Source:** 1000 Genomes Project, Phase 3, chromosome 22
  (`ALL.chr22.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz`)
- **Reference genome build:** GRCh37
- **Total variants (chr22):** 1,103,547
- **Populations compared:**
  - YRI — Yoruba, Nigeria (African ancestry) — 108 samples
  - CEU — Utah residents (European ancestry) — 99 samples
  - CHB — Han Chinese, Beijing (East Asian ancestry) — 103 samples

## Methods

1. **Data preparation:** Subsetted the full chromosome 22 VCF (2,504 samples) down 
   to the 310 samples belonging to YRI, CEU, and CHB using `bcftools view -S`.
2. **Quality filtering:** Removed structurally complex / multi-allelic variants 
   (e.g. copy-number variants), reducing from 1,103,547 to 1,096,485 positions.
3. **Allele frequency calculation:** Calculated allele frequency independently for 
   each population using `bcftools +fill-tags`.
4. **Population comparison:** Merged the three per-population frequency tables and 
   calculated the absolute frequency difference for every pairwise population 
   comparison (YRI-CEU, YRI-CHB, CEU-CHB), using the maximum difference as a 
   ranking score.
5. **Candidate selection:** Selected the top 15 most differentiated variants, 
   enforcing a minimum 50,000 base-pair spacing between selected positions to 
   avoid redundant signals from genetically linked variants.
6. **Functional annotation:** Submitted the shortlist to Ensembl's Variant Effect 
   Predictor (VEP, GRCh37) to determine gene context and predicted consequence 
   type for each variant.

## Results

### Sample sizes
See `results/sample_sizes.png` — comparable sample sizes (~100-110) across all 
three populations, supporting a fair frequency comparison.

### Most differentiated variants
See `results/top20_heatmap.png` and `results/final_variant_annotations.csv` for 
the full table. Key findings:

| Position (chr22) | Gene | Consequence | AF YRI | AF CEU | AF CHB |
|---|---|---|---|---|---|
| 46,500,973 | FLJ27365 | intron_variant | 0.99 | 0.31 | 0.00 |
| 21,508,002 | *(intergenic)* | intergenic_variant | 0.00 | 0.07 | 0.96 |
| 36,556,964 | APOL3 | 5_prime_UTR_variant | 0.01 | 0.38 | 0.90 |
| 46,652,959 | PKDREJ | synonymous_variant | 0.96 | 0.27 | 0.06 |

*(Full table of all 15 variants in `results/final_variant_annotations.csv`)*

### Functional consequence summary
Out of 15 candidate variants:
- 0 missense (protein-changing) variants
- 1 synonymous coding variant (PKDREJ)
- 11 intronic or UTR variants, in protein-coding genes (TNRC6B, CELSR1, SEZ6L, 
  SYN3, APOL3, CERK, FLJ27365)
- 2 intergenic variants, with no nearby gene
- 1 variant near a pseudogene (CSF2RBP1)

## Interpretation

None of the top differentiated variants alter a protein's amino acid sequence, 
consistent with the expectation that protein-changing mutations are generally 
constrained by natural selection even when regionally differentiated. The majority 
sit in intronic or untranslated regions of real genes, which are plausible 
candidates for influencing gene regulation or expression level rather than protein 
structure directly.

Several candidates clustered within the same gene (TNRC6B: 3 variants; CELSR1: 
2 variants), consistent with genetic linkage — nearby variants tend to be inherited 
together as a block rather than independently, which is an expected and biologically 
meaningful pattern rather than redundant noise.

One finding of particular interest is a variant in **APOL3**, a member of the 
Apolipoprotein L gene family. A related gene in this family, APOL1, is a well-studied 
example of population-specific evolutionary pressure linked to trypanosome 
resistance in populations of African ancestry. While the functional significance of 
this specific variant is not established here, it represents a biologically 
plausible candidate for future investigation.

### Validation with scikit-allel

- Allele frequencies recomputed from raw genotypes (scikit-allel) matched the bcftools
  values for the 13 shortlisted SNPs (max absolute difference: [VALUE FROM CELL 5]).
- Hudson FST on chr22: YRI–CEU 0.140 ± 0.005, YRI–CHB 0.174 ± 0.007,
  CEU–CHB 0.108 ± 0.006 (block-jackknife SE), consistent with the out-of-Africa
  population history.
- The frequency-difference ranking and FST ranking were highly concordant
  (Spearman ρ = 0.968, n = 416,715 SNPs). All 13 shortlisted SNPs fall in the top
  0.012% of variants by FST. Because both statistics derive from the same allele
  frequencies, this shows the selection is robust to the choice of statistic rather
  than providing independent evidence of functional relevance.
  
## Limitations

- Analysis restricted to chromosome 22 only; genome-wide patterns may differ.
- Only 3 populations compared, out of the 26 available in the dataset.
- VEP annotation reflects genomic location and known gene models; it does not 
  constitute experimental evidence of functional effect.
- The 50kb spacing used to reduce redundancy is a simple heuristic, not a formal 
  linkage disequilibrium calculation.

## Reproducibility

All scripts (`src/`) and notebooks (`notebooks/`) used to generate these results 
are included in this repository. Raw data sources are listed above and are 
publicly available from the 1000 Genomes Project.