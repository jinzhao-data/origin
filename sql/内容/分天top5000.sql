select t2.*
from
    (select t1.*,
            Row_Number() OVER (PARTITION BY t1.dt
                               ORDER BY t1.showtimes DESC) as r
     from
         (select dt,
                 parameters['vid'] as vid,
                           PARAMETERS['shoottype'] AS videofrom,
                                     PARAMETERS['tag_name'] AS tagname,
                                               parameters['video_title'] as title,
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
          from dws_bobo_logs.dws_bobo_sdk_all
          where dt >= '20180221'
              and dt <= '20180222'
              and eventid in ('event_clientshow',
                              'play')
          group by dt,
                   PARAMETERS['shoottype'],parameters['vid'],PARAMETERS['tag_name'],parameters['video_title']) t1) t2
where t2.r <= 1000