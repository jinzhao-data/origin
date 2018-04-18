select dt,
  count(distinct udid) as tab_dau,count(1) as tab_times,sum(cast(nvl(parameters['durartion'],0) as bigint)) as sumduration
from
  matrix_log.dwv_bobo_sdk
where
  dt >= '20180224' and dt <= '20180302'
  and eventid = 'main_tab_changed' and parameters['tab'] = '关注'
group by dt






#####
select dt,
  count(distinct udid) as tab_dau,count(1) as tab_times,sum(cast(coalesce(parameters['duration'],'0') as bigint)/1000) as sumduration
from
  dwd_logs.dwd_bobo_fast
where
  dt >= '20180224' and dt <= '20180302'
  and eventid = 'main_tab_changed' and parameters['tab'] = '关注'
group by dt

####
select dt,
  count(case when eventid = 'event_clientshow' then 1 else null end) as playtimes,
  sum(case when eventid = 'play' then cast(coalesce(parameters['duration'],'0') as bigint) else 0 end) as playduration
from
  dwd_logs.dwd_bobo_fast
where
  dt >= '20180301' and dt <= '20180307'
  and eventid in ('play','event_clientshow') and parameters['source'] = '5'
group by dt




####
select dt,count(case when eventid = 'video_up' then 1 else null end) as video_uptimes,
        count(case when eventid = 'comment_click' then 1 else null end) as comment_clicktimes,
        count(case when eventid = 'blank_area_click_play' then 1 else null end) as blank_area_click_playtimes
from dwd_logs.dwd_bobo_fast where dt >= '20180224' and dt <= '20180302'
and eventid in ('blank_area_click_play','video_up','comment_click ')
group by dt


####
select dt,count(distinct udid ) as followtabdau，count(1) as tims
from dwd_logs.dwd_bobo_fast where dt >= '20180301' and dt <= '20180307'
and eventid = 'follow_tab_pv' and PARAMETERS['page'] = '3' group by dt
