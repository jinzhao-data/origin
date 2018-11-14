select ceiling(cast(t2.low as double)/cast(t2.times as double)) as level,
       count(1)
from
    (select udid,
            sum(case
                    when t2.tp = '1' then 1
                    else 0
                end) as low,
            count(1) as times
         (select udid,parameters['vid'] as vid
          from dws_bobo_logs.dws_bobo_sdk_all
          where dt ='20180423'
              and evnetid = 'play') t1
     JOIN
         (SELECT video_id,
                 trim(tp) as type
          from dim_mp.dim_mp_rec_video
          CROSS JOIN UNNEST(split(rmdlable,',')) as t (tp)) t2 on t1.vid = cast(video_id as VARCHAR)
     group by udid) t2