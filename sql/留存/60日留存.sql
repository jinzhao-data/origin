
select t1,
       dt,
       count(t1.udid) as fisrt,
       count(t2.udid) as next
from
    (select dt,
            udid
     from dws_bobo_logs.dwd_bobo_new_user
     where dt >= '20180120'
         and dt <= '20180128') t1
left JOIN
    (select date_format(date_add('day',-60,parse_datetime(dt,'yyyyMMdd')),'%Y%m%d') as dt,
            udid
     from dws_bobo_logs.dws_bobo_sdk_all
     where dt >= '20180321'
         and dt <= '20180329'
         and eventid = 'app_start'
     group by date_format(date_add('day',-60,parse_datetime(dt,'yyyyMMdd')),'%Y%m%d'),
              udid) t2 on t1.udid = t2.udid
and t1.dt = t2.dt
group by t1.dt