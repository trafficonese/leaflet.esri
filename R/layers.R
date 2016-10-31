#' Esri Basemap Layers from \url{https://esri.github.io/esri-leaflet/api-reference/layers/basemap-layer.html}.
#' @rdname esri-layers
#' @export
esriBasemapLayers <- list(
  'Streets' = 'Streets',
  'Topographic' = 'Topographic',
  'NationalGeographic' = 'NationalGeographic',
  'Oceans' = 'Oceans',
  'Gray' = 'Gray',
  'DarkGray' = 'DarkGray',
  'Imagery' = 'Imagery',
  'ShadedRelief' = 'ShadedRelief',
  'Terrain' = 'Terrain')

#' Esri basemap labels from \url{https://esri.github.io/esri-leaflet/api-reference/layers/basemap-layer.html#optional-labels}.
#' @rdname esri-layers
#' @export
esriBaseMapLabels <- list(
  'OceansLabels' = 'OceansLabels',
  'GrayLabels' = 'GrayLabels',
  'DarkGrayLabels' = 'DarkGrayLabels',
  'ImageryLabels' = 'ImageryLabels',
  'ImageryTransportation' = 'ImageryTransportation',
  'ShadedReliefLabels' = 'ShadedReliefLabels',
  'TerrainLabels' = 'TerrainLabels'
)

#' Adds a ArcGIS Basemap layer
#' @param map The leaflet map
#' @param key ID of the layer
#' @param autoLabels whether to show corresponding labels layer
#' @param layerId Unique ID for the layer
#' @param group The group this layer belongs to.
#' @param options Basemap Layer Options.
#' @rdname esri-layers
#' @export
addEsriBaseMapLayer <- function(
  map, key, autoLabels = FALSE,
  layerId = NULL, group = NULL,
  options = list()) {

  map <- addEsriDependency(map)

  if(!(key %in% esriBasemapLayers || key %in% esriBaseMapLabels)) {
    stop("Invalid Basemap layer Key")
  }

  labelLayer <- NULL
  if(autoLabels) {
    labelLayer <- esriBaseMapLabels[[sprintf("%sLabels",key)]]
  }

  leaflet::invokeMethod(
    map, leaflet::getMapData(map),
    'addEsriBasemapLayer', key, labelLayer, layerId, group, options)

}