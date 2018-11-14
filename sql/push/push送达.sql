select dt,
       count(1) as c,
       count(distinct udid) as dau
from dwd_logs.dwd_bobo_fast
where dt >='20180606'
    and dt <= '20180607'
    and eventid = 'push_arrive'
group by dt