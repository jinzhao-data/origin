library(tidyverse)
library(RPresto)
library(DBI)
library(openxlsx)
library(stringr)
library(lubridate)
options(scipen = 200, digits = 2)
con <- dbConnect(RPresto::Presto(), host = "47.93.29.9", port = 8080, user = "yanagishima", 
    schema = "default", catalog = "hive", source = "yanagishima")
res_sex <- dbGetQuery(con, "select ceiling(cast(t2.low as double)/cast(t2.times as double)*100) as level,count(1) as c
from
                      (select udid,sum(case when t2.type = 'low' then 1 else 0 end) as low,count(1) as times
                      from
                      (select udid,parameters['vid'] as vid from dws_bobo_logs.dws_bobo_sdk_all where dt ='20180423' and eventid = 'play') t1
                      JOIN
                      (SELECT video_id,(case when (trim(rmdlable) like '%,1' or trim(rmdlable) like '1,%' or  trim(rmdlable)='1' or trim(rmdlable) like '%,1,%') then 'low' else 'high' end) as type
                      from dim_mp.dim_mp_rec_video) t2
                      on t1.vid = cast(video_id as VARCHAR)
                      group by udid) t2
                      group by ceiling(cast(t2.low as double)/cast(t2.times as double)*100)
                      order by level")
ggplot(res_sex, aes(x = level, y = c)) + geom_point()
head(res_sex)
ggplot(res_sex, aes(level, c)) + geom_point()
