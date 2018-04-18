SELECT dt,
       (CASE
            WHEN pcid LIKE '%vivo%' THEN 'vivo'
            WHEN pcid LIKE '%oppo%' THEN 'oppo'
            WHEN pcid LIKE '%wifi%' THEN 'wifi'
            ELSE 'otherpcid'
        END) AS pcid_arrge,
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
GROUP BY dt, (CASE
                  WHEN pcid LIKE '%vivo%' THEN 'vivo'
                  WHEN pcid LIKE '%oppo%' THEN 'oppo'
                  WHEN pcid LIKE '%wifi%' THEN 'wifi'
                  ELSE 'otherpcid'
              END)