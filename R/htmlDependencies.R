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
html_dep_binding <- function(name, version, ..., attachment = NULL) {
  html_dependency(
    paste0(name, "-bindings"), version,
    paste0(name, "-bindings.js"),
    file.path("htmlwidgets", "build", "bindings"),
    all_files = FALSE,
    ...,
    attachment = c(
      attachment,
      paste0(name, "-bindings.js.map")
    )
  )
}






esriDependency <- function() {
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
  list(
    # // "leaflet.markercluster": "1.3.0",
    html_dep_prod("leaflet-markercluster", "1.3.0"),
    # // "esri-leaflet-cluster": "2.0.0",
    html_dep_prod("esri-leaflet-cluster", "2.0.0"),
    html_dep_binding("esri-leaflet-cluster", "1.0.0")
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
  list(
    # // "simpleheat": "0.4.0"
    html_dep_prod("simpleheat", "0.4.0"),
    # // "leaflet.heat": "0.2.0",
    html_dep_prod("leaflet-heat", "0.2.0"),
    # // "esri-leaflet-heatmap": "2.0.0",
    html_dep_prod("esri-leaflet-heatmap", "2.0.0"),
    html_dep_binding("esri-leaflet-heatmap", "1.0.0")
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
