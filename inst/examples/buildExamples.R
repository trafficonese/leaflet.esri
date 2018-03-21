
examples_dir <- "inst/examples"

r_files <- as.list(dir(examples_dir, pattern = ".*\\.R$", full.names = TRUE))
names(r_files) <- r_files

# exclude self
r_files["inst/examples/buildExamples.R"] <- NULL
r_files <- unlist(r_files)
names(r_files) <- NULL


rmd_files <- stringr::str_c(r_files, "md")
html_files <- stringr::str_c(tools::file_path_sans_ext(r_files), "html")

r_files_mtimes <- file.info(r_files, extra_cols = FALSE)[, 4]

df <- data.frame(r_file = r_files, r_file_mtime = r_files_mtimes,
                 rmd_file = rmd_files, html_file = html_files,
                 stringsAsFactors = FALSE)

rm(r_files, rmd_files, html_files, r_files_mtimes)

purrr::pwalk(df, function(r_file, r_file_mtime, rmd_file, html_file) {
  if (!file.exists(rmd_file) || file.info(rmd_file)[, 4] < r_file_mtime ) {
    knitr::spin(r_file, knit = FALSE, format = "Rmd")
    rmarkdown::render(rmd_file, "html_document")
  }
})

rm(df)
