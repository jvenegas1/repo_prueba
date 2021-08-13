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
fig2<-leaflet() %>%
  setView(lng = ubicacion$long[8],lat = ubicacion$lat[8],zoom = 14) %>%
  addTiles() %>%
  addProviderTiles("Stamen.TonerLite", options = providerTileOptions(noWrap = TRUE)) %>% 
  addRasterImage(group = rownames(series)[9],allrasters[[9]], colors=pal, project=F, opacity=0.8) %>%
  addRasterImage(group = rownames(series)[10],allrasters[[10]], colors=pal, project=F, opacity=0.8) %>%
  addRasterImage(group = rownames(series)[11],allrasters[[11]], colors=pal, project=F, opacity=0.8) %>%
  addRasterImage(group = rownames(series)[12],allrasters[[12]], colors=pal, project=F, opacity=0.8) %>%
  addRasterImage(group = rownames(series)[13],allrasters[[13]], colors=pal, project=F, opacity=0.8) %>%
  addRasterImage(group = rownames(series)[14],allrasters[[14]], colors=pal, project=F, opacity=0.8) %>%
  addRasterImage(group = rownames(series)[15],allrasters[[15]], colors=pal, project=F, opacity=0.8) %>%
  addRasterImage(group = rownames(series)[16],allrasters[[16]], colors=pal, project=F, opacity=0.8) %>%
  addRasterImage(group = rownames(series)[17],allrasters[[17]], colors=pal, project=F, opacity=0.8) %>%
  addRasterImage(group = rownames(series)[18],allrasters[[18]], colors=pal, project=F, opacity=0.8) %>%
  addRasterImage(group = rownames(series)[19],allrasters[[19]], colors=pal, project=F, opacity=0.8) %>%
  addRasterImage(group = rownames(series)[20],allrasters[[20]], colors=pal, project=F, opacity=0.8) %>%
  addRasterImage(group = rownames(series)[21],allrasters[[21]], colors=pal, project=F, opacity=0.8) %>%
  addRasterImage(group = rownames(series)[22],allrasters[[22]], colors=pal, project=F, opacity=0.8) %>%
  addRasterImage(group = rownames(series)[23],allrasters[[23]], colors=pal, project=F, opacity=0.8) %>%
  addRasterImage(group = rownames(series)[24],allrasters[[24]], colors=pal, project=F, opacity=0.8) %>%
  addRasterImage(group = rownames(series)[25],allrasters[[25]], colors=pal, project=F, opacity=0.8) %>%
  addRasterImage(group = rownames(series)[26],allrasters[[26]], colors=pal, project=F, opacity=0.8) %>%
  addRasterImage(group = rownames(series)[27],allrasters[[27]], colors=pal, project=F, opacity=0.8) %>%
  addRasterImage(group = rownames(series)[28],allrasters[[28]], colors=pal, project=F, opacity=0.8) %>%
  addRasterImage(group = rownames(series)[29],allrasters[[29]], colors=pal, project=F, opacity=0.8) %>%
  addRasterImage(group = rownames(series)[30],allrasters[[30]], colors=pal, project=F, opacity=0.8) %>%
  addRasterImage(group = rownames(series)[31],allrasters[[31]], colors=pal, project=F, opacity=0.8) %>%
  addRasterImage(group = rownames(series)[32],allrasters[[32]], colors=pal, project=F, opacity=0.8) %>%
  addRasterImage(group = rownames(series)[33],allrasters[[33]], colors=pal, project=F, opacity=0.8) %>%
  addRasterImage(group = rownames(series)[34],allrasters[[34]], colors=pal, project=F, opacity=0.8) %>%
  addRasterImage(group = rownames(series)[35],allrasters[[35]], colors=pal, project=F, opacity=0.8) %>%
  addRasterImage(group = rownames(series)[36],allrasters[[36]], colors=pal, project=F, opacity=0.8) %>%
  addRasterImage(group = rownames(series)[37],allrasters[[37]], colors=pal, project=F, opacity=0.8) %>%
  addRasterImage(group = rownames(series)[38],allrasters[[38]], colors=pal, project=F, opacity=0.8) %>%
  addRasterImage(group = rownames(series)[39],allrasters[[39]], colors=pal, project=F, opacity=0.8) %>%
  addRasterImage(group = rownames(series)[40],allrasters[[40]], colors=pal, project=F, opacity=0.8) %>%
  leaflet::addLegend(pal=pal, position='bottomright', values=values(allrasters[[1]]), title='NDVI') %>% 
  addMarkers(lng=ubicacion$long,lat=ubicacion$lat,label = ubicacion$name) 
  

fig2<-fig2 %>% addLayersControl(
  options = layersControlOptions(collapsed = TRUE,width=40,height=40),
  overlayGroups = c(rownames(series)[9],rownames(series)[10],rownames(series)[11],
                    rownames(series)[12],rownames(series)[13],rownames(series)[14],rownames(series)[15],
                    rownames(series)[16],rownames(series)[17],rownames(series)[18],rownames(series)[19],
                    rownames(series)[20],rownames(series)[21],rownames(series)[22],rownames(series)[23],
                    rownames(series)[24],rownames(series)[25],rownames(series)[26],rownames(series)[27],
                    rownames(series)[28],rownames(series)[29],rownames(series)[30],rownames(series)[31],
                    rownames(series)[32],rownames(series)[33],rownames(series)[34],rownames(series)[35],
                    rownames(series)[36],rownames(series)[37],rownames(series)[38],rownames(series)[39],
                    rownames(series)[40]
  ))


fig2