# Binning-Eukaryotic Module Dependencies

## Overview
The binning-eukaryotic module in VEBA is designed specifically for recovering eukaryotic genomes from metagenomic assemblies. It identifies and bins eukaryotic contigs, performs gene prediction for nuclear and organellar genes, assesses genome quality, and generates expression data. This specialized module complements VEBA's prokaryotic and viral binning capabilities, enabling comprehensive recovery of eukaryotic genomes from complex microbial communities.

## Core Python Dependencies
- **genopype**: Workflow management framework
- **soothsayer_utils**: Utility functions for bioinformatics pipelines
- **pandas**: Data manipulation and analysis
- **numpy**: Numerical computing
- **torch**: Deep learning library (for Tiara)
- **scikit-learn**: Machine learning library

## External Tools
- **MetaBat2**: Binning algorithm for initial genome bins
  - Uses coverage information to bin contigs
  
- **Tiara**: Domain classification tool
  - Identifies eukaryotic contigs using deep learning
  - Separates eukaryotic from prokaryotic and viral sequences
  
- **MetaEuk**: Eukaryotic gene prediction tool
  - Predicts protein-coding genes in eukaryotic genomes
  - Sensitive homology-based search for nuclear genes
  
- **Pyrodigal**: Gene prediction for organellar genes
  - Used for mitochondrial and plastid gene detection
  
- **Barrnap**: Ribosomal RNA gene detection
  - Identifies rRNA genes in eukaryotic genomes
  
- **tRNAscan-SE**: Transfer RNA detection
  - Finds and classifies tRNA genes
  
- **BUSCO**: Genome completeness assessment
  - Evaluates genome quality with lineage-specific markers
  
- **featureCounts**: Read counting
  - Generates expression data for predicted genes

## Databases
- **MicroEuk database**: Reference database for MetaEuk
  - Available in multiple versions: MicroEuk100, MicroEuk90, MicroEuk50
  - Contains protein sequences for identifying eukaryotic genes
  
- **BUSCO lineages**: Markers for genome quality assessment
  - Default: eukaryota_odb12
  - Downloaded as needed (not stored in VEBA database)
  - Can use auto-lineage detection or specific lineages

## Environment Details
The binning-eukaryotic module uses the `VEBA-binning-eukaryotic_env` conda environment with the following key components:
- Python 3.10
- MetaBat2 2.17
- Tiara 1.0.4
- MetaEuk 7.bba0d80
- BUSCO 5.8.3
- Barrnap 0.9
- tRNAscan-SE 2.0.12
- featureCounts (via Subread 2.0.6)
- PyTorch 2.6.0 (for Tiara neural network)
- Other dependencies including R packages for visualization

## Pipeline Process
1. **Preprocessing**: Optional subsetting of contigs based on identifiers
   - Filters contigs by minimum length (default: 1500 bp)

2. **Binning**: Initial genome bin generation
   - Uses MetaBat2 for coverage-based binning
   - Creates preliminary genome bins

3. **Domain Classification**: Identifying eukaryotic bins
   - Uses Tiara to classify contigs by domain
   - Separates eukaryotic from non-eukaryotic sequences

4. **Eukaryotic Gene Modeling**: Comprehensive gene prediction
   - Nuclear genes: MetaEuk with MicroEuk database
   - Mitochondrial genes: Pyrodigal with mitochondrial genetic code
   - Plastid genes: Pyrodigal with plastid genetic code
   - rRNA genes: Barrnap
   - tRNA genes: tRNAscan-SE with domain-specific settings

5. **Quality Assessment**: BUSCO analysis
   - Evaluates genome completeness and contamination
   - Filters genomes based on quality thresholds
   - Generates quality reports

6. **Feature Counting**: Expression profiling
   - Counts reads mapped to predicted genes
   - Generates expression data for downstream analysis

## Requirements
- Sufficient memory for MetaEuk (configurable split memory limit)
- MicroEuk database for eukaryotic gene prediction
- BUSCO lineage database for quality assessment
- Multi-threading capability for improved performance
- Minimum 1500 bp contigs (recommended for accurate binning)

## Usage
Basic command:
```bash
veba --module binning-eukaryotic -f scaffolds.fasta -b mapped.sorted.bam -n SAMPLE_ID -o output_directory -p 16
```

Example with specific parameters:
```bash
veba --module binning-eukaryotic -f unbinned.fasta -b mapped.sorted.bam -n SAMPLE_ID -o output_directory -p 16 -m 1500 -M MicroEuk50 --busco_completeness 30 --busco_contamination 10
```

The module is often used after prokaryotic binning to recover eukaryotic genomes from the unbinned contigs:
```bash
veba --module binning-eukaryotic -f ../binning/prokaryotic/SAMPLE_ID/output/unbinned.fasta -b ../assembly/SAMPLE_ID/output/mapped.sorted.bam -n SAMPLE_ID -o output_directory
```