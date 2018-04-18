select month(parse_datetime(dt,'yyyyMMdd')) as month,
       count(1) as mau
from dwd_logs.dwd_bobo_new_user
where dt >='20171101'
    and dt <= '20180331'
group by month(parse_datetime(dt,'yyyyMMdd'))