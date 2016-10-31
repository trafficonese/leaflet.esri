LeafletWidget.methods.addEsriBasemapLayer = function(key, labelLayer, layerId, group, options) {
  this.layerManager.addLayer(
    L.esri.basemapLayer(key, options),
    "tile", layerId, group);
  if(labelLayer) {
    this.layerManager.addLayer(
      L.esri.basemapLayer(labelLayer, options),
      "tile", layerId, group);
  }
};