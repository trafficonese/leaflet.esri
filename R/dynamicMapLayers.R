#' Options for dynamic map layer.
#'
#' @param format Output format of the image.
#' @param transparent Allow the server to produce transparent images.
#' @param f Server response content type.
#' @param attribution Attribution from service metadata copyright text is automatically displayed in Leaflet's default control. This property can be used for customization.
#' @param layers An array of Layer IDs like [3, 4, 5] to show from the service.
#' @param layerDefs A string representing a query to run against the service before the image is rendered. This can be a string like "3:STATE_NAME="Kansas"" or an object mapping different queries to specific layers {3:"STATE_NAME="Kansas"", 2:"POP2007>25000"}.
#' @param opacity Opacity of the layer. Should be a value between 0 (completely transparent) and 1 (completely opaque).
#' @param position Position of the layer relative to other overlays.
#' @param maxZoom Closest zoom level the layer will be displayed on the map.
#' @param minZoom Furthest zoom level the layer will be displayed on the map.
#' @param dynamicLayers JSON object literal used to manipulate the layer symbology defined in the service itself. Requires a 10.1 (or above) map service which supports dynamicLayers requests.
#' @param token If you pass a token in your options it will be included in all requests to the service.
#' @param proxy URL of an \href{https://developers.arcgis.com/javascript/jshelp/ags_proxy.html}{ArcGIS API for JavaScript proxy} or \href{https://github.com/Esri/resource-proxy}{ArcGIS Resource Proxy} to use for proxying requests.
#' @param useCors If this service should use CORS when making GET requests.
#' @param ... extra options
#' @export
dynamicMapLayerOptions <- function(
  format = "png24",
  transparent = TRUE,
  f = "json",
  attribution = "",
  layers = NULL,
  layerDefs = NULL,
  opacity = 1,
  position = "front",
  maxZoom = NULL,
  minZoom = NULL,
  dynamicLayers = NULL,
  token = NULL,
  proxy = NULL,
  useCors = TRUE,
  ...
) {
  leaflet::filterNULL(list(
    format = format,
    transparent = transparent,
    f = f,
    attribution = attribution,
    layers = layers,
    layerDefs = layerDefs,
    opacity = opacity,
    position = position,
    maxZoom = maxZoom,
    minZoom = minZoom,
    dynamicLayers = dynamicLayers,
    token = token,
    proxy = proxy,
    useCors = useCors,
    ...

  ))
}

#' Render and visualize Map Services from ArcGIS Online and ArcGIS Server.
#'
#' Map Services are a way to expose the contents of a map as a web service and
#' expose capabilities for exporting tile images, querying and
#' identifying features and more.
#' Also supports custom popups and identification of features.
#' @param map The leaflet map
#' @param url URL of the \href{http://resources.arcgis.com/en/help/arcgis-rest-api/#/Map_Service/02r3000000w2000000/}{Map Service}.
#' @param options options for the dynamic map layer.
#' @param popupFunction Uses the provided function to create a popup that will
#'   identify features whenever the map is clicked.
#'   Your function will be passed a GeoJSON FeatureCollection of the features
#'    at the clicked location and should return the appropriate HTML.
#'    If you do not want to open the popup when there are no results, return false.
#' @param popupOptions See \code{\link[leaflet]{popupOptions}}.
#' @param layerId A unique ID for the layer.
#' @param group The name of the group this layer should be added to.
#' @export
addEsriDynamicMapLayer <- function(
  map, url,
  options = dynamicMapLayerOptions(),
  popupFunction = NULL, popupOptions = NULL,
  layerId = NULL, group = NULL) {
  map <- addEsriDependency(map)
  if (is.null(options)) {
    options <- list()
  }
  leaflet::invokeMethod(
    map, leaflet::getMapData(map),
    "addEsriDynamicMapLayer", url, layerId, group,
    options, popupFunction, popupOptions)
}
