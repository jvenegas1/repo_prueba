library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(leaflet)
library(plotly)
library(DT)
library(shinyjqui)
library(polished)
library(knitr)
library(fresh)
library(bs4Dash)
library(waiter)
library(xts)



bs4dash_status(primary = "#5E81AC", danger = "#BF616A")

ui <- fluidPage(
    
    dashboardPage(
        bs4DashNavbar(title = HTML("Dashboard Agrospace"), 
                      disable = FALSE,titleWidth = "800"
        ),
        
        
        bs4DashSidebar(width = "1000",
                       sidebarMenu(
                           #menuItem("Imagenes historicas",tabName = "modulo1",icon = icon("globe-americas")),
                           menuItem("Imagenes Satelitales",tabName = "modulo1",icon = icon("globe-americas")),
                           menuItem("NDVI Machine Learning",tabName = "modulo2",icon = icon("seedling"))
                           
                           
                       )
        ),
        dashboardBody(tabItems(
            tabItem(tabName = "modulo1",
                    
                    fluidRow(box(title = "Potreros 2019",leafletOutput("plot1_19"),status = "warning"
                                 ,width =4,maximizable = TRUE,elevation = 5),
                    
                    
                    box(title = "Potreros 2020",leafletOutput("plot1_20") ,status = "warning"
                                 ,width = 4,maximizable = TRUE,elevation = 5),
                    box(title = "Potreros 2021",leafletOutput("plot1_21") ,status = "warning"
                                 ,width = 4,maximizable = TRUE,elevation = 5)),
                    fluidRow(box(title = "Series temporales NDVI potreros",plotlyOutput("ndvi"),status = "warning"
                        ,width = 12,maximizable = TRUE,elevation = 5))
                    
                    
            ),
            tabItem(tabName = "modulo2",
                    
                             sidebarLayout(sidebarPanel(box(title = "Métricas modelo Punta Estero",
                                                            textOutput("ndvi_ml_pe_mae"),br(),
                                                            textOutput("ndvi_ml_pe_rmsle"),
                                                            status = "primary",width = 12),width = 4),
                                 mainPanel(box(title = "Modelo ML-DL NDVI Punta Estero",plotlyOutput("ndvi_ml_pe"),status = "warning"
                                 ,width = 12,maximizable = TRUE,elevation = 5),width = 8)),
                             sidebarLayout(sidebarPanel(box(title = "Métricas modelo Laurel",
                                                            textOutput("ndvi_ml_la_mae"),br(),
                                                            textOutput("ndvi_ml_la_rmsle"),
                                                            status = "primary",width = 12),width = 4),
                                 mainPanel(box(title = "Modelo ML-DL NDVI Laurel",plotlyOutput("ndvi_ml_la"),status = "warning"
                                 ,width = 12,maximizable = TRUE,elevation = 5),width = 8))
                    
                    
            )
            )))
)



