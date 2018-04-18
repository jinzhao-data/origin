select t1.dt,
       count(t1.udid),
       count(t2.udid)
from
    (select dt,
            udid
     from dwd_logs.dwd_bobo_new_user
     where dt >= '20180311'
         and dt <= '20180312') t1
left join
    (select distinct date_format(date_add('day',-1,parse_datetime(dt,'yyyyMMdd')),'%Y%m%d') as dt,
                     udid
     from dwd_logs.dwd_bobo_fast
     where dt >= '20180312'
         and dt <='20180313'
         and eventid = 'push_click_notify' ) t2 on t1.dt =t2.dt
and t1.udid = t2.udid
group by t1.dt