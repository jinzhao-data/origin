select t1.dt,t1.citytype,t2.tag_id,count(1) as shows
from
(select  dt,(case when split(ip_info,'|')[5] in ('北京市','上海市','广州市','深圳市','成都市','杭州市','广汉市','德阳市','都江堰') then '北上广'
else 'other' end) as citytype,
parameters['videoId'] as vid
from dwd_logs.dwd_mpjs_log
where  dt >='20180128' and dt <= '20180131' and
eventid = 'event_clientshow') t1
left join
(select cast(video_id as varchar) as vid,tag_id from dim_mp.dim_mp_rec_video) t2
on t1.vid = t2.vid
group by t1.dt,t1.citytype,t2.tag_id
