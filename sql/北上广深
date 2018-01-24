select  dt,
    (case when split(ip_info,'|')[5] in ('北京市','上海市','广州市','深圳市','成都市','杭州市','广汉市','德阳市','都江堰') then '北上广'
    else 'other' end),
    count(distinct case when eventid='app_start' then udid else null end) as dau_city,
    sum(case when eventid='event_clientshow' then 1 else 0 end) as showtimes,
    sum(case when eventid='play' then 1 else 0 end) as vv,
    sum(case when eventid='play' then cast(coalesce(parameters['playDuration'],'0')as bigint) else 0 end) as vvtimes,
    sum(case when eventid='play' then cast(coalesce(parameters['duration'],'0')as bigint) else 0 end) as alltimes,
    sum(case when eventid  in ('refresh_auto','refresh_by_pull_down','refresh_by_home_top_tab',
  'refresh_by_svideo_bottom_tab','refresh_by_home_bottom_tab',
  'refresh_by_pull_up','refresh_by_last_tip','play','event_clientshow') then 1 else 0 end) as refreshtimes,
    count (distinct (case when eventid  in ('refresh_auto','refresh_by_pull_down','refresh_by_home_top_tab',
  'refresh_by_svideo_bottom_tab','refresh_by_home_bottom_tab',
  'refresh_by_pull_up','refresh_by_last_tip','play','event_clientshow') then udid else null end)) as refreshuser
from
dwd_logs.dwd_mpjs_log
where dt >= '20180101' and dt<='20180109'  and length(split(ip_info,'|')[5])>1 and
eventid in ('app_start','event_clientshow','play','refresh_auto','refresh_by_pull_down','refresh_by_home_top_tab',
  'refresh_by_svideo_bottom_tab','refresh_by_home_bottom_tab',
  'refresh_by_pull_up','refresh_by_last_tip','play','event_clientshow')
group by dt,(case when split(ip_info,'|')[5] in ('北京市','上海市','广州市','深圳市','成都市','杭州市','广汉市','德阳市','都江堰') then '北上广'
else 'other' end)
