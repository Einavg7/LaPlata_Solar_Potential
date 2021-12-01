# municipal buildings analysis
## 105 municipal buildings provided by the city

library(dplyr)
library(sf)
library(spatstat)
library(raster)
library(units)
setwd("C:/Users/einav/Desktop/Thesis data/La Plata")

muni <- read_sf("laplata_build.shp")
muni <- st_transform(muni, "+proj=merc +lon_0=0 +k=1 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs")

muni$elec_prod[muni$area <= 30] <- 0 # 2 buildings under 30^2
muni <- muni[!(muni$elec_prod==0),]
hist(muni$area)
muni$elec_prod_mwh <- muni$elec_prod/1000
hist(muni$elec_prod_mwh)
qqnorm(muni$elec_prod_mwh)
summary(muni[,c(-9,-1:-5)])
sum(muni$elec_prod_mwh)
boxplot(muni$elec_prod_mwh, horizontal=TRUE, main="La Plata Municipal Buildings", xlab = "Renewable Electricity Production Potential (mWh)")

osm <- read_sf("laplata_all.shp")
osm <- st_transform(osm, "+proj=merc +lon_0=0 +k=1 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs")
osm$elec_prod[osm$area <= 30] <- 0
osm_nz <- osm[!(osm$elec_prod==0),]
osm_nz$elec_prod_mwh <- osm_nz$elec_prod/1000
summary(osm_nz$elec_prod_mwh)
boxplot(osm_nz$elec_prod_mwh, horizontal=TRUE, main="La Plata OSM Buildings", xlab = "Renewable Electricity Production Potential (mWh)")
sum(osm_nz$elec_prod_mwh)
