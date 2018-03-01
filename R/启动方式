#! /usr/local/bin/R
library(tidyverse)
library(rpivotTable)
library(clipr)
library(RPresto)
library(DBI)
library(openxlsx)
library(stringr)
library(lubridate)
con <- dbConnect(RPresto::Presto(), host = "47.93.29.9", port = 8080, user = "yanagishima", 
    schema = "default", catalog = "hive", source = "yanagishima")
res <- dbGetQuery(con, "SELECT dt,
       PARAMETERS['sdk_from'] AS sdk_from,
                   count(DISTINCT udid) AS countudid
                   FROM dws_bobo_logs.dws_bobo_sdk_all
                   WHERE dt >= date_format(date_add('day',-8,current_date),'%Y%m%d')
                   AND dt <= date_format(date_add('day',-1,current_date),'%Y%m%d')
                   AND eventid = 'app_start'
                   GROUP BY dt,
                   PARAMETERS['sdk_from']
                   ORDER BY dt DESC")
today <- str_c("/Users/jinzhao/Desktop/data/", "starttype", as.character(Sys.Date()), 
    ".xlsx")
write.xlsx(res, today)
dbDisconnect(con)
