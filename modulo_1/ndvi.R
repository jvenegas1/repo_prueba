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

load("datos.RData")
series<-series[1:10,]
series$`Maiz 2`[is.na(series$`Maiz 2`)]<-mean(series$`Maiz 2`, na.rm = T)
series$`El pero b`[is.na(series$`El pero b`)]<-mean(series$`El pero b`, na.rm = T)
series$`Los bolos b`[is.na(series$`Los bolos b`)]<-mean(series$`Los bolos b`, na.rm = T)
series$`Las piedras`[is.na(series$`Las piedras`)]<-mean(series$`Las piedras`, na.rm = T)
series$`Peña a`[is.na(series$`Peña a`)]<-mean(series$`Peña a`, na.rm = T)
series$`Peña b`[is.na(series$`Peña b`)]<-mean(series$`Peña b`, na.rm = T)
series$`Pero a`<-series$`El pero b`

x <- rownames(series)
y1 <- series$`Punta estero`
y2 <- series$Laurel
y3 <- series$Patagua
y4 <- series$`Lado estero`
y5 <- series$`Maiz 2`
y6 <- series$`Maiz 1`
y7 <- series$`Pero a`
y8 <- series$`Los bolos a`
y9 <- series$`El pero b`
y10 <- series$`Los bolos b`
y11 <- series$`Las piedras`
y12 <- series$`Peña a`
y13 <- series$`Peña b`
y14 <- series$`Brazo Muerto`
y15 <- series$`La isla`
data<-data.frame(x,y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,y13,y15)

fig <- plot_ly(data =data ,x = x, y = y1,type = 'scatter', mode = 'lines',name = colnames(series)[1]) %>%
  add_trace(y = y2, name = colnames(series)[2],mode = 'lines') %>%
  add_trace(y = y3, name = colnames(series)[3],mode = 'lines') %>%  
  add_trace(y = y4, name = colnames(series)[4],mode = 'lines') %>%
  add_trace(y = y5, name = colnames(series)[5],mode = 'lines') %>%
  add_trace(y = y6, name = colnames(series)[6],mode = 'lines') %>%
  add_trace(y = y7, name = colnames(series)[7],mode = 'lines') %>%
  add_trace(y = y8, name = colnames(series)[8],mode = 'lines') %>%
  add_trace(y = y9, name = colnames(series)[9],mode = 'lines') %>%
  add_trace(y = y10, name = colnames(series)[10],mode = 'lines') %>%
  add_trace(y = y11, name = colnames(series)[11],mode = 'lines') %>%
  add_trace(y = y12, name = colnames(series)[12],mode = 'lines') %>%
  add_trace(y = y13, name = colnames(series)[13],mode = 'lines') %>%
  add_trace(y = y14, name = colnames(series)[14],mode = 'lines') %>%
  add_trace(y = y15, name = colnames(series)[15],mode = 'lines')

fig