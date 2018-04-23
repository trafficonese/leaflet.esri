
[![Project Status: Active – The project is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active) [![Last-changedate](https://img.shields.io/badge/last%20change-2018--04--23-green.svg)](/commits/master) [![License: GPL-3](https://img.shields.io/badge/License-GPLv3-yellow.svg)](https://opensource.org/licenses/GPL-3.0) [![keybase verified](https://img.shields.io/badge/keybase-verified-brightgreen.svg)](https://gist.github.com/bhaskarvk/46fbf2ba7b5713151d7e) [![Travis-CI Build Status](https://travis-ci.org/bhaskarvk/leaflet.esri.svg?branch=master)](https://travis-ci.org/bhaskarvk/leaflet.esri) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/bhaskarvk/leaflet.esri?branch=master&svg=true)](https://ci.appveyor.com/project/bhaskarvk/leaflet.esri) [![minimal R version](https://img.shields.io/badge/R%3E%3D-3.1.0-6666ff.svg)](https://cran.r-project.org/) [![packageversion](https://img.shields.io/badge/Package%20version-1.0.0-orange.svg?style=flat-square)](commits/master) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/leaflet.esri)](https://cran.r-project.org/package=leaflet.esri) [![](http://cranlogs.r-pkg.org/badges/grand-total/leaflet.esri)](http://cran.rstudio.com/web/packages/leaflet.esri/index.html)

ESRI Leaflet bindings.
----------------------

ESRI bindings for the [leaflet](https://www.github.com/rstudio/leaflet) package, based on the [ESRI leaflet plugin](https://esri.github.io/esri-leaflet/). This package is part of the leaflet ecosystem of R packages for web mapping.

**Compatibility Matrix**

As of Feb, 2017 the leaflet R package is based on version 0.7.7 of the Leaflet Javascript library and therefore the leaflet.esri package is based on version 1.0.4 of esri-leaflet Jaascript library which is the last release compatible with the 0.7.x branch of Leaflet JS. The chart below shows more details.

<table>
<colgroup>
<col width="19%" />
<col width="22%" />
<col width="33%" />
<col width="25%" />
</colgroup>
<thead>
<tr class="header">
<th>Leaflet JS ver.</th>
<th>R Leaflet pkg ver.</th>
<th>esri-leaflet JS Plugin ver.</th>
<th>R leaflet.esri pkg ver.</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><a href="https://github.com/Leaflet/Leaflet/releases/tag/v0.7.7">0.7.x</a></td>
<td><a href="https://github.com/rstudio/leaflet/releases/tag/v1.1.0">1.1</a></td>
<td><a href="https://github.com/Esri/esri-leaflet/releases/tag/v1.0.4">1.0.4</a></td>
<td>0.2.x</td>
</tr>
<tr class="even">
<td><a href="https://github.com/Leaflet/Leaflet/releases/tag/v1.3.1">1.3.1</a></td>
<td><a href="https://github.com/rstudio/leaflet/releases/tag/v2.0.0">2.0.0</a></td>
<td><a href="https://github.com/Esri/esri-leaflet/releases/tag/v2.1.4">2.1.4</a></td>
<td>1.0.0</td>
</tr>
</tbody>
</table>

### Features Tracking

**NOTE** It may not be possible to implement each and every feature and if so the documentation will be updated accordingly. Each feature which is implemented has a tick mark (✔️) next to it. Any description you find in this section is directly taken from the esri-leaflt [API reference](https://esri.github.io/esri-leaflet/api-reference/).

#### Authentication Support

-   [ArcGIS Online OAuth](https://esri.github.io/esri-leaflet/examples/arcgis-online-auth.html)
-   [Premium ArcGIS Online Content](https://esri.github.io/esri-leaflet/examples/premium-content.html)
-   [ArcGIS Server Username/Password](https://esri.github.io/esri-leaflet/examples/arcgis-server-auth.html)

#### Layers

Layers provide visualization capabilities for data hosted in Feature Services, Map Services and Image Services.

-   [Basemap Layer](https://esri.github.io/esri-leaflet/api-reference/layers/basemap-layer.html) ✔️
-   [Feature Layer](https://esri.github.io/esri-leaflet/api-reference/layers/feature-layer.html) - ✔️ (Except for Edit Features)
    -   Labels ✔️
    -   Popups ✔️
    -   Markers w/ Icons ✔️
    -   Path Styling ✔️
    -   Path Highlight ✔️
    -   FitBounds ✔️
    -   Edit Features
-   [Cluster Feature Layer](https://esri.github.io/esri-leaflet/api-reference/layers/clustered-feature-layer.html) ✔️
-   [Heat Feature Layer](https://esri.github.io/esri-leaflet/api-reference/layers/heatmap-feature-layer.html) ✔️
-   [Dynamic Map Layer](https://esri.github.io/esri-leaflet/api-reference/layers/dynamic-map-layer.html) ✔️
-   [Image Map Layer](https://esri.github.io/esri-leaflet/api-reference/layers/image-map-layer.html) ✔️
-   [Tiled Map Layer](https://esri.github.io/esri-leaflet/api-reference/layers/tiled-map-layer.html) ✔️
-   [Vector Basemap](https://esri.github.io/esri-leaflet/api-reference/layers/vector-basemap.html)
-   [Vector Layer](https://esri.github.io/esri-leaflet/api-reference/layers/vector-layer.html)

#### Controls

-   [Geosearch](https://esri.github.io/esri-leaflet/api-reference/controls/geosearch.html)

#### Tasks

Tasks are wrappers for commonly used API methods on ArcGIS services. They expose commonly used parameters to make them more accessible to Leaflet.

-   [Query](https://esri.github.io/esri-leaflet/api-reference/tasks/query.html) ✔️
-   [Find](https://esri.github.io/esri-leaflet/api-reference/tasks/find.html) ✔️
-   [IdentifyFeatures](https://esri.github.io/esri-leaflet/api-reference/tasks/identify-features.html) ✔️
-   [IdentifyImage](https://esri.github.io/esri-leaflet/api-reference/tasks/identify-image.html) ✔️
-   [Geocode](https://esri.github.io/esri-leaflet/api-reference/tasks/geocode.html)
-   [Reverse Geocode](https://esri.github.io/esri-leaflet/api-reference/tasks/reverse-geocode.html)
-   [Suggest](https://esri.github.io/esri-leaflet/api-reference/tasks/suggest.html)
-   [Geoprocessing Task](https://esri.github.io/esri-leaflet/api-reference/tasks/gp-task.html)
-   [Query Related](https://esri.github.io/esri-leaflet/api-reference/tasks/query-related.html)

#### Events

[Event](https://esri.github.io/esri-leaflet/api-reference/events.html) types common across components of Esri Leaflet. ✔️

-   loading
-   load
-   createfeature
-   removefeature
-   addfeature

### Code of Conduct

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
