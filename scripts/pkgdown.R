
# devtools::install("r-lib/pkgdown")

rmarkdown::render("README.Rmd", output_file = "README.md")
pkgdown::build_site()
