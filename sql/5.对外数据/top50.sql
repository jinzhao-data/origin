select t12.*,
       t3.*
from
    (select t1.userid,
            t1.times,
            t2.vidcount
     from
         (select parameters['owner'] as userid,
                           count(1) as times
          from dws_bobo_logs.dws_bobo_sdk_all
          where dt >= '20180101'
              and dt <='20180331'
              and eventid = 'play'
          group by parameters['owner']
          order by times desc
          limit 500) t1
     left join
         (select userid,
                 count(1) as vidcount
          from dim_mp.dim_mp_video_info
          where format_datetime(from_unixtime(cast (createtime as bigint)),'yyyyMMdd') >= '20171101'
              and format_datetime(from_unixtime(cast (createtime as bigint)),'yyyyMMdd') <= '20171231'
          group by userid) t2 on t1.userid = cast(t2.userid as varchar)
     where t2.userid is not null
     order by t1.times desc
     limit 50) t12
join
    (select userid,
            nickname
     from dim_mp.dim_mp_user_info) t3 on t12.userid = cast(t3.userid as varchar)