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
                       PARAMETERS['tab'] AS tab,
                       count(1) as times,
                       count(DISTINCT udid) AS countudid
                       FROM dwd_logs.dwd_bobo_fast
                       WHERE dt >= date_format(date_add('day',-8,current_date),'%Y%m%d')
                       AND dt <= date_format(date_add('day',-1,current_date),'%Y%m%d')
                       AND eventid = 'main_tab_click'
                       GROUP BY dt,
                       PARAMETERS['tab']
                       ORDER BY dt DESC")
today <- str_c("/Users/jinzhao/Desktop/data/", "main_tab_click", as.character(Sys.Date()), 
    ".xlsx")
write.xlsx(res, today)
dbDisconnect(con)
