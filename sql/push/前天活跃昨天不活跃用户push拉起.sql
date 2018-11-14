SELECT t1.dt,
       count(t1.udid)
FROM
    (SELECT dt,
            udid
     FROM dws_bobo_logs.dws_bobo_sdk_all
     WHERE dt >= '20180601'
         AND dt <= '20180608'
         AND eventid = 'app_start'
     GROUP BY dt,
              udid) t1
LEFT JOIN
    (SELECT DISTINCT date_format(date_add('day',-1,parse_datetime(dt,'yyyyMMdd')),'%Y%m%d') AS dt,
                     udid
     FROM dws_bobo_logs.dws_bobo_sdk_all
     WHERE dt >= '20180602'
         AND dt <= '20180609'
         AND eventid = 'app_start' ) t2 ON t1.dt =t2.dt
AND t1.udid = t2.udid
INNER JOIN
    (SELECT DISTINCT date_format(date_add('day',-2,parse_datetime(dt,'yyyyMMdd')),'%Y%m%d') AS dt,
                     udid
     FROM dws_bobo_logs.dws_bobo_sdk_all
     WHERE dt >= '20180603'
         AND dt <= '20180610'
         AND eventid = 'app_start') t3 ON t1.dt =t3.dt
AND t1.udid = t3.udid
WHERE t2.udid IS NULL
GROUP BY t1.dt
SELECT t12.dt,
       count(t12.udid) AS c
FROM
    (SELECT t1.dt,
            t1.udid
     FROM
         (SELECT dt,
                 udid
          FROM dws_bobo_logs.dws_bobo_sdk_all
          WHERE dt >= '20180601'
              AND dt <= '20180608'
              AND eventid = 'app_start'
          GROUP BY dt,
                   udid) t1
     LEFT JOIN
         (SELECT DISTINCT date_format(date_add('day',-1,parse_datetime(dt,'yyyyMMdd')),'%Y%m%d') AS dt,
                          udid
          FROM dws_bobo_logs.dws_bobo_sdk_all
          WHERE dt >= '20180602'
              AND dt <= '20180609'
              AND eventid = 'app_start' ) t2 ON t1.dt =t2.dt
     AND t1.udid = t2.udid
     WHERE t2.udid IS NULL) t12
INNER JOIN
    (SELECT DISTINCT date_format(date_add('day',-2,parse_datetime(dt,'yyyyMMdd')),'%Y%m%d') AS dt,
                     udid
     FROM dws_bobo_logs.dws_bobo_sdk_all
     WHERE dt >= '20180603'
         AND dt <= '20180610'
         AND eventid = 'app_start') t3 ON t12.dt =t3.dt
AND t12.udid = t3.udid
GROUP BY t12.dt