SELECT dt,
       PARAMETERS['channelid'] AS channelId,
                 sum(CASE
                         WHEN PARAMETERS['is_rec_show']='Y' THEN 1
                         ELSE 0
                     END) AS showtimes
FROM dws_bobo_logs.dws_bobo_sdk_all
WHERE format_datetime(from_unixtime(CAST (PARAMETERS['createtime'] AS bigint)),'yyyyMMdd') >='20171231'
    AND format_datetime(from_unixtime(CAST (PARAMETERS['createtime'] AS bigint)),'yyyyMMdd') <='20180106'
    AND dt='20180106'
    AND PARAMETERS['framer_owner_type'] IS NOT NULL
    AND eventid='event_clientshow'
GROUP BY dt,
         PARAMETERS['channelid']