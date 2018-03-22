# devtools::install_github("schloerke/viztest")
# source("scripts/viztest.R")

viztest::viztest(".", "bhaskarvk/leaflet.esri", resize = FALSE, stomp = TRUE)

viztest::viztest(".", "bhaskarvk/leaflet.esri", resize = FALSE, stomp = TRUE, skip_old = TRUE)
