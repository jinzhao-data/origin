select count(1)
from
(select distinct udid from dwd_logs.dwd_mpjs_log where dt = '20180110' and eventid = 'push_click_notify') t1
left join
(select distinct udid from dws_bobo_logs.dws_bobo_sdk_all where dt <='20180109' and dt >= '20171211' and eventid = 'app_start') t2
on t1.udid = t2.udid where t2.udid is null
