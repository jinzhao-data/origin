select month(parse_datetime(dt,'yyyyMMdd')) as month,
       count(1),
       count(distinct dt)
from dws_bobo_logs.dws_bobo_sdk_all
where dt >='20171101'
    and dt <= '20180331'
    and eventid ='play'
group by month(parse_datetime(dt,'yyyyMMdd'))