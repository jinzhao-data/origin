SELECT date_format(parse_datetime(t2.dt,'yyyyMMdd'),'%Y-%m-%d') AS dt,
       round(cast(COUNT(DISTINCT CASE
                                     WHEN (date_diff('day',parse_datetime(t2.dt,'yyyyMMdd'),parse_datetime(t1.dt,'yyyyMMdd')) = 1) THEN t1.udid
                                     ELSE NULL
                                 END) AS DOUBLE)/cast(COUNT(DISTINCT CASE
                                                                         WHEN (date_diff('day',parse_datetime(t2.dt,'yyyyMMdd'),parse_datetime(t1.dt,'yyyyMMdd')) = 0) THEN t1.udid
                                                                         ELSE NULL
                                                                     END) AS DOUBLE),3) AS FIRST,
       round(cast(COUNT(DISTINCT CASE
                                     WHEN (date_diff('day',parse_datetime(t2.dt,'yyyyMMdd'),parse_datetime(t1.dt,'yyyyMMdd')) = 2) THEN t1.udid
                                     ELSE NULL
                                 END) AS DOUBLE)/cast(COUNT(DISTINCT CASE
                                                                         WHEN (date_diff('day',parse_datetime(t2.dt,'yyyyMMdd'),parse_datetime(t1.dt,'yyyyMMdd')) = 0) THEN t1.udid
                                                                         ELSE NULL
                                                                     END) AS DOUBLE),3) AS SECOND,
       round(cast(COUNT(DISTINCT CASE
                                     WHEN (date_diff('day',parse_datetime(t2.dt,'yyyyMMdd'),parse_datetime(t1.dt,'yyyyMMdd')) = 3) THEN t1.udid
                                     ELSE NULL
                                 END) AS DOUBLE)/cast(COUNT(DISTINCT CASE
                                                                         WHEN (date_diff('day',parse_datetime(t2.dt,'yyyyMMdd'),parse_datetime(t1.dt,'yyyyMMdd')) = 0) THEN t1.udid
                                                                         ELSE NULL
                                                                     END) AS DOUBLE),3) AS third,
       round(cast(COUNT(DISTINCT CASE
                                     WHEN (date_diff('day',parse_datetime(t2.dt,'yyyyMMdd'),parse_datetime(t1.dt,'yyyyMMdd')) = 4) THEN t1.udid
                                     ELSE NULL
                                 END) AS DOUBLE)/cast(COUNT(DISTINCT CASE
                                                                         WHEN (date_diff('day',parse_datetime(t2.dt,'yyyyMMdd'),parse_datetime(t1.dt,'yyyyMMdd')) = 0) THEN t1.udid
                                                                         ELSE NULL
                                                                     END) AS DOUBLE),3) AS four,
       round(cast(COUNT(DISTINCT CASE
                                     WHEN (date_diff('day',parse_datetime(t2.dt,'yyyyMMdd'),parse_datetime(t1.dt,'yyyyMMdd')) = 5) THEN t1.udid
                                     ELSE NULL
                                 END) AS DOUBLE)/cast(COUNT(DISTINCT CASE
                                                                         WHEN (date_diff('day',parse_datetime(t2.dt,'yyyyMMdd'),parse_datetime(t1.dt,'yyyyMMdd')) = 0) THEN t1.udid
                                                                         ELSE NULL
                                                                     END) AS DOUBLE),3) AS five,
       round(cast(COUNT(DISTINCT CASE
                                     WHEN (date_diff('day',parse_datetime(t2.dt,'yyyyMMdd'),parse_datetime(t1.dt,'yyyyMMdd')) = 6) THEN t1.udid
                                     ELSE NULL
                                 END) AS DOUBLE)/cast(COUNT(DISTINCT CASE
                                                                         WHEN (date_diff('day',parse_datetime(t2.dt,'yyyyMMdd'),parse_datetime(t1.dt,'yyyyMMdd')) = 0) THEN t1.udid
                                                                         ELSE NULL
                                                                     END) AS DOUBLE),3) AS six,
       round(cast(COUNT(DISTINCT CASE
                                     WHEN (date_diff('day',parse_datetime(t2.dt,'yyyyMMdd'),parse_datetime(t1.dt,'yyyyMMdd')) = 7) THEN t1.udid
                                     ELSE NULL
                                 END) AS DOUBLE)/cast(COUNT(DISTINCT CASE
                                                                         WHEN (date_diff('day',parse_datetime(t2.dt,'yyyyMMdd'),parse_datetime(t1.dt,'yyyyMMdd')) = 0) THEN t1.udid
                                                                         ELSE NULL
                                                                     END) AS DOUBLE),3) AS seven
FROM
    (SELECT dt,
            udid
     FROM hive.dwd_bobo."dwd_bobo_fast"
     WHERE dt >= date_format(date_add('day',-8,CURRENT_DATE),'%Y%m%d')
         AND dt <= date_format(date_add('day',-1,CURRENT_DATE),'%Y%m%d')
         AND eventid = 'app_start'
     GROUP BY 1,
              2) t1
JOIN
    (SELECT dt,
            udid
     FROM dwd_bobo.dwd_bobo_new_user
     WHERE dt >= date_format(date_add('day',-8,CURRENT_DATE),'%Y%m%d')
         AND dt <= date_format(date_add('day',-2,CURRENT_DATE),'%Y%m%d') ) t2 ON t1.udid = t2.udid
GROUP BY 1
ORDER BY 1