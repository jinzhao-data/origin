select t1.udid,
       date_diff('day',parse_datetime(min(t1.dt),'yyyyMMdd'),parse_datetime(max(t1.dt),'yyyyMMdd'))
FROM
    (select dt,
            udid
     from dws_bobo_logs.dws_bobo_sdk_all
     where dt >= '20180201'
         and dt <= '20180307'
         and eventid = 'app_start'
     group by dt,
              udid) t1
JOIN
    (select udid
     from dwd_logs.dwd_bobo_new_user
     where dt = '20180201') t2 on t1.udid = t2.udid
group by t1.udid