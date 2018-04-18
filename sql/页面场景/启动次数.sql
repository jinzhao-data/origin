SELECT dt,
       PARAMETERS['sdk_from'] AS sdk_from,
                 count(1) AS starttimes,
                 count(DISTINCT udid) AS countudid
FROM dws_bobo_logs.dws_bobo_sdk_all
WHERE dt >= date_format(date_add('day',-8,CURRENT_DATE),'%Y%m%d')
    AND dt <= date_format(date_add('day',-1,CURRENT_DATE),'%Y%m%d')
    AND eventid = 'app_start'
GROUP BY dt,
         PARAMETERS['sdk_from']
ORDER BY dt DESC