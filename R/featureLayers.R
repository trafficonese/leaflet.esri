#' Options for featureLayers.
#'
#' @param where String An optional expression to filter features server side.
#'  String values should be denoted using single quotes ie: where: "FIELDNAME = "field value""; More information about valid SQL syntax can be found at \url{http://resources.arcgis.com/en/help/main/10.2/index.html#/SQL_reference_for_query_expressions_used_in_ArcGIS/00s500000033000000/}.
#' @param minZoom Integer Minimum zoom level of the map that features will display.
#' example: minZoom:0
#' @param maxZoom Integer Maximum zoom level of the map that features will
#' example: maxZoom:19
#' @param cacheLayers Boolean Will remove layers from the internal cache when they are removed from the map.
#' @param fields Array An array of fieldnames to pull from the service.
#' Includes all fields by default. You should always specify the name of the unique id for the service. Usually either "FID" or "OBJECTID".
#' @param from Date When paired with to defines the time range of features to display.
#' Requires the Feature Layer to be time enabled.
#' @param to Date When paired with from defines the time range of features to display.
#' Requires the Feature Layer to be time enabled.
#' @param timeField false The name of the field to lookup the time of the feature.
#' Can be an object like {start:"startTime", end:"endTime"} or a string like "created".
#' @param timeFilterMode "server" (default) or "client" Determines where features are filtered by time.
#' By default features will be filtered by the server. If set to "client" all features are requested and filtered by the app before display.
#' @param simplifyFactor Integer How much to simplify polygons and polylines.
#' More means better performance, and less means more accurate representation.
#' @param precision Integer How many digits of precision to request from the server.
#' Wikipedia has a great reference of digit precision to meters at \url{http://en.wikipedia.org/wiki/Decimal_degrees}.
#' @param token String If you pass a token in your options it will be included in all requests to the service.
#' @param proxy URL of an \href{https://developers.arcgis.com/javascript/jshelp/ags_proxy.html}{ArcGIS API for JavaScript proxy} or \href{https://github.com/Esri/resource-proxy}{ArcGIS Resource Proxy} to use for proxying requests.
#' @param useCors Boolean If this service should use CORS when making GET requests.
#' @param renderer L.svg or L.canvas The vector renderer to use to draw the service.
#' Usually L.svg but setting to L.canvas contains performance benefits for large polygon layers.
#' @param ... extra options
#' @export
featureLayerOptions <- function(
  where = NULL,
  minZoom = NULL,
  maxZoom = NULL,
  cacheLayers = NULL,
  fields = NULL,
  from = NULL,
  to = NULL,
  timeField = NULL,
  timeFilterMode = NULL,
  simplifyFactor = NULL,
  precision = NULL,
  token = NULL,
  proxy = NULL,
  useCors = NULL,
  renderer = NULL,
  ...
) {
  leaflet::filterNULL(
    list(
      where = where,
      minZoom = minZoom,
      maxZoom = maxZoom,
      cacheLayers = cacheLayers,
      fields = fields,
      from = from,
      to = to,
      timeField = timeField,
      timeFilterMode = timeFilterMode,
      simplifyFactor = simplifyFactor,
      precision = precision,
      token = token,
      proxy = proxy,
      useCors = useCors,
      renderer = renderer,
      ...
    )
  )
}

