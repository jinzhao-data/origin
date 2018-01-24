####按点击数排top5000数据
select t1.*
from
(select dt,
  parameters['vid']  as videoid,
  parameters['tag_name'] as tag_name,
  parameters['video_title'] as video_title,
  parameters['rec_video_sex_tag'] as rec_video_sex_tag,
  parameters['shoottype'] as plat,
  count(case when eventid = 'play' then 1 else null end) as vv,
  sum(case when parameters['is_rec_show']='Y' then 1 else 0 end) as showtimes,
  sum(case when parameters['is_rec_play']='Y' then 1 else 0 end ) as click,
  sum(case when eventid='play' then cast(coalesce(parameters['playduration'],'0')as bigint) else 0 end) as vvtimes,
  sum(case when eventid='play' then cast(coalesce(parameters['duration'],'0')as bigint) else 0 end) as alltimes
 from dws_bobo_logs.dws_bobo_sdk_all
 where dt ='20180102'
  and parameters['new_device_tag'] = 'Y'
  and eventid in ('play','event_clientshow')
group by dt,parameters['vid'],
  parameters['tag_name'],
  parameters['rec_video_sex_tag'],
  parameters['shoottype'],
  parameters['video_title']
having  COALESCE(try(sum(case when eventid='play' then cast(coalesce(parameters['playduration'],'0')as bigint) else 0 end)/count(case when eventid = 'play' then 1 else null end)),0) >  110) t1
order by t1.vv desc
limit 5000
####全量数据
select dt,
  parameters['vid']  as videoid,
  parameters['tag_name'] as tag_name,
  parameters['video_title'] as video_title,
  parameters['rec_video_sex_tag'] as rec_video_sex_tag,
  parameters['shoottype'] as plat,
  count(case when eventid = 'play' then 1 else null end) as vv,
  sum(case when parameters['is_rec_show']='Y' then 1 else 0 end) as showtimes,
  sum(case when parameters['is_rec_play']='Y' then 1 else 0 end ) as click,
  sum(case when eventid='play' then cast(coalesce(parameters['playduration'],'0')as bigint) else 0 end) as vvtimes,
  sum(case when eventid='play' then cast(coalesce(parameters['duration'],'0')as bigint) else 0 end) as alltimes
 from dws_bobo_logs.dws_bobo_sdk_all
 where dt >='20180101' and dt <='20180103'
  and parameters['new_device_tag'] = 'Y'
  and eventid in ('play','event_clientshow')
group by dt,parameters['vid'],
  parameters['tag_name'],
  parameters['rec_video_sex_tag'],
  parameters['shoottype'],
  parameters['video_title']
