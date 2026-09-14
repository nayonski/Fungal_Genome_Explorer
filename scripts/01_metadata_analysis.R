dir.create("data")
dir.create("scripts")
dir.create("results")
dir.create("figures")
list.dirs(recursive = FALSE)
install.packages(c("tidyverse", "janitor"))
library(tidyverse)
library(janitor)
meta <- read_tsv("data/colletotrichum_metadata.tsv")

glimpse(meta)
names(meta)
meta_clean <- clean_names(meta)
head(meta_clean)
names(meta_clean)
meta_clean <- meta_clean %>%
  mutate(
    genome_size_mb = assembly_stats_total_sequence_length / 1e6,
    gc_percent = as.numeric(assembly_stats_gc_percent),
    contig_count = as.numeric(assembly_stats_number_of_contigs),
    contig_n50_kb = as.numeric(assembly_stats_contig_n50) / 1000,
    scaffold_n50_kb = as.numeric(assembly_stats_scaffold_n50) / 1000
  )
summary(
  meta_clean %>%
    select(
      genome_size_mb,
      gc_percent,
      contig_count,
      contig_n50_kb,
      scaffold_n50_kb
    )
)
meta_clean %>%
  summarise(
    total_genomes = n(),
    missing_gc = sum(is.na(gc_percent)),
    missing_genome_size = sum(is.na(genome_size_mb)),
    missing_contigs = sum(is.na(contig_count)),
    missing_contig_n50 = sum(is.na(contig_n50_kb)),
    missing_scaffold_n50 = sum(is.na(scaffold_n50_kb))
  )
meta_clean %>%
  arrange(contig_count) %>%
  select(
    assembly_accession,
    organism_name,
    genome_size_mb,
    gc_percent,
    contig_count,
    contig_n50_kb,
    scaffold_n50_kb,
    assembly_level
  ) %>%
  slice_head(n = 10)
meta_clean %>%
  arrange(desc(contig_count)) %>%
  select(
    assembly_accession,
    organism_name,
    genome_size_mb,
    gc_percent,
    contig_count,
    contig_n50_kb,
    scaffold_n50_kb,
    assembly_level
  ) %>%
  slice_head(n = 10)

#Identify duplicate assemblies
meta_clean %>%
  count(organism_name, sort = TRUE) %>%
  slice_head(n = 20)
meta_clean %>%
  filter(str_detect(assembly_accession, "^GCF")) %>%
  summarise(refseq_genomes = n())
meta_clean %>%
  filter(str_detect(assembly_accession, "^GCA")) %>%
  summarise(genbank_genomes = n())


meta_representative <- meta_clean %>%
  mutate(
    refseq = str_detect(assembly_accession, "^GCF")
  ) %>%
  group_by(organism_name) %>%
  arrange(desc(refseq), contig_count, .by_group = TRUE) %>%
  slice_head(n = 1) %>%
  ungroup()

nrow(meta_representative)
meta_representative %>%
  count(organism_name) %>%
  filter(n > 1)

meta_representative %>%
  count(assembly_level, sort = TRUE)


#Step 8 — Improve representative selection

meta_representative <- meta_clean %>%
  mutate(
    refseq = str_detect(assembly_accession, "^GCF"),
    assembly_priority = case_when(
      assembly_level == "Complete Genome" ~ 4,
      assembly_level == "Chromosome" ~ 3,
      assembly_level == "Scaffold" ~ 2,
      assembly_level == "Contig" ~ 1,
      TRUE ~ 0
    )
  ) %>%
  group_by(organism_name) %>%
  arrange(
    desc(assembly_priority),
    desc(refseq),
    contig_count,
    .by_group = TRUE
  ) %>%
  slice_head(n = 1) %>%
  ungroup()
nrow(meta_representative)
meta_representative %>%
  count(assembly_level, sort = TRUE)
write_tsv(
  meta_representative,
  "data/colletotrichum_representative_genomes.tsv"
)
file.exists("data/colletotrichum_representative_genomes.tsv")
file.info("data/colletotrichum_representative_genomes.tsv")$size
