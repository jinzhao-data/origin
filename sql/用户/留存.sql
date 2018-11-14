SELECT t2.dt,
       round(cast(COUNT(DISTINCT CASE
                                     WHEN (date_diff('day',parse_datetime(t2.dt,'yyyyMMdd'),parse_datetime(t1.dt,'yyyyMMdd')) = 1) THEN t1.udid
                                     ELSE NULL
                                 END) AS DOUBLE)/cast(COUNT(DISTINCT CASE
                                                                         WHEN (date_diff('day',parse_datetime(t2.dt,'yyyyMMdd'),parse_datetime(t1.dt,'yyyyMMdd')) = 0) THEN t1.udid
                                                                         ELSE NULL
                                                                     END) AS DOUBLE),4) AS FIRST,
       round(cast(COUNT(DISTINCT CASE
                                     WHEN (date_diff('day',parse_datetime(t2.dt,'yyyyMMdd'),parse_datetime(t1.dt,'yyyyMMdd')) = 2) THEN t1.udid
                                     ELSE NULL
                                 END) AS DOUBLE)/cast(COUNT(DISTINCT CASE
                                                                         WHEN (date_diff('day',parse_datetime(t2.dt,'yyyyMMdd'),parse_datetime(t1.dt,'yyyyMMdd')) = 0) THEN t1.udid
                                                                         ELSE NULL
                                                                     END) AS DOUBLE),4) AS SECOND,
       round(cast(COUNT(DISTINCT CASE
                                     WHEN (date_diff('day',parse_datetime(t2.dt,'yyyyMMdd'),parse_datetime(t1.dt,'yyyyMMdd')) = 3) THEN t1.udid
                                     ELSE NULL
                                 END) AS DOUBLE)/cast(COUNT(DISTINCT CASE
                                                                         WHEN (date_diff('day',parse_datetime(t2.dt,'yyyyMMdd'),parse_datetime(t1.dt,'yyyyMMdd')) = 0) THEN t1.udid
                                                                         ELSE NULL
                                                                     END) AS DOUBLE),4) AS third,
       round(cast(COUNT(DISTINCT CASE
                                     WHEN (date_diff('day',parse_datetime(t2.dt,'yyyyMMdd'),parse_datetime(t1.dt,'yyyyMMdd')) = 4) THEN t1.udid
                                     ELSE NULL
                                 END) AS DOUBLE)/cast(COUNT(DISTINCT CASE
                                                                         WHEN (date_diff('day',parse_datetime(t2.dt,'yyyyMMdd'),parse_datetime(t1.dt,'yyyyMMdd')) = 0) THEN t1.udid
                                                                         ELSE NULL
                                                                     END) AS DOUBLE),4) AS four,
       round(cast(COUNT(DISTINCT CASE
                                     WHEN (date_diff('day',parse_datetime(t2.dt,'yyyyMMdd'),parse_datetime(t1.dt,'yyyyMMdd')) = 5) THEN t1.udid
                                     ELSE NULL
                                 END) AS DOUBLE)/cast(COUNT(DISTINCT CASE
                                                                         WHEN (date_diff('day',parse_datetime(t2.dt,'yyyyMMdd'),parse_datetime(t1.dt,'yyyyMMdd')) = 0) THEN t1.udid
                                                                         ELSE NULL
                                                                     END) AS DOUBLE),4) AS five,
       round(cast(COUNT(DISTINCT CASE
                                     WHEN (date_diff('day',parse_datetime(t2.dt,'yyyyMMdd'),parse_datetime(t1.dt,'yyyyMMdd')) = 6) THEN t1.udid
                                     ELSE NULL
                                 END) AS DOUBLE)/cast(COUNT(DISTINCT CASE
                                                                         WHEN (date_diff('day',parse_datetime(t2.dt,'yyyyMMdd'),parse_datetime(t1.dt,'yyyyMMdd')) = 0) THEN t1.udid
                                                                         ELSE NULL
                                                                     END) AS DOUBLE),4) AS six,
       round(cast(COUNT(DISTINCT CASE
                                     WHEN (date_diff('day',parse_datetime(t2.dt,'yyyyMMdd'),parse_datetime(t1.dt,'yyyyMMdd')) = 7) THEN t1.udid
                                     ELSE NULL
                                 END) AS DOUBLE)/cast(COUNT(DISTINCT CASE
                                                                         WHEN (date_diff('day',parse_datetime(t2.dt,'yyyyMMdd'),parse_datetime(t1.dt,'yyyyMMdd')) = 0) THEN t1.udid
                                                                         ELSE NULL
                                                                     END) AS DOUBLE),4) AS seven
FROM
    (SELECT dt,
            udid
     FROM hive.dwd_bobo."dwd_bobo_fast"
     WHERE dt >= '20181021'
         AND dt <='20181028'
         AND eventid = 'app_start'
     GROUP BY 1,
              2) t1
JOIN
    (SELECT dt,
            udid
     FROM dwd_bobo.dwd_bobo_new_user
     WHERE dt >= '20181021'
         AND dt <='20181027' ) t2 ON t1.udid = t2.udid
GROUP BY t2.dt
ORDER BY t2.dt