#' ---
#' title: "Esri Tiled Map Layers"
#' author: "Bhaskar V. Karambelkar"
#' ---

library(leaflet.esri)

leaflet() %>% setView(-81.47, 30.70, 12) %>%
  addEsriTiledMapLayer(
    url = "https://services.arcgisonline.com/ArcGIS/rest/services/USA_Topo_Maps/MapServer")


leaflet() %>% setView(-155.04, 19.31, 9) %>%
  addEsriTiledMapLayer(
    url =  "https://services.arcgisonline.com/ArcGIS/rest/services/Specialty/World_Navigation_Charts/MapServer",
    options = tiledMapLayerOptions(tileOptions = list(minZoom = 3, maxZoom = 10)))

leaflet() %>% setView(-77.0369, 38.9072, 14) %>%
  addEsriTiledMapLayer(
    url = "https://services.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer")
