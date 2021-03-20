# China_administrative-division-codes£¨1980-2019£©
# https://github.com/hezht3/

require(rvest)
require(dplyr)
require(haven)

website <- readRDS("F:/Box Sync/air polution/pilot analysis/China_administrative-division-codes/China administrative codes of each year_original website.rds")

city_code_year <- list()


# year 2017 - 2019: read data from html and clean to dataset
for(i in 1:3) {
  web <- read_html(website$html[i], encoding = "UTF-8")
  year <- website$year[i]
  
  city_code <- web %>% html_nodes("td") %>% html_text() %>% as.data.frame()
  city_code_id <- city_code[seq(1, nrow(city_code), 2), ]
  city_code_city <- city_code[seq(0, nrow(city_code), 2), ]
  
  city_code_year[[year]] <- bind_cols(city_code_id, city_code_city)
  colnames(city_code_year[[year]]) <- c("id", "city")
}


# year 1980 - 2016: read data from html
for(i in 4:nrow(website)) {
  web <- read_html(website$html[i], encoding = "UTF-8")
  year <- website$year[i]
  
  city_code_year[[year]] <- web %>% html_nodes("td") %>% html_text() %>% as.data.frame() %>% filter(. != "")
}

## year 1980 - 1982, 2006: clean data to dataset
for(year in c(1980, 1981, 1982, 2016)) {
  city_code <- city_code_year[[year]]
  city_code <- as.data.frame(city_code[4:(nrow(city_code)-3), ])
  city_code_id <- city_code[seq(1, nrow(city_code), 2), ]
  city_code_city <- city_code[seq(0, nrow(city_code), 2), ]
  city_code_year[[year]] <- bind_cols(city_code_id, city_code_city)
  colnames(city_code_year[[year]]) <- c("id", "city")
}

## year 1983 - 1985, 1988 - 2012: clean data to dataset
for(year in c(1983:1985, 1988:2012)) {
  city_code <- city_code_year[[year]]
  city_code <- as.data.frame(city_code[4:(nrow(city_code)-2), ])
  city_code_id <- city_code[seq(1, nrow(city_code), 2), ]
  city_code_city <- city_code[seq(0, nrow(city_code), 2), ]
  city_code_year[[year]] <- bind_cols(city_code_id, city_code_city)
  colnames(city_code_year[[year]]) <- c("id", "city")
}

## year 1986 - 1987
for(year in c(1986, 1987)) {
  city_code <- city_code_year[[year]]
  city_code <- as.data.frame(city_code[8:(nrow(city_code)-393), ])
  city_code_id <- city_code[seq(1, nrow(city_code), 2), ]
  city_code_city <- city_code[seq(0, nrow(city_code), 2), ]
  city_code_year[[year]] <- bind_cols(city_code_id, city_code_city)
  colnames(city_code_year[[year]]) <- c("id", "city")
}

## year 2013 - 2015: clean data to dataset
for(year in c(2013, 2014, 2015)) {
  city_code <- city_code_year[[year]]
  city_code <- as.data.frame(city_code[4:(nrow(city_code)-1), ])
  city_code_id <- city_code[seq(1, nrow(city_code), 2), ]
  city_code_city <- city_code[seq(0, nrow(city_code), 2), ]
  city_code_year[[year]] <- bind_cols(city_code_id, city_code_city)
  colnames(city_code_year[[year]]) <- c("id", "city")
}


# save data
for(year in c(1980:2019)) {
  city_code <- city_code_year[[year]]
  saveRDS(city_code, file = paste("F:/Box Sync/air polution/pilot analysis/China_administrative-division-codes/dataset/rds version/city admin id_", year, ".rds", sep = ""))
  write.csv(city_code, file = paste("F:/Box Sync/air polution/pilot analysis/China_administrative-division-codes/dataset/csv version/city admin id_", year, ".csv", sep = ""), fileEncoding = "UTF-8")
}