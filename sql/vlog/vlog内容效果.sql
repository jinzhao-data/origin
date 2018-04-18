select t1.*
from
    (select dt,
            PARAMETERS['vid'] as vid,
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
     from matrix_dim.dim_bobo_sdk_all
     where dt >= '20180405'
         and dt <= '20180407'
         and eventid in ('play',
                         'event_clientshow')
     group by dt,
              PARAMETERS['vid']) t1
JOIN
    (select vid
     from trek_tmp.jinzhao_vlog) t2 on t1.vid = t2.vid