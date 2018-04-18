select t1.dt,
       (case
            when (t1.abid like '%660-166%') then '660'
            when (t1.abid like '%661-166%') then '661'
            when (t1.abid like '%662-166%') then '662'
            else '663'
        end) as AB,
       count(t1.udid),
       count(t2.udid),
       sum(t2.times)
from
    (select dt,
            abid,
            udid
     from dws_bobo_logs.dws_bobo_sdk_all
     where dt >='20180414'
         and dt<= '20180415'
         and eventid ='app_start'
         and (abid like '%660-166%'
              or abid like '%661-166%'
              or abid like '%662-166%'
              or abid like '%663-166%')
         and vname = '2.8.3'
     group by dt,
              abid,
              udid) t1
left join
    (select dt,
            udid,
            count(1) as times
     from dwd_logs.dwd_bobo_fast
     where dt >='20180414'
         and dt<= '20180415'
         and eventid in ('refresh_by_pull_down',
                         'refresh_by_home_top_tab',
                         'refresh_by_home_bottom_tab',
                         'refresh_by_pull_up',
                         'refresh_by_last_tip')
     group by dt,
              udid) t2 on t1.udid = t2.udid
and t1.dt = t2.dt
group by t1.dt,(case
                    when (t1.abid like '%660-166%') then '660'
                    when (t1.abid like '%661-166%') then '661'
                    when (t1.abid like '%662-166%') then '662'
                    else '663'
                end)