SELECT dt,
       vname,
       sum(CASE
               WHEN eventid = 'app_start' THEN 1
               ELSE 0
           END) AS app_start,
       count(DISTINCT CASE
                          WHEN eventid = 'app_start' THEN udid
                          ELSE NULL
                      END) AS vname_dau,
       sum(CASE
               WHEN eventid = 'exit' THEN cast(coalesce(PARAMETERS['exittime'],'0')AS bigint)
               ELSE 0
           END) AS usetime
FROM dws_bobo_logs.dws_bobo_sdk_all
WHERE dt >= '20180126'
    AND vname IN ('1.9.2',
                  '1.9.7')
    AND eventid IN ('exit',
                    'app_start')
GROUP BY dt,
         vname
ORDER BY dt