select t1.dt,
       count(1)
from
    (SELECT dt,
            udid
     FROM dwd_logs.dwd_bobo_fast
     WHERE dt >= '20180113'
         and dt <= '20180118'
         and eventid = 'push_click_notify') t1
join
    (select dt,
            udid
     from dwd_logs.dwd_bobo_new_user
     where dt >= '20180113'
         and dt <= '20180118' ) t2 on t1.udid = t2.udid
and t1.dt =t2.dt
group by t1.dt
order by t1.dt desc