#' Adds an ArcGIS Feature Layer.
#'
#' FeatureLayer is used to visualize, style, query and edit vector geographic data hosted in both ArcGIS Online and published using ArcGIS Server. Copyright text from the service is added to map attribution automatically.
#' @param map The leaflet map
#' @param url url of the \href{http://resources.arcgis.com/en/help/arcgis-rest-api/index.html#/Feature_Service/02r3000000z2000000/}{FeatureService} or \href{http://resources.arcgis.com/en/help/arcgis-rest-api/index.html#/Map_Service/02r3000000w2000000/}{MapService}.
#' @param useServiceSymbology whether to use the symbology set when a service was published.
#' @param options options for the featurelayer
#' @param layerId A unique ID for the layer.
#' @param group The name of the group this layer should be added to.
#'   the same parameter under \code{\link{addTiles}})
#' @param markerType The type of marker.  either "marker" or "circleMarker"
#' @param markerIcons Icons for Marker.
#' @param markerIconProperty The property of the feature to use for marker icon.
#' Can be a JS function which accepts a feature and returns an index of \code{markerIcons}.
#' In either case the result must be one of the indexes of markerIcons.
#' @param markerOptions The options for markers
#' Can be a single marker using \code{\link[leaflet]{makeIcon}}
#' or a list of markers using \code{\link[leaflet]{iconList}}
#' @param clusterOptions if not \code{NULL}, markers will be clustered using
#'   \href{https://github.com/Leaflet/Leaflet.markercluster}{Leaflet.markercluster};
#'    you can use \code{\link[leaflet]{markerClusterOptions}()} to specify marker cluster
#'   options
#' @param clusterId the id for the marker cluster layer
#' @param labelProperty The property to use for the label.
#' You can also pass in a JS function that takes in a feature and returns a text/HTML content.
#' @param labelOptions A Vector of \code{\link{labelOptions}} to provide label
#' options for each label. Default \code{NULL}
#' @param popupProperty The property to use for popup content
#' You can also pass in a JS function that takes in a feature and returns a text/HTML content.
#' @param popupOptions A Vector of \code{\link{popupOptions}} to provide popups
#' @param stroke whether to draw stroke along the path (e.g. the borders of
#'   polygons or circles)
#' @param color stroke color
#' @param weight stroke width in pixels
#' @param opacity stroke opacity (or layer opacity for tile layers)
#' @param fill whether to fill the path with color (e.g. filling on polygons or
#'   circles)
#' @param fillColor fill color
#' @param fillOpacity fill opacity
#' @param dashArray a string that defines the stroke
#'   \href{https://developer.mozilla.org/en/SVG/Attribute/stroke-dasharray}{dash
#'   pattern}
#' @param smoothFactor how much to simplify the polyline on each zoom level
#'   (more means better performance and less accurate representation)
#' @param noClip whether to disable polyline clipping
#' @param pathOptions Options for shapes
#' @param highlightOptions Options for highlighting the shape on mouse over.
#'    you can use \code{\link[leaflet]{highlightOptions}()} to specify highlight
#' @param fitBounds Whether to set the maps bounds to fit the data in the featureLayer
#'   options
#' @export
addEsriFeatureLayer <- function(
  map, url, useServiceSymbology = FALSE,
  options = featureLayerOptions(),
  layerId = NULL, group = NULL,
  markerType = NULL, markerIcons = NULL,
  markerIconProperty = NULL, markerOptions = leaflet::markerOptions(),
  clusterOptions = NULL, clusterId = NULL,
  labelProperty = NULL, labelOptions = leaflet::labelOptions(),
  popupProperty = NULL, popupOptions = leaflet::popupOptions(),
  stroke = TRUE,
  color = "#03F",
  weight = 5,
  opacity = 0.5,
  fill = TRUE,
  fillColor = color,
  fillOpacity = 0.2,
  dashArray = NULL,
  smoothFactor = 1.0,
  noClip = FALSE,
  pathOptions = leaflet::pathOptions(),
  highlightOptions = NULL,
  fitBounds = FALSE
) {

  map$dependencies <- c(map$dependencies,
                        leaflet.extras::leafletExtrasDependencies$omnivore())

  if (useServiceSymbology) {
    map <- addEsriRenderersDependency(map)
  } else {
    map <- addEsriDependency(map)
  }
  if (!is.null(clusterOptions)) {
    #map$dependencies = c(map$dependencies,
                         #leaflet::leafletDependencies$markerCluster())
    map <- addEsriClusterDependency(map)
  }

  pathOptions <- c(pathOptions, list(
    stroke = stroke, color = color, weight = weight, opacity = opacity,
    fill = fill, fillColor = fillColor, fillOpacity = fillOpacity,
    dashArray = dashArray, smoothFactor = smoothFactor, noClip = noClip))

  markerIconFunction <- NULL
  if (!is.null(markerIcons)) {
    if (inherits(markerIcons, "leaflet_icon_set") ||
       inherits(markerIcons, "leaflet_icon")) {
      markerIconFunction <- defIconFunction
    } else if (inherits(markerIcons, "leaflet_awesome_icon_set") ||
              inherits(markerIcons, "leaflet_awesome_icon")) {
      if (inherits(markerIcons, "leaflet_awesome_icon_set")) {
        libs <- unique(sapply(markerIcons, function(icon) icon$library))
        map <- leaflet.extras::addAwesomeMarkersDependencies(map, libs)
      } else {
        map <- leaflet.extras::addAwesomeMarkersDependencies(
          map, markerIcons$library)
      }
      markerIconFunction <- awesomeIconFunction
    } else {
      stop("markerIcons should be created using either leaflet::iconList() or leaflet::awesomeIconList()")
    }
  }

  leaflet::invokeMethod(
    map, leaflet::getMapData(map), "addEsriFeatureLayer", url, options, layerId, group,
    markerType, markerIcons,
    markerIconProperty, markerOptions, markerIconFunction,
    clusterOptions, clusterId,
    labelProperty, labelOptions, popupProperty, popupOptions,
    pathOptions, highlightOptions, fitBounds)
}

#' Add Esri Heatmap Feature Layer.
#'
#' @param map The leaflet map
#' @param url url of the \href{http://resources.arcgis.com/en/help/arcgis-rest-api/index.html#/Feature_Service/02r3000000z2000000/}{FeatureService} or \href{http://resources.arcgis.com/en/help/arcgis-rest-api/index.html#/Map_Service/02r3000000w2000000/}{MapService}.
#' @param options options for the featurelayer
#' @param layerId A unique ID for the layer.
#' @param group The name of the group this layer should be added to.
#'   the same parameter under \code{\link{addTiles}})
#' @param radius Radius for the heatmap
#' @param gradient The gradient
#' @export
addEsriHeatmapFeatureLayer <- function(
  map, url, radius = 25,
  gradient = NULL,
  options = featureLayerOptions(),
  layerId = NULL, group = NULL) {

  map$dependencies <- c(map$dependencies,
                        leaflet.extras::leafletExtrasDependencies$omnivore())
  map <- addEsriHeatmapDependency(map)
  options <- leaflet::filterNULL(c(options, list(
    radius = radius,
    gradient = gradient
  )))
  leaflet::invokeMethod(
    map, leaflet::getMapData(map),
    "addEsriHeatmapFeatureLayer", url, layerId, group, options)
}
