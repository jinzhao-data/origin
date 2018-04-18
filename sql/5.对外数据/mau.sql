select month(parse_datetime(dt,'yyyyMMdd')) as month,
       count(distinct udid) as mau
from dws_bobo_logs.dws_bobo_sdk_all
where dt >='20171101'
    and dt <= '20180331'
    and eventid ='app_start'
group by month(parse_datetime(dt,'yyyyMMdd'))