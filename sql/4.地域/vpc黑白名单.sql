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



select t1.white_black,(case when (t2.udid is not null) then 'new' else 'old' end) as utype,
sum(t1.usemins) as utimes,sum(t1.showtimes) as shows,
sum(t1.click) as clicks,sum(t1.vvtimes) as vvtime,sum(t1.alltimes) as alltime
from
(select (case when (resolve_ip(ip)[3] in
    ('珠海','北京','上海','广州','深圳','杭州','成都','都江堰','广汉','德阳','海外','香港','澳门','台湾'))
    then 'white' else 'other' end) as white_black,udid,
    sum(case
            when eventid = 'exit' then cast(coalesce(parameters['exittime'],'0') as bigint)
            else 0
        end)/60000 as usemins,
        sum(CASE
        WHEN eventid = 'event_clientshow' THEN 1
        ELSE 0
        END) AS showtimes,
        sum(CASE
        WHEN eventid = 'play' THEN 1
        ELSE 0
        END) AS click,
        sum(CASE
        WHEN eventid='play' THEN cast(coalesce(PARAMETERS['playduration'],'0')AS bigint)
        ELSE 0
        END) AS vvtimes,
        sum(CASE
        WHEN eventid='play' THEN cast(coalesce(PARAMETERS['duration'],'0')AS bigint)
        ELSE 0
        END) AS alltimes
from dwd_logs.dwd_bobo_fast where dt = '20180512' and eventid in ('exit','play','event_clientshow')
group by 1,2) t1
left join
(select udid from dwd_logs.dwd_bobo_new_user where dt = '20180512') t2
on t1.udid = t2.udid
group by t1.white_black,(case when (t2.udid is not null) then 'new' else 'old' end)
