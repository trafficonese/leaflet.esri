/* global LeafletWidget, $, L, Shiny, HTMLWidgets */
LeafletWidget.methods.addEsriBasemapLayer = function(
  key, labelLayer, layerId, group, options) {
  this.layerManager.addLayer(
    L.esri.basemapLayer(key, options),
    "tile", layerId, group);
  if(labelLayer) {
    this.layerManager.addLayer(
      L.esri.basemapLayer(labelLayer, options),
      "tile", layerId, group);
  }
};


LeafletWidget.methods.addEsriFeatureLayer = function(
  url, options, layerId, group,
  markerType, markerIcons,
  markerIconProperty, markerOptions, markerIconFunction,
  clusterOptions, clusterId,
  labelProperty, labelOptions, popupProperty, popupOptions,
  pathOptions, highlightOptions, fitBounds
  ) {
  var map = this;
  LeafletWidget.methods.addGenericGeoJSONLayer(
    map,
    function getGeoJSONLayer(geoJSONOptions){
      var featureLayer = null;
      if($.isEmptyObject(clusterOptions)){
        featureLayer = L.esri.featureLayer($.extend({url: url},
          options, pathOptions, geoJSONOptions));
      } else {
        featureLayer = L.esri.clusteredFeatureLayer($.extend({url: url},
          options, pathOptions, geoJSONOptions));
      }

      // events
      // http://esri.github.io/esri-leaflet/api-reference/layers/feature-layer.html

      featureLayer.on('loading', function(e) {
        if (!HTMLWidgets.shinyMode) return;
        Shiny.onInputChange(map.id+'_esri_featureLayer_loading',
          {'bounds': e.bounds});
      });
      featureLayer.on('load', function(e) {
        /* Will not work with an older version of ArcGIS Server
        if(fitBounds) {
          featureLayer.query().bounds(function (error, latlngbounds) {
            map.fitBounds(latlngbounds);
          });
        } */
        if (!HTMLWidgets.shinyMode) return;
        Shiny.onInputChange(map.id+'_esri_featureLayer_load',
          {'bounds': e.bounds});
      });
      featureLayer.on('createFeature', function(e) {
        if (!HTMLWidgets.shinyMode) return;
        Shiny.onInputChange(map.id+'_esri_featureLayer_createFeature',
          {'feature': e.feature});
      });
      featureLayer.on('removeFeature', function(e) {
        if (!HTMLWidgets.shinyMode) return;
        Shiny.onInputChange(map.id+'_esri_featureLayer_removeFeature',
          {'feature': e.feature, 'permanent' : e.permanent});
      });
      featureLayer.on('addFeature', function(e) {
        if (!HTMLWidgets.shinyMode) return;
        Shiny.onInputChange(map.id+'_esri_featureLayer_addFeature',
          {'feature': e.feature});
      });
      if(fitBounds) {
        featureLayer.once("load", function(evt) {
          // create a new empty Leaflet bounds object
          var bounds = L.latLngBounds([]);
          // loop through the features returned by the server
          fl.eachFeature(function(layer) {
            // get the bounds of an individual feature
            var layerBounds = layer.getBounds();
            // extend the bounds of the collection to fit the bounds of the new feature
            bounds.extend(layerBounds);
          });

          // once we've looped through all the features, zoom the map to the extent of the collection
          map.fitBounds(bounds);
        });
      }

      // TODO do we need events from http://esri.github.io/esri-leaflet/api-reference/services/service.html ?

      return featureLayer;
    },
    layerId, group,
    false,
    markerType, markerIcons,
    markerIconProperty, markerOptions, markerIconFunction,
    null, null,
    labelProperty, labelOptions, popupProperty, popupOptions,
    pathOptions, highlightOptions
  );
};

LeafletWidget.methods.addEsriHeatmapFeatureLayer = function(
  url, layerId, group, options ) {
  var map = this;
  LeafletWidget.methods.addGenericGeoJSONLayer(
    map,
    function getGeoJSONLayer(geoJsonOptions){
      var heatmapFeatureLayer = L.esri.heatmapFeatureLayer($.extend({url: url}, options));
      // events
      // http://esri.github.io/esri-leaflet/api-reference/layers/heatmap-feature-layer.html

      heatmapFeatureLayer.on('loading', function(e) {
        if (!HTMLWidgets.shinyMode) return;
        Shiny.onInputChange(map.id+'_esri_heatmapFeatureLayer_loading',
          {'bounds': e.bounds});
      });
      heatmapFeatureLayer.on('load', function(e) {
        if (!HTMLWidgets.shinyMode) return;
        Shiny.onInputChange(map.id+'_esri_heatmapFeatureLayer_load',
          {'bounds': e.bounds});
      });
      return heatmapFeatureLayer;
    },
    layerId, group,
    false,
    null, null,
    null, null, null,
    null, null,
    null, null, null, null,
    {}, null
  );
};

LeafletWidget.methods.addEsriTiledMapLayer = function(
  url, layerId, group, options ) {

  var layer =  L.esri.tiledMapLayer($.extend({url: url}, options || {}));
  // events
  // https://esri.github.io/esri-leaflet/api-reference/layers/tiled-map-layer.html#events

  layer.on('loading', function(e) {
    if (!HTMLWidgets.shinyMode) return;
    Shiny.onInputChange(map.id+'_esri_tiledMapLayer_loading',
      {'bounds': e.bounds});
  });
  layer.on('load', function(e) {
    if (!HTMLWidgets.shinyMode) return;
    Shiny.onInputChange(map.id+'_esri_tiledMapLayer_load',
      {'bounds': e.bounds});
  });

  this.layerManager.addLayer(layer, "tile", layerId, group);
};

LeafletWidget.methods.addEsriDynamicMapLayer = function(
  url, layerId, group, options, popupFunction, popupOptions ) {

  var layer = L.esri.dynamicMapLayer($.extend({url: url}, options || {}));
  // events
  // https://esri.github.io/esri-leaflet/api-reference/layers/dynamic-map-layer.html#events

  layer.on('loading', function(e) {
    if (!HTMLWidgets.shinyMode) return;
    Shiny.onInputChange(map.id+'_esri_dynamicMapLayer_loading',
      {'bounds': e.bounds});
  });
  layer.on('load', function(e) {
    if (!HTMLWidgets.shinyMode) return;
    Shiny.onInputChange(map.id+'_esri_dynamicMapLayer_load',
      {'bounds': e.bounds});
  });

  if(popupFunction) {
    layer.bindPopup(popupFunction, popupOptions || {});
  }

  this.layerManager.addLayer(layer, "tile", layerId, group);
};

LeafletWidget.methods.addEsriImageMapLayer = function(
  url, layerId, group, options, popupFunction, popupOptions ) {

  var layer = L.esri.imageMapLayer($.extend({url: url}, options || {}));
  // events
  // https://esri.github.io/esri-leaflet/api-reference/layers/image-map-layer.html#events

  layer.on('loading', function(e) {
    if (!HTMLWidgets.shinyMode) return;
    Shiny.onInputChange(map.id+'_esri_imageMapLayer_loading',
      {'bounds': e.bounds});
  });
  layer.on('load', function(e) {
    if (!HTMLWidgets.shinyMode) return;
    Shiny.onInputChange(map.id+'_esri_imageMapLayer_load',
      {'bounds': e.bounds});
  });

  if(popupFunction) {
    layer.bindPopup(popupFunction, popupOptions || {});
  }

  this.layerManager.addLayer(layer, "tile", layerId, group);
};