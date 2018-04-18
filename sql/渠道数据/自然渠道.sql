select dt,
       count(1) as dau
from dws_bobo_logs.dws_bobo_sdk_all
where dt >= '20180403'
    and dt <= '20180406'
    and eventid = 'app_start'
    and pcid = 'bb_wx'
group by dt