select t1.*,t2.tag_id,t2.title,t3.tag_name,t2.shoot_type,t5.level
from
(select parameters['videoId'] as vid,
    count(case when  eventid = 'event_clientshow' then '1' else null end) as showtimes,
    count(case when (eventid = 'play' and parameters['source'] = '1') then '1' else null end) as click,
    count(case when  eventid = 'play' then 1 else null end) as vv,
    sum(case when eventid = 'play' then cast(coalesce(parameters['duration'],'0') as bigint) else 0 end) as duration,
    sum(case when eventid = 'play' then cast(coalesce(parameters['playDuration'],'0') as bigint) else 0 end) as playduration
from matrix_log.dwv_bobo_sdk where city in  ('北京市','上海市','广州市','深圳市','成都市','杭州市','广汉市','德阳市','都江堰')
and  dt = '20180131' and
eventid in ('event_clientshow','play')
group by parameters['videoId']
order by showtimes desc
limit 5000) t1
left join (
    select
      video_id,
      tag_id,
      title,
      user_id,shoot_type
    from
      dim_mp.dim_mp_rec_video
  ) t2 on t1.vid = t2.video_id
  left join (
    select
      id,
      tag_name
    from
      dim_mp.dim_mp_rec_video_tag
  ) t3 on t3.id = t2.tag_id
left JOIN
(select userid,level from dim_mp.dim_mp_user_level_old) t5 on t2.user_id = t5.userid
