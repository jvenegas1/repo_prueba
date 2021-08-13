library(geojsonR)
library(rgdal)
library(raster)
library(ggplot2)

raster_1 <- raster("raster/agrospace_piloto_2019-10-21.tif")
raster_2 <- raster("raster/agrospace_piloto_2019-10-31.tif")
plot(raster_1)
plot(raster_2)
nlayers(raster_1)
minValue(raster_1)
maxValue(raster_1)

df_ndvi <- as.data.frame(raster_1, xy=TRUE)
str(df_ndvi)

file_js_1<- FROM_GeoJson(url_file_string = "shape/agrospace_piloto.geojson")
plot(file_js_1)


file_js_2<-readOGR("shape/agrospace_piloto.kml")
plot(file_js_2)


GDALinfo ("raster/agrospace_piloto_2019-10-21.tif")
info_1 <- capture.output(GDALinfo("raster/agrospace_piloto_2019-10-21.tif"))
info_2 <- capture.output(GDALinfo("raster/agrospace_piloto_2019-10-31.tif"))
