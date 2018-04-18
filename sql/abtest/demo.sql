select
       t3.queue_name as "队列",
			 t3.videoid as "视频id",
       t3.rec_show_num as "曝光量",
       t3.rec_play_num as "播放量",
       t3.rec_playduration as "播放时长",
       round((case when cast(t3.rec_show_num as double)>0 then cast(t3.rec_play_num as double)/cast(t3.rec_show_num as double) else 0 end),4) as "ctr",
       round((case when cast(t3.rec_play_num as double)>0 then cast(t3.rec_playduration as double)/cast(t3.rec_play_num as double) else 0 end),4) as "平均播放时长",
       round((case when cast(t3.rec_duration as double)>0 then cast(t3.rec_playduration as double)/cast(t3.rec_duration as double) else 0 end),4) as "播放完成度"
from
    (select t1.queue_name,t2.videoid,
            sum(case when t2.eventid='event_clientshow' then 1 else 0 end) as rec_show_num, 
            sum(case when t2.eventid='play' then 1 else 0 end) as rec_play_num,
            sum(case when t2.eventid='play' and cast(coalesce(t2.playduration,'0') as bigint)>0 and cast(coalesce(t2.duration,'0') as bigint)>0 and cast(coalesce(t2.playduration,'0') as bigint)>cast(coalesce(t2.duration,'0') as bigint)*10 then cast(coalesce(t2.duration,'0') as bigint)*10
                     when t2.eventid='play' and cast(coalesce(t2.playduration,'0') as bigint)>0 and cast(coalesce(t2.duration,'0') as bigint)>0 and cast(coalesce(t2.playduration,'0') as bigint)<=cast(coalesce(t2.duration,'0') as bigint)*10
                     then cast(coalesce(t2.playduration,'0') as bigint) else 0 end) as rec_playduration,
            sum(case when t2.eventid='play' and cast(coalesce(t2.playduration,'0') as bigint)>0 and cast(coalesce(t2.duration,'0') as bigint)>0 and cast(coalesce(t2.duration,'0') as bigint)<7200
                     then cast(coalesce(t2.duration,'0') as bigint) else 0 end) as rec_duration
    from
        (select impressionid,videoid,queue_name,count(*)
         from ods_logs.ods_bobo_recommend_user_video
         CROSS JOIN UNNEST(split(queue,' ')) AS t (queue_name)
         where dt='20180320' and length(impressionid)>0 and length(videoid)>0 and trim(queue_name)='pigsy'
         group by 1,2,3) t1
        inner join
        (select parameters['impressionid'] as impressionid,parameters['videoid'] as videoid,parameters['source'] as source,eventid,
                parameters['playduration'] as playduration,parameters['duration'] as duration
         from dwd_logs.dwd_bobo_fast
         where dt='20180320' and length(parameters['impressionid'])>0 and length(parameters['videoid'])>0 and
         			 (eventid ='play' or eventid='event_clientshow') and parameters['source']='1' and abid like '%507%') t2
         on (t1.impressionid=t2.impressionid and t1.videoid=t2.videoid)
    group by 1,2) t3;
