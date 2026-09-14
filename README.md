\# Fungal Genome Explorer



\## Colletotrichum Genome Assembly Statistics and Basic Quality Assessment



\### Project Overview



This project explores publicly available \*Colletotrichum\* genome assemblies from the NCBI Genome database. The analysis focuses on basic genome assembly statistics, metadata exploration, and comparative assessment of assembly characteristics across representative \*Colletotrichum\* species.



The project was developed as a reproducible bioinformatics workflow using the NCBI Datasets command-line tools and R.



\### Objectives



\* Explore publicly available \*Colletotrichum\* genome assemblies.

\* Compare genome size and GC content among representative genomes.

\* Evaluate assembly fragmentation using contig counts and N50 statistics.

\* Examine relationships between genome size, GC content, and assembly fragmentation.

\* Create reproducible tables and visualizations using R.

\* Build a transparent, reproducible bioinformatics workflow suitable for GitHub.



\### Data Source



Genome assembly metadata were retrieved from the \*\*NCBI Genome database\*\* using the NCBI Datasets command-line tool.



The initial dataset contained \*\*465 \*Colletotrichum\* genome assemblies\*\*.



To reduce overrepresentation of species with multiple assemblies, one representative assembly was selected for each species using the following priority:



1\. Complete Genome

2\. Chromosome

3\. Scaffold

4\. Contig



Within the same assembly level, RefSeq assemblies were prioritized, followed by assemblies with fewer contigs.



This resulted in \*\*134 representative species-level assemblies\*\*.



\### Main Variables



The analysis included:



\* Genome size (Mb)

\* GC content (%)

\* Number of contigs

\* Contig N50 (kb)

\* Scaffold N50 (kb)

\* Assembly level

\* Organism/species

\* Assembly accession

\* Host information

\* Geographic information

\* BioProject information



\### Assembly Fragmentation



For descriptive analysis, representative genomes were classified into three fragmentation categories based on the distribution of contig counts within this dataset:



\* Low

\* Moderate

\* High



These categories are \*\*dataset-derived descriptive categories\*\*, not universal biological or assembly-quality thresholds.



\### Main Findings



Across the 134 representative assemblies:



\* Median genome size was approximately \*\*56.1 Mb\*\*.

\* Mean genome size was approximately \*\*59.0 Mb\*\*.

\* Genome size ranged from approximately \*\*44.1 to 146.0 Mb\*\*.

\* Median GC content was approximately \*\*52%\*\*.

\* Median contig count was approximately \*\*739\*\*.

\* Scaffold-level assemblies represented the largest assembly-level category.



Genome size showed little evidence of a monotonic association with assembly fragmentation:



\*\*Spearman's ρ = 0.085, p = 0.328\*\*



Genome size showed a strong negative association with GC content:



\*\*Spearman's ρ = −0.651, p < 2.2 × 10⁻¹⁶\*\*



These associations are descriptive and do not imply causal relationships.



\### Visualizations



The project generates the following figures:



1\. Genome size distribution

2\. Genome size vs. number of contigs

3\. Genome size vs. GC content

4\. Assembly fragmentation profile

5\. Assembly level and fragmentation profile



\### Project Structure



```text

Fungal\_Genome\_Explorer/

│

├── data/

│   ├── colletotrichum\_genomes.jsonl

│   ├── colletotrichum\_metadata.tsv

│   └── colletotrichum\_representative\_genomes.tsv

│

├── scripts/

│   └── 01\_metadata\_analysis.R

│

├── results/

│   ├── colletotrichum\_assembly\_qc\_summary.tsv

│   └── top10\_most\_fragmented\_genomes.tsv

│

├── figures/

│   ├── genome\_size\_distribution.png

│   ├── genome\_size\_vs\_contigs.png

│   ├── genome\_size\_vs\_gc.png

│   ├── assembly\_fragmentation.png

│   └── assembly\_level\_fragmentation.png

│

├── .gitignore

├── Fungal Genome Explorer.Rproj

└── README.md

```



\### Tools Used



\* NCBI Datasets CLI

\* R

\* RStudio

\* tidyverse

\* janitor

\* ggplot2

\* Git

\* GitHub



\### Reproducibility



The analysis workflow is stored in:



```text

scripts/01\_metadata\_analysis.R

```



The script reads the processed NCBI metadata, performs data cleaning and representative assembly selection, generates the analyses and figures, and exports the main result tables.



\### Limitations



This project is intended as a foundational genome-bioinformatics portfolio project.



The analysis is based on publicly available assembly metadata and does not constitute a comprehensive assessment of genome quality. Assembly quality can also depend on factors such as sequencing technology, read quality, genome completeness, contamination, repeat content, and annotation quality.



The fragmentation categories used here are dataset-derived and should not be interpreted as universal assembly-quality standards.



\### Future Extensions



Possible future extensions include:



\* FASTA-level sequence quality assessment

\* BUSCO-based completeness assessment

\* Genome annotation comparison

\* Repetitive element analysis

\* Ortholog analysis

\* Comparative genomics

\* Phylogenomic analysis

\* Pathogenicity-related gene exploration



\---



\*\*Author:\*\* Sadikul Islam Nayon

\*\*Field:\*\* Forestry, Plant Pathology, Mycology \& Bioinformatics

\*\*Platform:\*\* GitHub



