select dt,
       count(1) as times,
       count(distinct udid) as dau
from dwd_logs.dwd_bobo_fast
where dt >= '20180201' and dt <= '20180222'
and eventid = 'main_tab_click' and PARAMETERS['tab'] ='我的'
group by dt 
