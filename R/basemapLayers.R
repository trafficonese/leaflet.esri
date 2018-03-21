#' Esri Basemap Layers.
#'
#' BasemapLayer is used to display Esri hosted basemaps and attributes data providers appropriately. The Terms of Use for Esri hosted services apply to all Leaflet applications.
#' Taken from \url{https://esri.github.io/esri-leaflet/api-reference/layers/basemap-layer.html}.
#' @export
esriBasemapLayers <- list(
  "Streets" = "Streets",
  "Topographic" = "Topographic",
  "NationalGeographic" = "NationalGeographic",
  "Oceans" = "Oceans",
  "Gray" = "Gray",
  "DarkGray" = "DarkGray",
  "Imagery" = "Imagery",
  "ShadedRelief" = "ShadedRelief",
  "Terrain" = "Terrain")

#' Esri basemap labels.
#'
#' Taken from \url{https://esri.github.io/esri-leaflet/api-reference/layers/basemap-layer.html#optional-labels}.
#' @export
esriBasemapLabels <- list(
  "OceansLabels" = "OceansLabels",
  "GrayLabels" = "GrayLabels",
  "DarkGrayLabels" = "DarkGrayLabels",
  "ImageryLabels" = "ImageryLabels",
  "ImageryTransportation" = "ImageryTransportation",
  "ShadedReliefLabels" = "ShadedReliefLabels",
  "TerrainLabels" = "TerrainLabels"
)

#' Adds a ArcGIS Basemap layer
#' @param map The leaflet map
#' @param key ID of the layer
#' @param autoLabels whether to show corresponding labels layer
#' @param layerId Unique ID for the layer
#' @param group The group this layer belongs to.
#' @param options Basemap Layer Options. You can pass \code{\link[leaflet]{tileOptions}()}.
#' @examples \dontrun{
#' leaflet() %>%
#'    addEsriBasemapLayer(esriBasemapLayers$Oceans, autoLabels = TRUE)
#' }
#' @export
addEsriBasemapLayer <- function(
  map, key, autoLabels = FALSE,
  layerId = NULL, group = NULL,
  options = NULL) {

  map <- addEsriDependency(map)

  if (is.null(options)) {
    options <- list()
  }

  if (!(key %in% esriBasemapLayers || key %in% esriBasemapLabels)) {
    stop("Invalid Basemap layer Key")
  }

  labelLayer <- NULL
  if (autoLabels) {
    labelLayer <- esriBasemapLabels[[sprintf("%sLabels", key)]]
  }

  leaflet::invokeMethod(
    map, leaflet::getMapData(map),
    "addEsriBasemapLayer", key, labelLayer, layerId, group, options)

}
