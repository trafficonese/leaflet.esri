
examples.dir <- 'inst/examples'

r.files <- as.list(dir(examples.dir, pattern = '.*\\.R$', full.names = TRUE))
names(r.files) <- r.files

# exclude self
r.files['inst/examples/buildExamples.R'] <- NULL
r.files <- unlist(r.files)
names(r.files) <- NULL


rmd.files <- stringr::str_c(r.files,'md')
html.files <- stringr::str_c(tools::file_path_sans_ext(r.files),'html')

r.files.mtimes <- file.info(r.files,extra_cols = FALSE)[,4]

df <- data.frame(r.file=r.files, r.file.mtime = r.files.mtimes,
                 rmd.file = rmd.files, html.file = html.files,
                 stringsAsFactors = FALSE)

rm(r.files, rmd.files, html.files, r.files.mtimes)

purrr::pwalk(df, function(r.file, r.file.mtime, rmd.file, html.file) {
  if(!file.exists(rmd.file) || file.info(rmd.file)[,4] < r.file.mtime ) {
    knitr::spin(r.file, knit = FALSE, format = 'Rmd')
    rmarkdown::render(rmd.file,'html_document')
  }
})

rm(df)