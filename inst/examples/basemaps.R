#' ---
#' title: "Esri Basemap Layers w/ Labels"
#' author: "Bhaskar V. Karambelkar"
#' ---

library(leaflet.esri)

basemaps <- esriBasemapLayers

# Continental US
l <- leaflet() %>% setView(-98.35, 39.5, 3)

purrr::walk(basemaps,
            function(basemap) {
              l <<- l %>% addEsriBasemapLayer(key = basemap, autoLabels = TRUE,
                                              group = basemap,
                                              options = list(detectRetina = TRUE))
            })

l %>%
  addLayersControl(baseGroups = names(basemaps))
