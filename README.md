# Population-Specific Genetic Variant Analysis (1000 Genomes)

Analysis of genetic variation between three human populations (African, European,
East Asian) on chromosome 22, using 1000 Genomes Phase 3 data, followed by
functional annotation of the most differentiated variants with Ensembl VEP.

**Research question:** How does genetic variation differ between human populations,
and what are the potential functional consequences of selected variants?

## Key findings
- 1.1M+ variants processed across 310 individuals (YRI, CEU, CHB)
- 15 highly differentiated, non-redundant variants selected
- No protein-changing variants; most fall in introns/UTRs (regulatory regions)
- Linked variants cluster in the same genes (TNRC6B, CELSR1)
- APOL3 flagged as a biologically plausible candidate (APOL gene family)

Full write-up: see [REPORT.md](REPORT.md)

## Pipeline
```
1000 Genomes VCF -> subset populations -> allele frequencies per population
-> compare populations -> select top variants -> VEP annotation -> interpretation
```

## Project structure
```
src/         shell scripts (data subsetting, frequency calculation)
notebooks/   Jupyter notebooks (analysis and visualization)
results/     figures and final annotated table
data/        raw and processed data (not included, see below)
REPORT.md    research-style report
```

## Reproducing the analysis
1. Download from the 1000 Genomes FTP (Phase 3, 20130502 release):
   - `ALL.chr22.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz` and its `.tbi`
   - `integrated_call_samples_v3.20130502.ALL.panel`
   and place them in `data/raw/1000_genomes/`
2. Install tools: `sudo apt install bcftools samtools tabix`
3. Create the Python environment:
   ```bash
   python3 -m venv venv
   source venv/bin/activate
   pip install -r requirements.txt
   ```
4. Run the scripts in order: `bash src/01_explore_data.sh`, `02_subset_populations.sh`, `03_calculate_frequencies.sh`
5. Run the notebooks in `notebooks/` in order
6. Annotate `data/processed/vep_input_formatted.txt` with the Ensembl VEP web tool
   (GRCh37: https://grch37.ensembl.org/Tools/VEP)

## Tools
bcftools, tabix, Python (pandas, numpy, matplotlib, seaborn, scikit-allel), Ensembl VEP