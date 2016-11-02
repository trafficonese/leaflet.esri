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
  var self = this;
  LeafletWidget.methods.addGenericGeoJSONLayer(
    self,
    function getGeoJSONLayer(geoJSONOptions){
      if($.isEmptyObject(clusterOptions)){
        return L.esri.featureLayer($.extend({url: url},
          options, pathOptions, geoJSONOptions));
      } else {
        return L.esri.clusteredFeatureLayer($.extend({url: url},
          options, pathOptions, geoJSONOptions));
      }
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
  var self = this;
  LeafletWidget.methods.addGenericGeoJSONLayer(
    self,
    function getGeoJSONLayer(geoJsonOptions){
      //return L.esri.heatmapFeatureLayer($.extend({url: url}, options, geoJsonOptions));
      return L.esri.heatmapFeatureLayer($.extend({url: url}, options));
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