select dt,
       count(1) as times,
       count(distinct udid) as countDis_udid
from dwd_logs.dwd_bobo_fast
where dt > ='20180401'
    and dt <='20180420'
    and eventid = 'video_uninterested_btn_click'
group by dt