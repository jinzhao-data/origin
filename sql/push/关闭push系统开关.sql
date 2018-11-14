select t1.dt,
       count(t1.udid),
       count(t2.udid)
from
    (select dt,
            udid
     from dwd_logs.dwd_bobo_fast
     where dt >= '20180403'
         and dt <= '20180410'
         and eventid = 'push_arrive'
         and parameters['sysopen'] = 'true'
         and parameters['setopen'] in ('0',
                                       '1',
                                       'true')
     group by dt,
              udid) t1
left JOIN
    (select distinct date_format(date_add('day',-1,parse_datetime(dt,'yyyyMMdd')),'%Y%m%d') as dt,
                     udid
     from dwd_logs.dwd_bobo_fast
     where dt >= '20180404'
         and dt <= '20180411'
         and eventid = 'push_arrive'
         and (parameters['sysopen'] != 'true'
              or parameters['setopen'] not in ('0',
                                               '1',
                                               'true'))) t2 on t1.udid =t2.udid
and t1.dt = t2.dt
group by t1.dt