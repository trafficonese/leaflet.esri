devtools::install_github("schloerke/viztest")
# source("scripts/viztest.R")


viztest::viztest(".", "leaflet.esri", resize = FALSE, stomp = TRUE)
