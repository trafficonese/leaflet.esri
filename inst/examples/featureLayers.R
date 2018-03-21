#' ---
#' title: "Esri Feature Layers"
#' author: "Bhaskar V. Karambelkar"
#' ---

library(leaflet.esri)

#' ### Example 1
#' Here we use the symbology set that was used when the layer was created (`useServiceSymbology=TRUE`). We specify a property to use for labels and a custom Javascript function for popup contnets.<br/><br/>

leaflet() %>%
  addEsriBasemapLayer(esriBasemapLayers$Streets) %>%
  setView(-122.667, 45.526, 13) %>%
  addEsriFeatureLayer(
    url = "https://services.arcgis.com/rOo16HdIMeOBI4Mb/arcgis/rest/services/Heritage_Trees_Portland/FeatureServer/0",
    useServiceSymbology = TRUE,
    labelProperty = "COMMON_NAM", labelOptions = labelOptions(textsize = "12px"),
    popupProperty = JS("function(feature) { return L.Util.template(\"<h3>{COMMON_NAM}</h3><hr /><p>This tree is located at {ADDRESS} and its scientific name is {SCIENTIFIC}.\", feature.properties);}"))

#' ### Example 2 & 3
#' Here instead of using symbology set that was used to create the layer, we customize the icons used for markers.We also add custom Javascript functionality to interactively query the feature layer and filter the results.<br/><br/>

busIcons <-  awesomeIconList(
  North = makeAwesomeIcon(icon = "arrow-up", library = "fa", markerColor = "red"),
  South = makeAwesomeIcon(icon = "arrow-down", library = "fa", markerColor = "green"),
  East = makeAwesomeIcon(icon = "arrow-left", library = "fa", markerColor = "blue"),
  West = makeAwesomeIcon(icon = "arrow-right", library = "fa", markerColor = "darkpurple")
)

control <- '<div id="query">
<label>
Bus Direction
<select id="direction">
<!-- make sure to encase string values in single quotes for valid sql -->
<option value=\"1=1\">Any</option>
<option value="direction=\"North\"">North</option>
<option value="direction=\"South\"">South</option>
<option value="direction=\"East\"">East</option>
<option value="direction=\"West\"">West</option>
</select>
</label>
</div>'


leaflet() %>%
  addEsriBasemapLayer(esriBasemapLayers$Streets) %>%
  setView(-122.667, 45.526, 15) %>%
  addEsriFeatureLayer(
    url = "https://services.arcgis.com/rOo16HdIMeOBI4Mb/arcgis/rest/services/Trimet_Transit_Stops/FeatureServer/0", layerId = "busStops",
    labelProperty = "stop_name",
    markerIconProperty = "direction",
    markerOptions = markerOptions(opacity = 0.8, riseOnHover = TRUE),
    markerIcons = busIcons) %>%
  addControl(control, position = "topright") %>%
  htmlwidgets::onRender(JS("
    function(el, x, data) {
      var myMap = this;
      var direction = document.getElementById(\"direction\");
      direction.addEventListener(
        \"change\",
        function() {
          myMap.layerManager._byLayerId[\"geojson\\nbusStops\"].setWhere(direction.value);
        });
    }"))

#' <br/><br/>In example 3 we show how to enable clustering of markers.<br/><br/>

leaflet() %>%
  addEsriBasemapLayer(esriBasemapLayers$Streets) %>%
  setView(-122.667, 45.526, 15) %>%
  addEsriFeatureLayer(
    url = "https://services.arcgis.com/rOo16HdIMeOBI4Mb/arcgis/rest/services/Trimet_Transit_Stops/FeatureServer/0", layerId = "busStops",
    labelProperty = "stop_name",
    markerIconProperty = "direction",
    markerOptions = markerOptions(opacity = 0.8, riseOnHover = TRUE),
    markerIcons = busIcons,
    clusterOptions = markerClusterOptions()
    )

#' ### Example 4 & 5
#' Here we generate a heat map first with default options and next with customized colors.<br/><br/>

leaflet() %>%
  addEsriBasemapLayer(esriBasemapLayers$Gray) %>%
  setView(-73.926, 40.706, 12) %>%
  addEsriHeatmapFeatureLayer(
    url = "https://services.arcgis.com/rOo16HdIMeOBI4Mb/ArcGIS/rest/services/Graffiti_Reports/FeatureServer/0",
    radius = 12)

#' <br/><br/>

leaflet() %>%
  addEsriBasemapLayer(esriBasemapLayers$Gray) %>%
  setView(-73.926, 40.706, 12) %>%
  addEsriHeatmapFeatureLayer(
    url = "https://services.arcgis.com/rOo16HdIMeOBI4Mb/ArcGIS/rest/services/Graffiti_Reports/FeatureServer/0",
    radius = 12,
    gradient = list(
        `0.2` = "#ffffb2",
        `0.4` = "#fd8d3c",
        `0.6` = "#fd8d3c",
        `0.8` = "#f03b20",
        `1` = "#bd0026"
    ))

#' ### Example 6
#' Here you see a feature with polygon data and customized styling.

leaflet() %>%
  addEsriBasemapLayer(esriBasemapLayers$Gray) %>%
  setView(-118.22, 33.836, 8) %>%
  addEsriFeatureLayer(
    url = "https://services.arcgis.com/P3ePLMYs2RVChkJx/arcgis/rest/services/USA_Congressional_Districts/FeatureServer/0",
    labelProperty = JS("function(feature){var props = feature.properties; return props.LAST_NAME+\", \"+props.NAME+ \" [\"+props.PARTY+\"]\"}"),
    popupProperty = JS("function(feature){var props = feature.properties; return props.LAST_NAME+\", \"+props.NAME+ \" [\"+props.PARTY+\"]\"}"),
    color = "#000000", weight = 1, fillOpacity = 0.5,
    highlightOptions = highlightOptions(weight = 2, fillOpacity = 0.8, bringToFront = TRUE,
                                        sendToBack = TRUE),
    options = featureLayerOptions(
      simplifyFactor = 0.5, precision = 5,
      style = JS("function(feature){
                    var props = feature.properties;
                    if (props.PARTY === \"Democrat\"){
                        return {fillColor: \"blue\"};
                    } else if (props.PARTY === \"Republican\"){
                        return {fillColor: \"red\"};
                    } else {
                        return {fillColor: \"white\"};
                    }
                 }")))
