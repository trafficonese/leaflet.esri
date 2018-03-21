#' ---
#' title: "Esri Dynamic Map Layers"
#' author: "Bhaskar V. Karambelkar"
#' ---

library(leaflet.esri)

#' ### Example 1
#' Custom Javascript for identifying features.<br/><br/>

leaflet() %>% setView(-99.88, 37.71, 4) %>%
  addEsriBasemapLayer(esriBasemapLayers$Gray, autoLabels = TRUE) %>%
  addControl(html = htmltools::HTML(
    "Click on the map for Soil <a href=\"https://services.arcgisonline.com/arcgis/rest/services/Specialty/Soil_Survey_Map/MapServer\">Order/ Sub-Order"),
    layerId = "selectedFeatures", position = "bottomleft") %>%
  addEsriDynamicMapLayer(
    url = "https://services.arcgisonline.com/arcgis/rest/services/Specialty/Soil_Survey_Map/MapServer",
    layerId = "soil") %>%
  htmlwidgets::onRender(htmlwidgets::JS(
    "function(el, x, data) {
      var map = this;
      var identifiedFeature;
      var pane = document.getElementById(\"selectedFeatures\");

      var soil =  map.layerManager._byLayerId[\"tile\\nsoil\"];

      map.on(\"click\", function (e) {
        pane.innerHTML = \"Loading\";
        if (identifiedFeature){
          map.removeLayer(identifiedFeature);
        }
        soil.identify().on(map).at(e.latlng).run(function(error, featureCollection){
          // make sure at least one feature was identified.
          if (featureCollection.features.length > 0) {
            identifiedFeature = L.geoJson(featureCollection.features[0]).addTo(map);
            var soilDescription =
              featureCollection.features[0].properties[\"Dominant Order\"] +
              " - " +
              featureCollection.features[0].properties[\"Dominant Sub-Order\"];
            pane.innerHTML = soilDescription;
          }
          else {
            pane.innerHTML = \"No features identified.\";
          }
        });
      });
    }"))

#' ### Example 2
#' Custom popup function.<br/><br/>

popupFunc <- htmlwidgets::JS(
  "function (error, featureCollection) {
    if (error || featureCollection.features.length === 0) {
      return false;
    } else {
    return \"Risk Level: \" + featureCollection.features[0].properties.CLASS_DESC;
    }
  }")

leaflet() %>% setView(-96.8, 38.5, 4) %>%
  addEsriBasemapLayer(esriBasemapLayers$Gray, autoLabels = TRUE) %>%
  addEsriDynamicMapLayer(
    url = "https://maps7.arcgisonline.com/arcgis/rest/services/USDA_USFS_2014_Wildfire_Hazard_Potential/MapServer", popupFunction = popupFunc)
