-- 有启动无刷新无播放新老用户数
select t1.usertype,count(distinct t1.udid) as c
from
     (select parameters['new_device_tag'] as usertype, udid
      from dws_bobo_logs.dws_bobo_sdk_all
      where dt ='20180530'
          and eventid ='app_start'
      group by 1,2) t1
left join
     (select udid
      from dwd_logs.dwd_bobo_fast
      where dt='20180530'
          and eventid in ('refresh_by_pull_down',
                          'refresh_by_home_top_tab',
                          'refresh_by_home_bottom_tab',
                          'refresh_by_pull_up',
                          'refresh_by_last_tip',
                          'play') t2
where t2.udid is null
group by 1
