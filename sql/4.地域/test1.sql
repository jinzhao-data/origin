# coding=utf-8
select t1.cty,(case when (t2.udid is not null) then 'new' else 'old' end ) as utype
    ,count(t1.udid),count(t3.udid)
from
(select (case when resolve_ip(ip)[3] in ('北京',
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
'台湾') then 'white' else 'black' end) as cty,udid
from dwd_logs.dwd_bobo_fast where dt ='20180512'  and eventid = 'app_start' group by 1,2) t1
left join
(select udid from dwd_logs.dwd_bobo_new_user where dt = '20180512') t2
on t1.udid = t2.udid
left join
(select udid from dwd_logs.dwd_bobo_fast where
dt ='20180513'
and eventid = 'app_start'
group by udid) t3
on t1.udid =t3.udid
group by t1.cty,(case when (t2.udid is not null) then 'new' else 'old' end )

select t1.cty,(case when (t2.udid is not null) then 'new' else 'old' end ) as utype,
    count(t1.udid)
from
(select (case when wrap_ip(ip)[3] in ('北京',
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
'台湾') then 'white' else 'black' end) as cty,udid
from dwd_logs.dwd_bobo_fast where dt ='20180512'  and eventid = 'app_start' group by 1,2) t1
left join
(select udid from dwd_logs.dwd_bobo_new_user where dt = '20180512') t2
on t1.udid = t2.udid
group by t1.cty,(case when (t2.udid is not null) then 'new' else 'old' end )
