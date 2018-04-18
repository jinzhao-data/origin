SELECT dt,
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
WHERE dt='20180206'
    AND PARAMETERS['new_device_tag'] = 'Y'
    AND eventid IN ('play',
                    'event_clientshow')
    AND PARAMETERS['shoottype'] IN ('2',
                                    '20')
GROUP BY dt,
         PARAMETERS['shoottype']