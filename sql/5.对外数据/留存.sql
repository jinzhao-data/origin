select month(parse_datetime(dt,'yyyyMMdd')),
       avg(p)
from
    (select t1.dt,
            round(cast(count(t2.udid) as double)/cast(count(t1.udid) as double),4) as p
     from
         (select dt,
                 udid
          from dws_bobo_logs.dws_bobo_sdk_all
          where dt >='20171101'
              and dt <= '20180331'
              and eventid = 'app_start'
              and parameters['new_device_tag'] = 'Y'
          group by dt,
                   udid) t1
     left join
         (select date_format(date_add('day',-1,parse_datetime(dt,'yyyyMMdd')),'%Y%m%d') as dt,
                 udid
          from dws_bobo_logs.dws_bobo_sdk_all
          where dt >='20171102'
              and dt <= '20180401'
              and eventid = 'app_start'
          group by date_format(date_add('day',-1,parse_datetime(dt,'yyyyMMdd')),'%Y%m%d'),
                   udid) t2 on t1.dt = t2.dt
     and t1.udid = t2.udid
     group by t1.dt)
group by month(parse_datetime(dt,'yyyyMMdd'))