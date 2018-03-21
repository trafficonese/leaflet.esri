#' Options for image map layer.
#'
#' @param format Output format of the image.
#' @param f Server response content type.
#' @param opacity Opacity of the layer. Should be a value between 0 and 1.
#' @param position Position of the layer relative to other overlays.
#' @param maxZoom Closest zoom level the layer will be displayed on the map.
#' @param minZoom Furthest zoom level the layer will be displayed on the map.
#' @param from Date When paired with to defines the time range of data to display.
#' Requires the Image Layer to be time enabled.
#' @param to Date When paired with from defines the time range of data to display.
#' Requires the Image Layer to be time enabled.
#' @param bandIds If there are multiple bands, you can specify which bands to export.
#' @param noData The pixel value representing no information.
#' @param noDataInterpretation Interpretation of the noData setting.
#' @param pixelType Leave pixelType as unspecified, or UNKNOWN, in most exportImage use cases,
#'   unless such pixelType is desired.
#'   Possible values: C128, C64, F32, F64, S16, S32, S8, U1, U16, U2, U32, U4, U8, UNKNOWN.
#' @param renderingRule A JSON representation of a \href{http://resources.arcgis.com/en/help/arcgis-rest-api/#/Raster_function_objects/02r3000000rv000000/}{raster function}
#' @param mosaicRule A JSON representation of a \href{http://resources.arcgis.com/en/help/arcgis-rest-api/#/Mosaic_rule_objects/02r3000000s4000000/}{mosaic rule}
#' @param token If you pass a token in your options it will be included in all requests to the service.
#' @param proxy URL of an \href{https://developers.arcgis.com/javascript/jshelp/ags_proxy.html}{ArcGIS API for JavaScript proxy} or \href{https://github.com/Esri/resource-proxy}{ArcGIS Resource Proxy} to use for proxying requests.
#' @param useCors If this service should use CORS when making GET requests.
#' @param ... extra options
#' @export
imageMapLayerOptions <- function(
  format = "jpgpng",
  f = "json",
  opacity = 1,
  position = "front",
  maxZoom = NULL,
  minZoom = NULL,
  from = NULL,
  to = NULL,
  bandIds = NULL,
  noData = NULL,
  noDataInterpretation = NULL,
  pixelType = NULL,
  renderingRule = NULL,
  mosaicRule = NULL,
  token = NULL,
  proxy = NULL,
  useCors = TRUE,
  ...
) {
  leaflet::filterNULL(list(
    format = format,
    f = f,
    opacity = opacity,
    position = position,
    maxZoom = maxZoom,
    minZoom = minZoom,
    from = from,
    to = to,
    bandIds = bandIds,
    noData = noData,
    noDataInterpretation = noDataInterpretation,
    pixelType = pixelType,
    renderingRule = renderingRule,
    mosaicRule = mosaicRule,
    token = token,
    proxy = proxy,
    useCors = useCors,
    ...
  ))
}

#' Render and visualize Image Services from ArcGIS Online and ArcGIS Server.
#'
#' Image Services provide access to raster data through a web service.
#' @param map The leaflet map
#' @param url URL of the \href{http://resources.arcgis.com/en/help/arcgis-rest-api/#/Image_Service/02r3000000q8000000/}{Image Service}
#' @param options options for the image map layer.
#' @param popupFunction Uses the provided function to create a popup that will
#'   identify features whenever the map is clicked.
#'   Your function will be passed a GeoJSON FeatureCollection of the features
#'    at the clicked location and should return the appropriate HTML.
#'    If you do not want to open the popup when there are no results, return false.
#' @param popupOptions See \code{\link[leaflet]{popupOptions}}.
#' @param layerId A unique ID for the layer.
#' @param group The name of the group this layer should be added to.
#' @export
addEsriImageMapLayer <- function(
  map, url,
  options = imageMapLayerOptions(),
  popupFunction = NULL, popupOptions = NULL,
  layerId = NULL, group = NULL) {
  map <- addEsriDependency(map)
  if (is.null(options)) {
    options <- list()
  }
  leaflet::invokeMethod(
    map, leaflet::getMapData(map),
    "addEsriImageMapLayer", url, layerId, group,
    options, popupFunction, popupOptions)
}
