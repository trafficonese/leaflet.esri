#' ---
#' title: "Esri Multiple Feature Layers"
#' author: "Bhaskar V. Karambelkar"
#' ---

#' This is a reproduction of http://portal.gulfcouncil.org/coral.html
#' using FeatureLayers from http://portal.gulfcouncil.org/arcgis/rest/services/CoralWorkingGroup/GMFMCCoralandCoralReefs/MapServer
#' <br/><br/>

library(leaflet.esri)


l <- leaflet(width = "100%") %>% setView(-87.0369, 28.9072, 5)


# Add a choice of BaseMaps
purrr::walk(
  esriBasemapLayers,
  function(basemap) {
    l <<- l %>% addEsriBasemapLayer(
      key = basemap, autoLabels = TRUE,
      group = basemap,
      options = list(detectRetina = TRUE))
  })


# Map FeatureLayer Names to IDs
layers <- list(
  "Black Coral" = 0,
  "Stony Coral" = 1,
  "Octocoral" = 2,
  "Sea Pen" = 3,
  "Sponge" = 4,
  "50 Meter Bathymetry Contour" = 5,
  "200 Meter Bathymetry Contour" = 6,
  "500 Meter Bathymetry Contour" = 7,
  "1000 Meter Bathymetry Contour" = 8)

purrr::walk(names(layers), function(featureName) {
  l <<- l %>%
    addEsriFeatureLayer(
      url = sprintf("http://portal.gulfcouncil.org/arcgis/rest/services/CoralWorkingGroup/GMFMCCoralandCoralReefs/MapServer/%d", layers[[featureName]]),
      useServiceSymbology = TRUE, group = featureName,
      options = featureLayerOptions(useCors = FALSE))
})

l %>%
  addLayersControl(baseGroups = names(esriBasemapLayers), overlayGroups = names(layers))
