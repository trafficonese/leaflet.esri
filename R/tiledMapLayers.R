# http://esri.github.io/esri-leaflet/api-reference/layers/tiled-map-layer.html
#' Options for TiledMapLayer.
#'
#' @param correctZoomLevels Correct Zoom levels.
#' @param zoomOffsetAllowance If correctZoomLevels is enabled this controls the amount of tolerance for the difference at each scale level for remapping tile levels.
#' @param proxy URL of an \href{https://developers.arcgis.com/javascript/jshelp/ags_proxy.html}{ArcGIS API for JavaScript proxy} or \href{https://github.com/Esri/resource-proxy}{ArcGIS Resource Proxy} to use for proxying requests.
#' @param useCors Dictates if the service should use CORS when making GET requests.
#' @param token Use this token to authenticate all calls to the service.
#' @param tileOptions Other options for tile layer. You can pass \code{\link[leaflet]{tileOptions}()}.
#' @export
tiledMapLayerOptions <- function(
  correctZoomLevels = TRUE,
  zoomOffsetAllowance  = 0.1,
  proxy = NULL,
  useCors = TRUE,
  token = NULL,
  tileOptions = NULL
) {
  leaflet::filterNULL(c(list(
    correctZoomLevels = correctZoomLevels,
    zoomOffsetAllowance = zoomOffsetAllowance,
    proxy = proxy,
    useCors = useCors,
    token = token
  ), tileOptions))
}

#' Access tiles from ArcGIS Online and ArcGIS Server to visualize and identify features.
#'
#' If you have published a Feature Service in ArcGIS Online, it can be used to create a static set of tiles as well. You can find details about that process in the \href{http://doc.arcgis.com/en/arcgis-online/share-maps/publish-tiles.htm#ESRI_SECTION1_F68FCBD33BD54117B23232D41A762E89}{ArcGIS Online Help}.
#' Your map service must be published using the Web Mercator Auxiliary Sphere tiling scheme (WKID 102100/3857) and the default scale options used by Google Maps, Bing Maps and \href{http://resources.arcgis.com/en/help/arcgisonline-content/index.html#//011q00000002000000}{ArcGIS Online}. Esri Leaflet will not support any other spatial reference for tile layers.
#' @param map The leaflet map
#' @param url URL of the \href{http://resources.arcgis.com/en/help/arcgis-rest-api/#/Map_Service/02r3000000w2000000}{Map Service} with a tile cache.
#' @param options options for the tiledmap layer.
#' @param layerId A unique ID for the layer.
#' @param group The name of the group this layer should be added to.
#' @export
addEsriTiledMapLayer <- function(
  map, url,
  options = tiledMapLayerOptions(),
  layerId = NULL, group = NULL) {

  map <- addEsriDependency(map)
  if (is.null(options)) {
    options <- list()
  }
  leaflet::invokeMethod(
    map, leaflet::getMapData(map),
    "addEsriTiledMapLayer", url, layerId, group, options)
}
