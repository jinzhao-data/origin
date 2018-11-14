select t1.dt,
       t1.abid,
       count(t1.udid) as startdau,
       count(t2.udid) as nextdau,
       sum(t1.starttimes) as startimes,
       sum(t1.usetime) as usetm,
       sum(t1.playtime) as ptimes,
       sum(t1.exits) as exittimes,
       sum(t1.showtimes) as shows,
       SUm(t1.vv) as vvs
from
    (select dt,
            (case
                 when abid like '%596%' then '596'
                 when abid like '%597%' then '597'
                 when abid like '%598%' then '598'
                 else '599'
             end) as abid,
            udid,
            count(case
                      when eventid = 'app_start' then 1
                      else null
                  end) as starttimes,
            count(case
                      when eventid = 'event_clientshow' then 1
                      else null
                  end) as showtimes,
            count(case
                      when eventid = 'play' then 1
                      else null
                  end) as vv,
            sum(CASE
                    WHEN eventid='play' THEN cast(coalesce(PARAMETERS['playduration'],'0')AS bigint)
                    ELSE 0
                END) AS playtime,
            sum(CASE
                    WHEN eventid='exit' THEN cast(coalesce(PARAMETERS['duration'],'0')AS bigint)
                    ELSE 0
                END)/1000 AS usetime,
            count(case
                      when eventid = 'exit' then 1
                      else null
                  end) as exits
     from dws_bobo_logs.dws_bobo_sdk_all
     where (abid like '%596%'
            or abid like '%597%'
            or abid like '%598%'
            or abid like '%599%')
         and dt >= '20180407'
         and dt <= '20180409'
         and eventid in ('exit',
                         'play',
                         'event_clientshow',
                         'app_start')
     group by 1,
              2,
              3) t1
left JOIN
    (select distinct date_format(date_add('day',-1,parse_datetime(dt,'yyyyMMdd')),'%Y%m%d') as dt,
                     udid
     from dws_bobo_logs.dws_bobo_sdk_all
     where dt >= '20180408'
         and dt <= '20180410'
         and eventid = 'app_start') t2 on t1.dt =t2.dt
and t1.udid = t2.udid
group by t1.dt,
         t1.abid