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


load("datos.RData")

for(i in seq(1,15)){
  
  series[,i][is.na(series[,i])]<-mean(series[,i],na.rm=T)
}

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
data_ndvi<-data.frame(x,y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,y13,y15)

train <- data_ndvi[1:42,1:2] 
test <- data_ndvi[1:42,1:2] 


train_h2o <- as.h2o(train)
#valid_h2o <- as.h2o(valid_tbl)
test_h2o <- as.h2o(test)

path1 <- "DeepLearning_model_R_1627930810186_8"
# load the model
ndvi <- h2o.loadModel(path1)


#Generate prediction using h2o.predict()
pred_h2o <- h2o.predict(ndvi, newdata = test_h2o)

pred<-as.data.frame(pred_h2o)

data_ndvi_ml<-data.frame(data_ndvi$x,data_ndvi$y1,pred)
colnames(data_ndvi_ml)<-c("Fecha","Punta Estero","Pred")

fig <- plot_ly(data_ndvi_ml, x = data_ndvi_ml$Fecha, y = data_ndvi_ml$`Punta Estero`, name = "Punta Estero", type = 'scatter', mode = 'lines') 
fig <- fig %>% add_trace(y = data_ndvi_ml$Pred, name = "Pred Punta Estero", mode = 'lines+markers',connectgaps = TRUE) 
fig <- fig %>% layout(title = "Modelo DeepLearning NDVI Punta Estero",
                      xaxis = list(title = "Fecha"),
                      yaxis = list (title = "NDVI"))
fig

