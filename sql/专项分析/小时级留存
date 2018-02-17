select t3.hour,count(t3.udid) as startudid,count(t2.udid) as replaceudid
from
(select hour(from_unixtime(cast(t1.logtime as bigint))) as hour,t1.udid
from((select *,Row_Number() OVER (PARTITION BY udid ORDER BY logtime) as rank
from dws_bobo_logs.dws_bobo_sdk_all
where dt = '20180117' and eventid = 'app_start'
and parameters['new_device_tag'] = 'Y') t1) where t1.rank = 1) t3
left join
(select distinct udid from dws_bobo_logs.dws_bobo_sdk_all where dt = '20180118' and eventid = 'app_start') t2
on t3.udid = t2.udid
group by t3.hour
order by t3.hour
