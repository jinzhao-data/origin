select t1.*,(case when t2.udid is not null then 1 else 0 end) as win,t2.onlinetimes
from
(select udid,pcid,
      count(case when eventid = 'app_start' then 1 else null) as appstrart,
      count(distinct (case when eventid = 'play' then parameters['vid'] else null end)) as vidcount,
      sum(case when parameters['is_rec_show']='Y' then 1 else 0 end) as showtimes,
      sum(case when parameters['is_rec_play']='Y' then 1 else 0 end ) as click,
      count(case when eventid='play' then 1 else null end) as vv,
      sum(case when eventid='play' then cast(coalesce(parameters['playduration'],'0')as bigint) else 0 end) as vvtimes,
      sum(case when eventid='play' then cast(coalesce(parameters['duration'],'0')as bigint) else 0 end) as alltimes
from dws_bobo_logs.dws_bobo_sdk_all
where dt = '20171220' and parameters['new_device_tag'] = 'Y' group by udid,pcid) t1
left join
(select udid,count(distinct dt) as onlinetimes from dws_bobo_logs.dws_bobo_sdk_all where dt >= '20171221'  and dt <= '20171227' and eventid = 'app_start') t2
on t1.udid = t2.udid
