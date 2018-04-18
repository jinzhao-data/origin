select dt,
       count(1) as times
from dwd_logs.dwd_bobo_fast
where dt >= '20171101'
    and dt<= '20180331'
    and eventid = 'share_success_way'
group by dt