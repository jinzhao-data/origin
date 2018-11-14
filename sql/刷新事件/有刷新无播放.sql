
select count(t12.udid)
from
    (select count(t1.udid)
     from
         (select udid
          from dws_bobo_logs.dws_bobo_sdk_all
          where dt ='20180530'
              and eventid ='app_start'
          group by udid) t1
     join
         (select udid
          from dwd_logs.dwd_bobo_fast
          where dt='20180530'
              and eventid in ('refresh_by_pull_down',
                              'refresh_by_home_top_tab',
                              'refresh_by_home_bottom_tab',
                              'refresh_by_pull_up',
                              'refresh_by_last_tip')
          group by udid) t2 on t1.udid = t2.udid) t12
left JOIN
    (select udid
     from dwd_logs.dwd_bobo_fast
     where dt = '20180530'
         and eventid = 'play'
     group by udid) t3 on t12.udid =t3.udid
where t3.udid is null