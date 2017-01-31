library(leaflet.esri)

leaflet() %>% setView(-99.88, 37.71, 4) %>%
  addEsriBasemapLayer(esriBasemapLayers$Gray, autoLabels = T) %>%
  addEsriDynamicMapLayer(
    url='https://services.arcgisonline.com/arcgis/rest/services/Specialty/Soil_Survey_Map/MapServer')

popupFunc <- htmlwidgets::JS(
  "function (error, featureCollection) {
    if(error || featureCollection.features.length === 0) {
      return false;
    } else {
    return 'Risk Level: ' + featureCollection.features[0].properties.CLASS_DESC;
    }
  }")

leaflet() %>% setView(-96.8, 38.5, 4) %>%
  addEsriBasemapLayer(esriBasemapLayers$Gray, autoLabels = T) %>%
  addEsriDynamicMapLayer(
    url='https://maps7.arcgisonline.com/arcgis/rest/services/USDA_USFS_2014_Wildfire_Hazard_Potential/MapServer', popupFunction = popupFunc)
