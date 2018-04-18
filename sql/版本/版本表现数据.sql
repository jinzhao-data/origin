select dt,
       count(distinct case
                          when eventid = 'app_start' then udid
                          else null
                      end) as dau_vname,
       sum(CASE
               WHEN eventid='exit' THEN cast(coalesce(PARAMETERS['exittime'],'0')AS bigint)
               ELSE 0
           END) AS usetimes,
       sum(CASE
               WHEN eventid='play' THEN cast(coalesce(PARAMETERS['playduration'],'0')AS bigint)
               ELSE 0
           END) AS playtimes,
       count(CASE
                 WHEN eventid='play' THEN 1
                 ELSE NULL
             END) AS vv,
       sum(CASE
               WHEN PARAMETERS['is_rec_show']='Y' THEN 1
               ELSE 0
           END) AS showtimes
from dws_bobo_logs.dws_bobo_sdk_all
where dt = '20180323'
    and eventid in ('play',
                    'event_clientshow',
                    'exit',
                    'app_start')
    and vname = '2.5.6'
group by dt