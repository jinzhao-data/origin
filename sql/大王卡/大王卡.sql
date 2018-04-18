
select t1.dt,
       count(t1.udid),
       sum(t1.vv),
       sum(t1.usetimes)
from
    (select dt,
            udid,
            count(CASE
                      WHEN eventid='play' THEN 1
                      ELSE NULL
                  END) AS vv,
            sum(CASE
                    WHEN eventid='exit' THEN cast(coalesce(PARAMETERS['exittime'],'0')AS bigint)
                    ELSE 0
                END)/1000 AS usetimes
     from dws_bobo_logs.dws_bobo_sdk_all
     where dt >='20180324'
         and dt <= '20180325'
         and eventid in ('play',
                         'exit')
     group by dt,
              udid) t1
join
    (select distinct dt,
                     udid
     from dwd_logs.dwd_bobo_fast
     where dt >='20180324'
         and dt <= '20180325'
         and eventid = 'event_free_king_card_user_status'
         and parameters['status'] = '1') t2 on t1.dt = t2.dt
and t1.udid = t2.udid
group by t1.dt