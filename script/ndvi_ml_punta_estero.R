library(readr)
library(tidyverse)
library(timetk)
library(tidyquant)
library(ggplot2)
library(h2o)

h2o.init()

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

fig <- plot_ly(data =data_ndvi ,x = x, y = y1,type = 'scatter', mode = 'lines',name = colnames(series)[1]) %>%
       add_trace(y=y2,mode="lines",name=colnames(series)[2])
fig


train <- data_ndvi[1:42,1:2] 
test <- data_ndvi[1:42,1:2] 


train_h2o <- as.h2o(train)
#valid_h2o <- as.h2o(valid_tbl)
test_h2o <- as.h2o(test)

y <- "y1"
x <-  "x"

set.seed(123)
deep_1 <- h2o.deeplearning(
  x = x, 
  y = y, 
  training_frame = train_h2o, 
  #validation_frame = valid_h2o, 
  max_runtime_secs = 600,
  activation = "tanh",epochs = 100)

#Generate prediction using h2o.predict()
pred_h2o <- h2o.predict(deep_1, newdata = test_h2o)

pred<-as.data.frame(pred_h2o)

data_ndvi_ml<-data.frame(data_ndvi$x,data_ndvi$y1,pred)
colnames(data_ndvi_ml)<-c("Fecha","Punta Estero","Pred")

fig <- plot_ly(data_ndvi_ml, x = data_ndvi_ml$Fecha, y = data_ndvi_ml$`Punta Estero`, name = colnames(data_ndvi_ml)[2], type = 'scatter', mode = 'lines') 
fig <- fig %>% add_trace(y = data_ndvi_ml$Pred, name = colnames(data_ndvi_ml)[3], mode = 'lines+markers',connectgaps = TRUE) 
fig_pe <- fig %>% layout(title = "Modelo DeepLearning NDVI Laurel,mse:",
                      xaxis = list(title = "Fecha"),
                      yaxis = list (title = "NDVI"))

fig_pe

#path1 <- "DeepLearning_model_R_1627930810186_8"
#h2o.saveModel(deep_1,getwd())
# load the model
#ndvi <- h2o.loadModel(path1)
