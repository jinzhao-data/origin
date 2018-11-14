SELECT dt,
       count(1) AS times,
       count(DISTINCT udid) AS count_udid
FROM dwd_logs.dwd_bobo_fast
WHERE dt >= '20180715'
    AND dt <= '20180730'
    AND eventid = 'ShootPlugin_download'
    AND PARAMETERS['downloadstate'] = '1'
GROUP BY dt
ORDER BY dt