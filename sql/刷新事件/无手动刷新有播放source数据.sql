
select t3.s,
       count(1) as times
from
    (select t1.udid
     from
         (select udid
          from dwd_logs.dwd_bobo_fast
          where dt = '20180414'
              and eventid = 'app_start'
          group by udid) t1
     left JOIN
         (select udid
          from dwd_logs.dwd_bobo_fast
          where dt = '20180414'
              and eventid in ( 'refresh_by_pull_down',
                               'refresh_by_home_top_tab',
                               'refresh_by_home_bottom_tab',
                               'refresh_by_pull_up',
                               'refresh_by_last_tip')
          group by udid) t2 on t1.udid = t2.udid
     where t2.udid is null) t12
join
    (select udid,
            parameters['source'] as s
     from dws_bobo_logs.dws_bobo_sdk_all
     where dt = '20180414'
         and eventid ='play'
     group by udid,
              parameters['source']) t3 on t12.udid = t3.udid
group by t3.s