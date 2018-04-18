select t12.dt,
       t12.type,
       count(t12.udid) as first,
       count(t3.udid) as secday
from
    (select t1.dt,
            t2.type,
            t1.udid
     from
         (select distinct dt,
                          udid
          from matrix_log.dwv_bobo_sdk
          where dt >= '20180303'
              and dt <= '20180308'
              and eventid = 'app_start') t1
     join
         (select *
          from tmp.jinzhao_csv) t2 on t1.udid = t2.scorce) t12
left join
    (select distinct date_format(date_add('day',-1,parse_datetime(dt,'yyyyMMdd')),'%Y%m%d') as dt,
                     udid
     from matrix_log.dwv_bobo_sdk
     where dt >= '20180304'
         and dt <= '20180309'
         and eventid = 'app_start') t3 on t12.dt =t3.dt
and t12.udid = t3.udid
group by t12.dt,
         t12.type