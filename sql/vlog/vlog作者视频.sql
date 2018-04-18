select t1.videoid,
       t1.userid,
from
    (select videoid,
            userid
     from dim_mp.dim_mp_video_info) t1
join
    (select uid
     from trek_tmp.jinzhao_vlog3) t2 on t1.userid = cast(t2.uid as bigint)