select t1.udid,
       t2.r,
       t2.f,
       t2.M
from
    (select udid
     from dwd_logs.dwd_bobo_new_user
     where dt = '20180401') t1
join
    (select udid,
            date_diff('day',parse_datetime('20180401','yyyyMMdd'),parse_datetime(max(dt),'yyyyMMdd')) as r,
            count(distinct case
                               when eventid = 'app_start' then dt
                               else null
                           end) as f,
            count(case
                      when eventid = 'play' then 1
                      else null
                  end) as M
     from dws_bobo_logs.dws_bobo_sdk_all
     where dt >= '20180401'
         and dt <= '20180407'
         and eventid in ('play',
                         'app_start')
     group by udid) t2 on t1.udid = t2.udid