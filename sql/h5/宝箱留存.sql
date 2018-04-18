select count(t12.userid),count(t3.userid)
from
(select t1.userid
from
(select distinct dt, userid  from matrix_dim.dim_bobo_sdk_all where dt>='20180311' and dt<='20180312' and eventid = 'app_start' and parameters['new_device_tag'] = 'Y') t1
join
(SELECT distinct dt, parameters['uid'] as uid FROM matrix_log.dws_bobo_h5_log WHERE dt >= '20180311' and dt<='20180312'  and parameters['from'] = '0' and parameters['btnFrom'] = '5') t2
on t1.userid = t2.uid) t12
left join
(select distinct date_format(date_add('day',-1,parse_datetime(dt,'yyyyMMdd')),'%Y%m%d') as dt, userid  from matrix_dim.dim_bobo_sdk_all where dt>='20180312' and dt<='20180313' and eventid = 'app_start') t3
on t12.userid = t3.userid
