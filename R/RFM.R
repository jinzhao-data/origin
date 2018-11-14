library(tidyverse)
library(RPresto)
library(DBI)
library(rgl)
con <- dbConnect(RPresto::Presto(), host = "47.93.29.9", port = 8080, user = "yanagishima", 
    schema = "default", catalog = "hive", source = "yanagishima")
res <- dbGetQuery(con, "select t1.udid,t2.r,t2.f,t2.M
                       from
                  (select udid from dwd_logs.dwd_bobo_new_user where dt = '20180401') t1
                  join
                  (select udid,
                  date_diff('day',parse_datetime(max(dt),'yyyyMMdd'),parse_datetime('20180407','yyyyMMdd'))  as r,
                  count(distinct case when eventid = 'app_start' then dt else null end) as f,
                  count(case when eventid = 'play' then 1 else null end)  as m
                  from dws_bobo_logs.dws_bobo_sdk_all
                  where dt >= '20180401' and dt <= '20180407'
                  and eventid in ('play','app_start') group by udid ) t2
                  on t1.udid = t2.udid")
dt <- mutate(res, M = ifelse(m > 2000, 2000, m)) %>% select(-3) %>% column_to_rownames(var = "udid") %>% 
    scale(center = T, scale = T)
km <- kmeans(dt, centers = 8)
