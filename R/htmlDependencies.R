esriDependency <- function() {
  list(
    htmltools::htmlDependency(
      "esri.leaflet", version = "1.0.4",
      system.file("htmlwidgets/lib/esri", package = "leaflet.esri"),
      script = c("esri-leaflet.js", "esri-leaflet-bindings.js")
    )
  )
}

#' Adds esri-leaflet dependency to the leaflet widget
#' @param map The leaflet map widget
#' @export
#' @rdname esri-dependencies
addEsriDependency <- function(map) {
  map$dependencies <- c(map$dependencies, esriDependency())
  map
}

esriClusterDependency <- function() {
  list(
    htmltools::htmlDependency(
      "esri.leaflet.cluster", version = "1.0.2",
      system.file("htmlwidgets/lib/esri-cluster", package = "leaflet.esri"),
      script = c("esri-leaflet-clustered-feature-layer-src.js")
    )
  )
}

#' Adds esri-leaflet-clustered-feature-layer dependency to the leaflet widget
#' @export
#' @rdname esri-dependencies
addEsriClusterDependency <- function(map) {
  map$dependencies <- c(map$dependencies,
                        esriDependency(),
                        leaflet::leafletDependencies$markerCluster(),
                        esriClusterDependency())
  map
}

esriGeocoderDependency <- function() {
  list(
    htmltools::htmlDependency(
      "esri.leaflet.geocoder", version = "1.0.2",
      system.file("htmlwidgets/lib/esri-geocoder", package = "leaflet.esri"),
      script = c("esri-leaflet-geocoder.js"),
      stylesheet = c("esri-leaflet-geocoder.css")
    )
  )
}

#' Adds esri-leaflet-geocoder dependency to the leaflet widget
#' @export
#' @rdname esri-dependencies
addEsriGeocoderDependency <- function(map) {
  map$dependencies <- c(map$dependencies,
                        esriDependency(),
                        esriGeocoderDependency())
  map
}

esriHeatmapDependency <- function() {
  list(
    htmltools::htmlDependency(
      "esri.leaflet.heatmap", version = "1.0.2",
      system.file("htmlwidgets/lib/esri-heatmap", package = "leaflet.esri"),
      script = c("leaflet-heat.js",
                 "esri-leaflet-heatmap-feature-layer.js")
    )
  )
}

#' Adds esri-leaflet-heatmap dependency to the leaflet widget
#' @export
#' @rdname esri-dependencies
addEsriHeatmapDependency <- function(map) {
  map$dependencies <- c(map$dependencies,
                        esriDependency(),
                        esriHeatmapDependency())
  map
}

esriRenderersDependency <- function() {
  list(
    htmltools::htmlDependency(
      "esri.leaflet.renderers", version = "1.0.2",
      system.file("htmlwidgets/lib/esri-renderers", package = "leaflet.esri"),
      script = c("esri-leaflet-renderers.js")
    )
  )
}

#' Adds esri-leaflet-renderers dependency to the leaflet widget
#' @export
#' @rdname esri-dependencies
addEsriRenderersDependency <- function(map) {
  map$dependencies <- c(map$dependencies,
                        esriDependency(),
                        esriRenderersDependency())
  map
}
