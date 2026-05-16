library(Biostrings)

source("~/.Rprofile")
fa_file <- paste0(.get_config_path("REF_GENOME_DIR"), "hg38_main_chroms.fa")
out_file <- paste0(.get_config_path("REF_GENOME_DIR"), "hg38_N_runs_min10.bed")
fa <- readDNAStringSet(fa_file)
con <- file(out_file, "w")

for (chr in names(fa)) {
  print(chr)
  x <- toupper(as.character(fa[[chr]]))
  hits <- gregexpr("N+", x)[[1]]
  if (hits[1] == -1) next
  widths <- attr(hits, "match.length")
  keep <- widths >= 10
  if (!any(keep)) next

  starts <- hits[keep]
  ends <- starts + widths[keep] - 1

  bed <- data.frame(chr = chr, start = starts - 1, end = ends, name = "N_run", score = 0, strand = "+")
  write.table(bed, con, sep = "\t", quote = FALSE, row.names = FALSE, col.names = FALSE)
}

close(con)
