SELECT t1.dt,
       count(t1.udid) AS dau,
       sum(t2.showtimes) AS shows,
       sum(t2.click) AS clicks,
       sum(t2.vvtimes) AS vvtime,
       sum(alltimes) AS videotime
FROM
    (SELECT DISTINCT dt,
                     udid
     FROM dwd_logs.dwd_bobo_fast
     WHERE dt>='20171219'
         AND dt<= '20171228'
         AND eventid='event_deep_link'
         AND PARAMETERS['deeplink'] LIKE '%pg=gt%') t1
JOIN
    (SELECT dt,
            udid,
            sum(CASE
                    WHEN PARAMETERS['is_rec_show']='Y' THEN 1
                    ELSE 0
                END) AS showtimes,
            sum(CASE
                    WHEN PARAMETERS['is_rec_play']='Y' THEN 1
                    ELSE 0
                END) AS click,
            sum(CASE
                    WHEN eventid='play' THEN cast(coalesce(PARAMETERS['playduration'],'0')AS bigint)
                    ELSE 0
                END) AS vvtimes,
            sum(CASE
                    WHEN eventid='play' THEN cast(coalesce(PARAMETERS['duration'],'0')AS bigint)
                    ELSE 0
                END) AS alltimes
     FROM dws_bobo_logs.dws_bobo_sdk_all
     WHERE dt>='20171219'
         AND dt<= '20171228'
     GROUP BY dt,
              udid) t2 ON t1.dt= t2.dt
AND t1.udid=t2.udid
GROUP BY t1.dt
ORDER BY t1.dt DESC ####
SELECT dt,
       count(1) AS times,
       count(DISTINCT udid) AS countudid
FROM dwd_logs.dwd_bobo_fast
WHERE dt>='20180119'
    AND eventid='event_deep_link'
    AND PARAMETERS['deeplink'] LIKE '%pg=superman%'
GROUP BY dt