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
  pathOptions, highlightOptions
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
  this.layerManager.addLayer(
    L.esri.tiledMapLayer($.extend({url: url}, options || {})),
    "tile", layerId, group);
};