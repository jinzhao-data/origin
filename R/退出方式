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
       PARAMETERS['exittype'] AS exittype,
                 count(1) AS counttimes,
                 count(DISTINCT udid) AS countudids
FROM dws_bobo_logs.dws_bobo_sdk_all
WHERE dt >= date_format(date_add('day',-8,CURRENT_DATE),'%Y%m%d')
    AND dt <= date_format(date_add('day',-1,CURRENT_DATE),'%Y%m%d')
    AND eventid = 'exit'
GROUP BY dt,
         PARAMETERS['exittype']
                   ORDER BY dt DESC")
today <- str_c("/Users/jinzhao/Desktop/data/", "exittype", as.character(Sys.Date()), 
    ".xlsx")
write.xlsx(res, today)
dbDisconnect(con)
