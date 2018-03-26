const path = require("path");
const CopyWebpackPlugin = require('copy-webpack-plugin');
const MiniCssExtractPlugin = require("mini-css-extract-plugin");

const binding_path = "./inst/htmlwidgets/bindings/";
const build_path = path.resolve(__dirname, "./inst/htmlwidgets/build");

let library_module = function(name) {
  return {
    rules: [
      {
        test: /\.(png|jpg|gif|svg|woff|woff2|eot|ttf|otf)$/,
        use: [
          {
            loader: 'file-loader',
            options: {
              name: "css/[name].[ext]"
            }
          }
        ]
      },
      {
        test: /\.css$/,
        use: [
          MiniCssExtractPlugin.loader,
          "css-loader"
        ]
      }
    ]
  }
}


let library_prod = function(
  name,
  filename = name,
  library = undefined,
  use_default = true
) {
  let foldername = filename;
  filename = filename + "-prod";

  var ret = {
    mode: "development",
    entry: name,
    devtool: "source-map", // create sibling map file
    externals: {
      leaflet: "L",
    },
    module: library_module(filename),
    plugins: [
      new MiniCssExtractPlugin({
        filename: filename + ".css"
      })
    ],
    output: {
      filename: filename + ".js", // save file in path on next line
      path: build_path + "/" + foldername // save all files in this path
    }
  }
  // if it isn't esri, add the external dependency
  if (foldername != "esri-leaflet") {
    ret.externals["esri-leaflet"] = "L.esri";
  }
  // if saving the module to something...
  if (typeof library != 'undefined') {
    // https://webpack.js.org/configuration/output/#output-library
    ret.output.library = library;
    // https://webpack.js.org/configuration/output/#output-librarytarget
    ret.output.libraryTarget = "assign";
    if (use_default) {
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
