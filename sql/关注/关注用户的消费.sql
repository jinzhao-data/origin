select t12.dt,
       cast(count(distinct udid) as bigint),
       cast(sum(t12.showtimes) as bigint),
       cast(sum(t12.click) as bigint),
       cast(sum(t12.vv) as bigint),
       cast(sum(t12.vvtimes) as bigint),
       cast(sum(t12.alltimes) as bigint)
from
    (select t1.*,
            t2.*
     from
         (select DISTINCT userid
          from dim_bobo.dim_bobo_followuser) t2
     join
         (select dt,
                 udid,
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
                         WHEN eventid='play' THEN cast(nvl(PARAMETERS['playduration'],0)AS bigint)
                         ELSE 0
                     END) AS vvtimes,
                 sum(CASE
                         WHEN eventid='play' THEN cast(nvl(PARAMETERS['duration'],0)AS bigint)
                         ELSE 0
                     END) AS alltimes
          from matrix_dim.dim_bobo_sdk_all
          where dt >= '20180228'
              and dt <= '20180301'
              and eventid in ('event_clientshow',
                              'play')
          group by dt,
                   udid) t1 on t1.udid = t2.userid) t12
group by t12.dt