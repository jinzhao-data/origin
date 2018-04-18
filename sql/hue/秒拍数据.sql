-- 1.业务背景
-- 秒拍运营查看top1000的用户的视频数据表现
-- 字段描述
-- 日期，用户id，昵称，是否涉性，tagid，Vid，标题，标签名称
-- 曝光次数，点击次数，ctr,播放次数，播放时长，视频时长	，时效时间，上传时间，是否原创，是否来源与创作者平台,视频修改标题
-- 注意事项
-- is_first_test=true条件

select * from
(select a.*,Row_Number() OVER (PARTITION BY a.dt ORDER BY a.showtimes desc) rank from
(select dt,eventparams['owner'] as owner,
eventparams['vid'] as vid,eventparams['video_title'] as title,
eventparams['video_ftitle'] as video_ftitle,
eventparams['nick'] as nick,eventparams['tag_name']as tag_name,
eventparams['owner_level'] as level,
sum(case when eventparams['is_rec_show']='Y' then 1 else 0 end)as showtimes,
sum(case when eventparams['is_rec_play']='Y' then 1 else 0 end ) as click,
sum(case when eventparams['is_rec_play']='Y' then 1 else 0 end )/sum(case when eventparams['is_rec_show']='Y' then 1 else 0 end) as CTR,
count(case when eventid='play' then 1 else null end)as vv,
sum(case when eventid='play' then cast(nvl(eventparams['playDuration'],0)as bigint) else 0 end) as vvtimes,
sum(case when eventid='play' then cast(nvl(eventparams['duration'],0)as bigint) else 0 end) as alltimes,
from_unixtime(cast((eventparams['video_expire_time']) as bigint),'yyyy-MM-dd HH:mm:ss') as video_expire_time,
from_unixtime(cast((eventparams['createtime']) as bigint),'yyyy-MM-dd hh:HH:mm:ss') as createtime,
eventparams['owner_original'] as owner_original,
(case when eventparams['framer_owner_type'] is null then 1 else 0 end) as framer
from dwmf_mp.dwm_mp_sdk_all_new
where dt>='20180209' and dt<='20180215' and is_first_test=true
group by dt,eventparams['owner'],
eventparams['vid'],eventparams['video_title'],
eventparams['video_ftitle'],
eventparams['nick'],
eventparams['tag_name'],
eventparams['owner_level'],
from_unixtime(cast((eventparams['createtime']) as bigint),'yyyy-MM-dd hh:HH:mm:ss'),
eventparams['owner_original'],
from_unixtime(cast((eventparams['video_expire_time']) as bigint),'yyyy-MM-dd HH:mm:ss'),
(case when eventparams['framer_owner_type'] is null then 1 else 0 end)
)a
)b
Where b.rank <=1000


日期	用户id	Vid	标题	副标题	昵称	标签	用户等级	曝光次数	点击次数	CTR	播放次数	播放时长	视频时长	时效时间	上传时间 	是否原创	是否创作者平台	展示排名
