library(sp)
library(rgdal)
library(raster)
library(shiny)
library(dplyr)
library(leaflet)
library(geojsonR)
library(rgdal)
library(raster)
library(stringr)
library(plotly)
library(xts)
library(zoo)

temp = list.files(pattern = "*.tif")
myfiles = lapply(temp, raster)

allrasters <- stack(temp)

pal = colorNumeric("viridis", values(allrasters[[1]]),na.color = "transparent")

ubicacion<-matrix(0,15,2)
ubicacion<-data.frame(ubicacion)
file_js_2<-readOGR("shape/agrospace_piloto.kml")

for(i in seq(1:15)){
  ubicacion[i,1]<-data.frame(file_js_2@polygons[[i]]@labpt[1])
  ubicacion[i,2]<-data.frame(file_js_2@polygons[[i]]@labpt[2])
}

ubicacion<-cbind(file_js_2@data$Name,ubicacion)
colnames(ubicacion)<-c("name","long","lat")

series<-matrix(0,42,15)
series<-data.frame(series)
colnames(series)<-ubicacion$name
names(allrasters)

fechas<-str_sub(names(allrasters), 18, 27)

rownames(series)<-fechas

escala<-c(0,0.2,0.4,0.6,0.8,1)



# output interactive plot
fig3<-leaflet() %>%
  setView(lng = ubicacion$long[8],lat = ubicacion$lat[8],zoom = 14) %>%
  addTiles() %>%
  addProviderTiles("Stamen.TonerLite", options = providerTileOptions(noWrap = TRUE)) %>% 
  addRasterImage(group = rownames(series)[41],allrasters[[41]], colors=pal, project=F, opacity=0.8) %>%
  addRasterImage(group = rownames(series)[42],allrasters[[42]], colors=pal, project=F, opacity=0.8) %>%
  leaflet::addLegend(pal=pal, position='bottomright', values=values(allrasters[[1]]), title='NDVI') %>% 
  addMarkers(lng=ubicacion$long,lat=ubicacion$lat,label = ubicacion$name) 

fig3<-fig3 %>% addLayersControl(
  options = layersControlOptions(collapsed = TRUE,width=40,height=40),
  overlayGroups = c(rownames(series)[41],rownames(series)[42]))


fig3