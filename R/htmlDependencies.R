html_dependency <- function(name, version, script, folder, ...) {
  htmltools::htmlDependency(
    name,
    version = version,
    system.file(folder, package = "leaflet.esri"),
    script = script,
    ...
  )
}

# match the npm version
html_dep_prod <- function(name, version, has_style = FALSE, ..., stylesheet = NULL) {
  if (isTRUE(has_style)) {
    if (missing(stylesheet)) {
      stylesheet <- paste0(name, "-prod.css")
    }
  }
  html_dependency(
    name, version,
    paste0(name, "-prod.js"),
    file.path("htmlwidgets", "build", name),
    all_files = TRUE,
    ...,
    stylesheet = stylesheet
  )
}

# keep the version at the lastest release version where the bindings were updated
html_dep_binding <- function(name, version, ...) {
  html_dependency(
    paste0(name, "-bindings"), version,
    paste0(name, "-bindings.js"),
    file.path("htmlwidgets", "bindings"),
    all_files = FALSE,
    ...
  )
}






esriDependency <- function() {
  # list(
  #   htmltools::htmlDependency(
  #     "esri.leaflet", version = "1.0.4",
  #     system.file("htmlwidgets/lib/esri", package = "leaflet.esri"),
  #     script = c("esri-leaflet.js", "esri-leaflet-bindings.js")
  #   )
  # )
  list(
    # // "esri-leaflet": "2.1.4",
    html_dep_prod("esri-leaflet", "2.1.4"),
    html_dep_binding("esri-leaflet", "1.0.0")
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
  # list(
  #   htmltools::htmlDependency(
  #     "esri.leaflet.cluster", version = "1.0.2",
  #     system.file("htmlwidgets/lib/esri-cluster", package = "leaflet.esri"),
  #     script = c("esri-leaflet-clustered-feature-layer-src.js")
  #   )
  # )
  list(
    # // "esri-leaflet-cluster": "2.0.0",
    html_dep_prod("esri-leaflet-cluster", "2.0.0")
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
  # list(
  #   htmltools::htmlDependency(
  #     "esri.leaflet.geocoder", version = "1.0.2",
  #     system.file("htmlwidgets/lib/esri-geocoder", package = "leaflet.esri"),
  #     script = c("esri-leaflet-geocoder.js"),
  #     stylesheet = c("esri-leaflet-geocoder.css")
  #   )
  # )
  list(
    # // "esri-leaflet-geocoder": "2.2.9",
    html_dep_prod("esri-leaflet-geocoder", "2.2.9", has_style = TRUE)
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
  # list(
  #   htmltools::htmlDependency(
  #     "esri.leaflet.heatmap", version = "1.0.2",
  #     system.file("htmlwidgets/lib/esri-heatmap", package = "leaflet.esri"),
  #     script = c("leaflet-heat.js",
  #                "esri-leaflet-heatmap-feature-layer.js")
  #   )
  # )
  list(
    # // "simpleheat": "0.4.0"
    html_dep_prod("simpleheat", "0.4.0"),
    # // "leaflet.heat": "0.2.0",
    # // "esri-leaflet-heatmap": "2.0.0",
    html_dep_prod("esri-leaflet-heatmap", "2.0.0")
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
  # list(
  #   htmltools::htmlDependency(
  #     "esri.leaflet.renderers", version = "1.0.2",
  #     system.file("htmlwidgets/lib/esri-renderers", package = "leaflet.esri"),
  #     script = c("esri-leaflet-renderers.js")
  #   )
  # )
  list(
    # // "esri-leaflet-renderers": "2.0.6",
    html_dep_prod("esri-leaflet-renderers", "2.0.6")
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
