library(tidyverse)
library(RPresto)
library(DBI)
library(openxlsx)
library(stringr)
library(lubridate)
options(scipen = 200, digits = 2)
con <- dbConnect(RPresto::Presto(), host = "47.93.29.9", port = 8080, user = "yanagishima", 
    schema = "default", catalog = "hive", source = "yanagishima")
res_sex <- dbGetQuery(con, "SELECT dt,
                      PARAMETERS['rec_video_sex_tag'] AS sex,
                      sum(CASE
                      WHEN PARAMETERS['is_rec_show']='Y' THEN 1
                      ELSE 0
                      END) AS showtimes,
                      sum(CASE
                      WHEN PARAMETERS['is_rec_play']='Y' THEN 1
                      ELSE 0
                      END) AS click,
                      count(CASE
                      WHEN eventid='play' THEN 1
                      ELSE NULL
                      END)AS vv,
                      sum(CASE
                      WHEN eventid='play' THEN cast(coalesce(PARAMETERS['playduration'],'0')AS bigint)
                      ELSE 0
                      END) AS vvtimes,
                      sum(CASE
                      WHEN eventid='play' THEN cast(coalesce(PARAMETERS['duration'],'0')AS bigint)
                      ELSE 0
                      END) AS alltimes
                      FROM dws_bobo_logs.dws_bobo_sdk_all
                      WHERE dt >= date_format(date_add('day',-7,CURRENT_DATE),'%Y%m%d')
                      AND dt <= date_format(date_add('day',-1,CURRENT_DATE),'%Y%m%d')
                      AND PARAMETERS['new_device_tag'] = 'Y'
                      AND eventid IN ('play',
                      'event_clientshow')
                      GROUP BY dt,
                      PARAMETERS['rec_video_sex_tag']
                      order by dt")
res_sex <- res_sex %>% mutate(ctr = click/showtimes, p = vvtimes/alltimes)

res_shoot <- dbGetQuery(con, "SELECT dt,
                        PARAMETERS['shoottype'] AS videofrom,
                        sum(CASE
                        WHEN PARAMETERS['is_rec_show']='Y' THEN 1
                        ELSE 0
                        END) AS showtimes,
                        sum(CASE
                        WHEN PARAMETERS['is_rec_play']='Y' THEN 1
                        ELSE 0
                        END) AS click,
                        count(CASE
                        WHEN eventid='play' THEN 1
                        ELSE NULL
                        END)AS vv,
                        sum(CASE
                        WHEN eventid='play' THEN cast(coalesce(PARAMETERS['playduration'],'0')AS bigint)
                        ELSE 0
                        END) AS vvtimes,
                        sum(CASE
                        WHEN eventid='play' THEN cast(coalesce(PARAMETERS['duration'],'0')AS bigint)
                        ELSE 0
                        END) AS alltimes
                        FROM dws_bobo_logs.dws_bobo_sdk_all
                        WHERE dt >= date_format(date_add('day',-7,CURRENT_DATE),'%Y%m%d')
    AND dt <= date_format(date_add('day',-1,CURRENT_DATE),'%Y%m%d')
                        AND PARAMETERS['new_device_tag'] = 'Y'
                        AND eventid IN ('play',
                        'event_clientshow') and parameters['shoottype'] in ('2','20')
                        GROUP BY dt,
                        PARAMETERS['shoottype']
                        order by dt")
res_shoot <- res_shoot %>% mutate(ctr = click/showtimes, p = vvtimes/alltimes)

res_tag <- dbGetQuery(con, "SELECT dt,
       PARAMETERS['tag_name'] AS tagname,
                      sum(CASE
                      WHEN PARAMETERS['is_rec_show']='Y' THEN 1
                      ELSE 0
                      END) AS showtimes,
                      sum(CASE
                      WHEN PARAMETERS['is_rec_play']='Y' THEN 1
                      ELSE 0
                      END) AS click,
                      count(CASE
                      WHEN eventid='play' THEN 1
                      ELSE NULL
                      END)AS vv,
                      sum(CASE
                      WHEN eventid='play' THEN cast(coalesce(PARAMETERS['playduration'],'0')AS bigint)
                      ELSE 0
                      END) AS vvtimes,
                      sum(CASE
                      WHEN eventid='play' THEN cast(coalesce(PARAMETERS['duration'],'0')AS bigint)
                      ELSE 0
                      END) AS alltimes
                      FROM dws_bobo_logs.dws_bobo_sdk_all
                      WHERE dt >= date_format(date_add('day',-7,CURRENT_DATE),'%Y%m%d')
                      AND dt <= date_format(date_add('day',-1,CURRENT_DATE),'%Y%m%d')
                      AND PARAMETERS['new_device_tag'] = 'Y'
                      AND eventid IN ('play',
                      'event_clientshow')
                      GROUP BY dt,
                      PARAMETERS['tag_name']
                      ORDER BY showtimes DESC
                      LIMIT 10")
res_tag <- res_tag %>% mutate(ctr = click/showtimes, p = vvtimes/alltimes)

res_top <- dbGetQuery(con, "SELECT dt,
       (CASE
                      WHEN pcid LIKE '%vivo%' THEN 'vivo'
                      WHEN pcid LIKE '%oppo%' THEN 'oppo'
                      WHEN pcid LIKE '%wifi%' THEN 'wifi'
                      ELSE 'otherpcid'
                      END) AS pcid_sum,
                      sum(CASE
                      WHEN PARAMETERS['is_rec_show']='Y' THEN 1
                      ELSE 0
                      END) AS showtimes,
                      sum(CASE
                      WHEN PARAMETERS['is_rec_play']='Y' THEN 1
                      ELSE 0
                      END) AS click,
                      count(CASE
                      WHEN eventid='play' THEN 1
                      ELSE NULL
                      END)AS vv,
                      sum(CASE
                      WHEN eventid='play' THEN cast(coalesce(PARAMETERS['playduration'],'0')AS bigint)
                      ELSE 0
                      END) AS vvtimes,
                      sum(CASE
                      WHEN eventid='play' THEN cast(coalesce(PARAMETERS['duration'],'0')AS bigint)
                      ELSE 0
                      END) AS alltimes
                      FROM dws_bobo_logs.dws_bobo_sdk_all
                      WHERE dt >= date_format(date_add('day',-3,CURRENT_DATE),'%Y%m%d')
                      AND dt <= date_format(date_add('day',-1,CURRENT_DATE),'%Y%m%d')
                      AND PARAMETERS['new_device_tag'] = 'Y'
                      AND eventid IN ('play',
                      'event_clientshow')
                      GROUP BY dt, (CASE
                      WHEN pcid LIKE '%vivo%' THEN 'vivo'
                      WHEN pcid LIKE '%oppo%' THEN 'oppo'
                      WHEN pcid LIKE '%wifi%' THEN 'wifi'
                      ELSE 'otherpcid'
                      END)
                      order by dt")
res_top <- res_top %>% mutate(ctr = click/showtimes, p = vvtimes/alltimes)

today <- str_c("/Users/jinzhao/Desktop/data/", "dailyreport", as.character(Sys.Date()), 
    ".xlsx")
wb <- createWorkbook()
addWorksheet(wb, "sex")
addWorksheet(wb, "shoot")
addWorksheet(wb, "tag")
addWorksheet(wb, "top")
writeData(wb, "sex", res_sex)
writeData(wb, "shoot", res_shoot)
writeData(wb, "tag", res_tag)
writeData(wb, "top", res_top)
saveWorkbook(wb, today, overwrite = TRUE)
dbDisconnect(con)
