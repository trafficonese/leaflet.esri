#' ---
#' title: "Esri Image Layers"
#' author: "Bhaskar V. Karambelkar"
#' ---

library(leaflet.esri)

#' ### Examples 1 & 2
#' Simple examples. In Example 1 we need to disable CORS as the ArcGIS ver. is old and doesn't support cors.<br/><br/>

leaflet() %>%
  addEsriBasemapLayer(esriBasemapLayers$Gray) %>%
  setView(30, 0, 3) %>%
  addEsriImageMapLayer(
    url = "https://sampleserver3.arcgisonline.com/ArcGIS/rest/services/World/MODIS/ImageServer",
    options = imageMapLayerOptions(useCors = FALSE))

#' <br/><br/>

leaflet() %>%
  addEsriBasemapLayer(esriBasemapLayers$Gray) %>%
  setView(-96.8, 38.5, 4) %>%
  addEsriImageMapLayer(
    url = "https://seamlessrnc.nauticalcharts.noaa.gov/arcgis/rest/services/RNC/NOAA_RNC/ImageServer")

#' ### Example 3
#' Custom band Ids for infrared image layer.<br/><br/>

leaflet() %>%
  addEsriBasemapLayer(esriBasemapLayers$Imagery) %>%
  setView(-120.23, 43.5, 5)  %>%
  addEsriImageMapLayer(
    url = "http://imagery.oregonexplorer.info/arcgis/rest/services/NAIP_2011/NAIP_2011_Dynamic/ImageServer",
    options = imageMapLayerOptions(bandIds = c(3, 0, 1)))

#' ### Example 4
#' Custom rendering rule. Display an Image Service from ArcGIS Online or ArcGIS Server and apply a rendering rule to dynamically modify the display of the raster dataset. Rendering rules are created using a pre-defined set of raster functions contained in the ArcGIS Server 10 REST API. This example shows a raster image generated from raw LIDAR (Light Detection and Ranging) data rendered with a hillshade.<br/><br/>

renderingRule <- list(
  "rasterFunction" = "Hillshade",
  "rasterFunctionArguments" = list(
    "Azimuth" = 215,
    "Altitude" = 60,
    "ZFactor" = 1
  ), "variableName" = "DEM")

leaflet() %>%
  addEsriBasemapLayer(esriBasemapLayers$Imagery) %>%
  setView(-116.184826, 33.741114, 17) %>%
  addEsriImageMapLayer(
    url = "https://sampleserver3.arcgisonline.com/ArcGIS/rest/services/Earthquakes/SanAndreasLidar/ImageServer",
    options = imageMapLayerOptions(
      useCors = FALSE, renderingRule = renderingRule))

#' ### Example 5
#' Identifying features. Display an Image Service from ArcGIS Online or ArcGIS Server and get the pixel value at a specific location. This sample displays a didgital elevation model (DEM) for the state of California rendered with a hillshade (see ImageMapLayer RenderingRule sample). Clicking on map returns the raw DEM value for that location (elevation in meters).<br/><br/>

leaflet() %>%
  #addEsriBasemapLayer(esriBasemapLayers$Imagery) %>%
  setView(-118.253147, 36.230577, 10) %>%
  addEsriImageMapLayer(
    url = "https://sampleserver3.arcgisonline.com/ArcGIS/rest/services/Earthquakes/CaliforniaDEM/ImageServer",
    options = imageMapLayerOptions(
      useCors = FALSE, renderingRule = renderingRule),
    layerId = "hillshade") %>%
  addControl("Click map for elevation",
             layerId = "pixelValue", position = "topright") %>%
  htmlwidgets::onRender(htmlwidgets::JS(
    "function(el, x, data) {
      var map = this;
      var identifiedPixel;
      var pane = document.getElementById(\"pixelValue\");
      var hillshade =  map.layerManager._byLayerId[\"tile\\nhillshade\"];

      map.on(\"click\", function (e) {
        if (identifiedPixel){
          pane.innerHTML = \"Loading\";
        }
        hillshade.identify().at(e.latlng).run(function(error, results){
          identifiedPixel = results.pixel;
          pane.innerHTML = identifiedPixel.properties.value + \"m\";
        });
      });
    }"))

#' ### Example 6
#' Mosaic rule. Display an Image Service from ArcGIS Online or ArcGIS Server and apply a mosaic rule to dynamically control how the service combines rasters into a mosaic. This sample shows world temperature using the 8th raster only (August of 1950).<br/><br/>

mosaicRule <- list(
  mosaicMethod = "esriMosaicLockRaster",
  lockRasterIds = list(8)
)

leaflet() %>%
  addEsriBasemapLayer(esriBasemapLayers$Imagery) %>%
  setView(30, 20, 1) %>%
  addEsriImageMapLayer(
    url = "https://sampleserver3.arcgisonline.com/ArcGIS/rest/services/World/Temperature/ImageServer",
    options = imageMapLayerOptions(useCors = FALSE, mosaicRule = mosaicRule))
