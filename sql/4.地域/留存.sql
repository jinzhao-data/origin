select count(t2.udid),count(t1.udid),round(cast(count(t2.udid) as double)/cast(count(t1.udid) as double),4) as re
from
(select resolve_ip(ip)[3] as city, udid from dws_bobo_logs.dws_bobo_sdk_all where dt = '20180601' AND eventid = 'app_start'
and parameters['new_device_tag'] = 'Y' and (resolve_ip(ip)[3] in ('北京',
'上海',
'广州',
'深圳',
'成都',
'杭州',
'德阳',
'珠海',
'都江堰',
'广汉',
'海外',
'香港',
'澳门',
'台湾'))) t1
left JOIN
(select udid from dws_bobo_logs.dws_bobo_sdk_all where dt = '20180602' and eventid = 'app_start') t2
on t1.udid = t2.udid
