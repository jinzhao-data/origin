select t1.udid
from
    (select udid
     from dws_bobo_logs.dws_bobo_sdk_all
     where dt ='20180411'
         and eventid ='app_start'
     group by udid) t1
left join
    (select udid
     from dwd_logs.dwd_bobo_fast
     where dt='20180411'
         and eventid in ('refresh_by_pull_down',
                         'refresh_by_home_top_tab',
                         'refresh_by_home_bottom_tab',
                         'refresh_by_pull_up',
                         'refresh_by_last_tip')
     group by udid) t2 on t1.udid = t2.udid
where t2.udid is null