select dt,
       sum(case
               when eventid = 'exit' then cast(COALESCE(parameters['exittime'],'0') as bigint)
               else 0
           end)/60000 as usetime,
       count(case
                 when eventid = 'app_start' then 1
                 else null
             end) as dau
from dws_bobo_logs.dws_bobo_sdk_all
where dt >='20171101'
    and dt <= '20180331'
    and eventid in ('app_start',
                    'exit')
group by dt


---使用时长
select dt,
    sum(cast(COALESCE(parameters['exittime'],'0') as bigint)) as usetime
from dws_bobo_logs.dws_bobo_sdk_all
where dt >='20171101'
    and dt <= '20180331'
    and eventid ='exit'
group by dt
---dau
select dt,
    count(distinct udid) as dau
from dws_bobo_logs.dws_bobo_sdk_all
where dt >='20171101'
    and dt <= '20180331'
    and eventid ='app_start'
group by dt
