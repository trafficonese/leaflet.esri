const path = require("path");
const CopyWebpackPlugin = require('copy-webpack-plugin');
const MiniCssExtractPlugin = require("mini-css-extract-plugin");

const binding_path = "./inst/htmlwidgets/bindings/";
const build_path = path.resolve(__dirname, "./inst/htmlwidgets/build");

let library_prod = function(
  name,
  filename = name,
  library = undefined,
  use_default = true
) {

  let foldername = filename;
  filename = filename + "-prod"
  var ret = {
    mode: "production", // minify the files
    entry: name,
    devtool: "source-map", // produce a sibling source map file
    externals: {
      // if 'leaflet' is required, pull from window.L
      leaflet: "L",
    },
    module: {
      rules: [
        // copy files to destination folder who have these extensions
        { test: /\.(png|jpg|gif|svg|woff|woff2|eot|ttf|otf)$/,
          use: [{
              loader: 'file-loader',
              options: {
                name: "css/[name].[ext]"}}]},
        // copy from https://github.com/webpack-contrib/mini-css-extract-plugin/tree/e307e251a476e24f3d1827e74e0434de52ce6ea3
        { test: /\.css$/,
          use: [
            MiniCssExtractPlugin.loader,
            "css-loader" ]}
      ]
    },
    plugins: [
      // copy from https://github.com/webpack-contrib/mini-css-extract-plugin/tree/e307e251a476e24f3d1827e74e0434de52ce6ea3
      new MiniCssExtractPlugin({
        filename: filename + ".css"
      })
    ],
    output: {
      // save to this javascript file
      filename: filename + ".js",
      // save all files in this folder
      path: build_path + "/" + foldername
    }
  }
  // if saving the module to something...
  if (typeof library != 'undefined') {
    // save the library as a variable
    // https://webpack.js.org/configuration/output/#output-library
    ret.output.library = library;
    // do not use 'var' in the assignment
    // https://webpack.js.org/configuration/output/#output-librarytarget
    ret.output.libraryTarget = "assign";
    if (use_default) {
      // export the default value of the module
      // https://webpack.js.org/configuration/output/#output-libraryexport
      ret.output.libraryExport = "default";
    }
  }
  return ret;
}

let library_binding = function(name) {
  let filename = binding_path + name + "-bindings.js";
  return {
    mode: "production", // minify everything
    devtool: "source-map", // include external map file
    entry: filename,
    module: {
      rules: [
        // lint the bindings using ./inst/htmlwidgets/bindings/.eslintrc.js
        {
          test: /\.js$/,
          exclude: /node_modules/,
          loader: "eslint-loader"
        },
      ]
    },
    // save bindings to build bindings folder
    output: {
      filename: name + "-bindings.js", // save file in path on next line
      path: build_path + "/" + name // save all files in this path
    }
  }
}


const config = [

  // "esri-leaflet": "2.1.4",
  library_prod(
    "esri-leaflet", "esri-leaflet",
    // Save to 'L.esri'
    // do not export the default value (there is none)
    "L.esri", false
  ),
  library_binding("esri-leaflet"),

  // "leaflet.markercluster": "1.3.0",
  library_prod("leaflet.markercluster", "leaflet-markercluster"),
  // "esri-leaflet-cluster": "2.0.0",
  // Save to L.esri.ClusteredFeatureLayer
  library_prod(
    "esri-leaflet-cluster", "esri-leaflet-cluster",
    "L.esri.ClusteredFeatureLayer"
  ),
  library_binding("esri-leaflet-cluster"),

  // "esri-leaflet-geocoder": "2.2.9",
  library_prod(
    [
      "esri-leaflet-geocoder",
      // copy css information as well
      "esri-leaflet-geocoder/dist/esri-leaflet-geocoder.css"
    ],
    "esri-leaflet-geocoder"
  ),

  // "simpleheat": "0.4.0"
  // Save to window.simpleheat
  library_prod("simpleheat", "simpleheat", "simpleheat"),
  // "leaflet.heat": "0.2.0",
  library_prod("leaflet.heat", "leaflet-heat"),
  // "esri-leaflet-heatmap": "2.0.0",
  // Save to L.esri.HeatmapFeatureLayer
  library_prod(
    "esri-leaflet-heatmap", "esri-leaflet-heatmap",
    "L.esri.HeatmapFeatureLayer"
  ),
  library_binding("esri-leaflet-heatmap"),

  // "esri-leaflet-renderers": "2.0.6",
  library_prod("esri-leaflet-renderers", "esri-leaflet-renderers"),

];

module.exports = config;
