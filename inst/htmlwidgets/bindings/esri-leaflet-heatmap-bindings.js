/* global L */

// Due to how esri-leaflet-heatmap is exported, it is saved to window.EsriHeatmap

L.esri.heatmapFeatureLayer = function(options) {
  return new L.esri.HeatmapFeatureLayer(options);
};
