SELECT dt,
       PARAMETERS['from'] AS from_share,
                 count(1) AS times,
                 count(DISTINCT udid) AS from_udids
FROM dwd_logs.dwd_bobo_fast
WHERE dt >= '20180127'
    AND dt <= '20180131'
    AND PARAMETERS['from'] IN ('7',
                               '8',
                               '9')
    AND eventid = 'share_success_way'
GROUP BY dt,
         PARAMETERS['from']