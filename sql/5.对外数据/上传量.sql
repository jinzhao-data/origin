select format_datetime(from_unixtime(cast (createtime as bigint)),'yyyyMM') as month,
       count(1) as times
from dim_mp.dim_mp_video_info
where format_datetime(from_unixtime(cast (createtime as bigint)),'yyyyMMdd') >= '20171001'
    and format_datetime(from_unixtime(cast (createtime as bigint)),'yyyyMMdd') <= '20180331'
group by format_datetime(from_unixtime(cast (createtime as bigint)),'yyyyMM')