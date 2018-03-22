const path = require("path");
const CopyWebpackPlugin = require('copy-webpack-plugin')
const MiniCssExtractPlugin = require("mini-css-extract-plugin");

const src_path = "./inst/htmlwidgets/src/";
const build_path = path.resolve(__dirname, "./inst/htmlwidgets/build");

library_module = function(name) {
  return {
    rules: [
      {
        test: /\.(png|jpg|gif|svg|woff|woff2|eot|ttf|otf)$/,
        use: [
          {
            loader: 'file-loader',
            options: {
              name: "css/" + name + ".[ext]"
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


library_prod = function(name, filename = name, library = undefined) {
  foldername = filename
  filename = filename + "-prod"
  var ret = {
    mode: "development",
    entry: name,
    // devtool: "source-map",
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
      filename: filename + ".js",
      path: build_path + "/" + foldername
    }
  }
  if (name != "esri-leaflet") {
    ret.externals["esri-leaflet"] = "esri-leaflet"
  }
  if (typeof library != 'undefined') {
    ret.output.library = library
  }
  return ret;
}


const config = [

  // "esri-leaflet": "2.1.4",
  library_prod("esri-leaflet", "esri-leaflet"),

  // "esri-leaflet-cluster": "2.0.0",
  library_prod("esri-leaflet-cluster", "esri-leaflet-cluster"),

  // "esri-leaflet-geocoder": "2.2.9",
  library_prod(
    [
      "esri-leaflet-geocoder",
      "esri-leaflet-geocoder/dist/esri-leaflet-geocoder.css"
    ],
    "esri-leaflet-geocoder"
  ),

  // "simpleheat": "0.4.0"
  library_prod("simpleheat", "simpleheat", "simpleheat"),
  // "leaflet.heat": "0.2.0",
  // "esri-leaflet-heatmap": "2.0.0",
  library_prod(
    ["leaflet.heat", "esri-leaflet-heatmap"],
    "esri-leaflet-heatmap"
  ),

  // "esri-leaflet-renderers": "2.0.6",
  library_prod("esri-leaflet-renderers", "esri-leaflet-renderers"),

];

module.exports = config
