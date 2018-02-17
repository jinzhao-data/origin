#! /usr/local/bin/R
library(RJDBC)
library(rJava)
library(DBI)
library(tidyverse)
for (l in list.files("/Users/jinzhao/Documents/lib/")) {
    .jaddClassPath(paste("/Users/jinzhao/Documents/lib/", l, sep = ""))
}
drv <- JDBC("org.apache.hive.jdbc.HiveDriver", "/Users/jinzhao/Documents/lib/hive-jdbc-1.1.0-cdh5.11.2.jar")
conn <- dbConnect(drv, "jdbc:hive2://10.10.13.107:10000", "hive", "hive", characterEncoding = UTF - 
    8)
dt <- dbGetQuery(conn, "select  dt,count(distinct case when eventid = 'play' then udid else null end) as playudidcount,
count(distinct case when eventid = 'app_start' then udid else null end) as startudidcount
from dws_bobo_logs.dws_bobo_sdk_all
where dt >= date_format(date_add('day',-2,CURRENT_DATE),'%Y%m%d')
    AND dt <= date_format(date_add('day',-1,CURRENT_DATE),'%Y%m%d') and
eventid in ('app_start','play')
group by dt")
today <- str_c("/Users/jinzhao/Desktop/data/", "play/app_start", as.character(Sys.Date()), 
    ".xlsx")
write.xlsx(res, today)
dbDisconnect(con)
