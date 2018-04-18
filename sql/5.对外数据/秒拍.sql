--- 累计用户数
SELECT month(parse_datetime(dt,'yyyyMMdd')) as m,count(distinct unique_id) as times FROM hive.dwd_logs.dwd_mp_sdk_unique_id WHERE dt>='20170101' and dt <= '20180331'
group by month(parse_datetime(dt,'yyyyMMdd'))
---mau
select month(parse_datetime(dt,'yyyyMMdd')) as month,
       count(distinct udid) as mau
from dwd_logs.dwd_mp_sdk_fast
where dt >='20170901'
    and dt <= '20180331'
    and event['eventid'] ='start'
group by month(parse_datetime(dt,'yyyyMMdd'))

--dau
select dt,
       count(distinct unique_id) as dau
from dwd_logs.dwd_mp_sdk_fast
where dt >='20170901'
    and dt <= '20180331'
    and event['eventid'] ='start'
group by dt
--dakaicishu
select dt,
       count(distinct unique_id) as dau
from dwd_logs.dwd_mp_sdk_fast
where dt >='20170901'
    and dt <= '20180331'
    and event['eventid'] ='start'
group by dt
---liucun
select t1.dt,count(t1.unique_id),count(t2.unique_id)
from
(select distinct dt ,unique_id from dwd_logs.dwd_mp_sdk_unique_id where dt > '20170930' and dt <='20171031') t1
left JOIN
(select distinct date_format(date_add('day',-1,parse_datetime(dt,'yyyyMMdd')),'%Y%m%d') as dt,unique_id from  dwd_logs.dwd_mp_sdk_fast where  dt > '20170930' and dt <='20171031' and
event['eventid'] ='start') t2
on t1.dt = t2.dt and t1.unique_id = t2.unique_id
