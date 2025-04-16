# Essentials Module Documentation

## Overview
The essentials module is a utility component that consolidates and organizes output files from various VEBA modules into a streamlined directory structure. It serves as a post-processing step to gather all critical analysis results in one location for easier access, transfer, and downstream analysis.

## Core Python Dependencies
- pandas
- tqdm
- pyexeggutor
- Standard libraries (sys, os, argparse, glob, shutil, gzip)

## External Tools
- No external tools required beyond standard file manipulation utilities

## Databases
- No external reference databases required

## Environment Details
The essentials module runs within the main VEBA conda environment:
```
source activate VEBA
```

Unlike other modules, it doesn't have a dedicated environment file, instead leveraging the base VEBA environment.

## Pipeline Process
1. **Input Analysis**
   - Scans a VEBA output directory to identify all available module results
   - Determines which modules were run and what files are available

2. **File Organization**
   - Creates a structured output directory with subdirectories for different data types
   - Organizes files by module, organism type, and data category

3. **Data Consolidation**
   - Merges related files from across samples into unified tables
   - Combines quality assessment, statistics, and identifier mapping files

4. **File Compression**
   - Compresses large files to save space while maintaining accessibility
   - Optimizes storage requirements for the consolidated output

5. **Output Generation**
   - Produces a comprehensive collection of essential files organized by module and data type
   - Creates a simplified file hierarchy for downstream analysis

## Requirements
- Completed runs of one or more VEBA modules
- Sufficient disk space for consolidated files
- The main VEBA environment must be installed and accessible

## Usage
Basic command:
```
veba --module essentials --params "-i veba_directory -o output_directory"
```

With optional parameters:
```
veba --module essentials --params "-i veba_directory -o output_directory -q -c -b"
```

Key parameters:
- `-i/--veba_directory`: Path to the VEBA output directory
- `-o/--output_directory`: Output directory for essentials (default: veba_output/essentials/)
- `-q/--include_fastq`: Flag to include trimmed/cleaned FASTQ files
- `-c/--include_scaffolds`: Flag to include scaffold assembly FASTA files
- `-b/--include_bam`: Flag to include mapped.sorted.BAM files