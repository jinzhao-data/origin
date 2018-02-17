select t3.tag_name,t1.vid,sum(t1.showtimes)

from

(select parameters['videoId'] as vid,

    count(case when  eventid = 'event_clientshow' then '1' else null end) as showtimes

from matrix_log.dwv_bobo_sdk where city in  ('北京市','上海市','广州市','深圳市','成都市','杭州市','广汉市','德阳市','都江堰')

and  dt = '20180131' and

eventid in ('event_clientshow')

group by parameters['videoId']

order by showtimes desc) t1

left join (

    select

      video_id,

     tag_id

    from

      dim_mp.dim_mp_rec_video

  ) t2 on t1.vid = t2.video_id

  left join (

    select

      id,

      tag_name

    from

      dim_mp.dim_mp_rec_video_tag

  ) t3 on t3.id = t2.tag_id where t3.tag_name is null or t3.tag_name ='其他（废弃）'

  group by t3.tag_name,t1.vid
