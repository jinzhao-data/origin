--一级城市白名单次日留存
select t1.dt,t1.city,count(t1.udid) as all,count(t2.udid) as retain,
         round(cast(count(t2.udid) as double)/cast(count(t1.udid) as double),4) as re
from
(select dt,parameters ['city'] as city,
    udid
from matrix_dim.dim_bobo_sdk_all
where dt >= '20180410' and dt <='20180422' and eventid  = 'app_start'
and parameters ['city'] in
('北京',
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
'台湾')
group by dt,parameters ['city'],udid) t1
left JOIN
(select date_format(date_add('day',-1,parse_datetime(dt,'yyyyMMdd')),'%Y%m%d') as dt,
    udid
from matrix_dim.dim_bobo_sdk_all
where dt >= '20180411' and dt <='20180423' and eventid  = 'app_start'
group by date_format(date_add('day',-1,parse_datetime(dt,'yyyyMMdd')),'%Y%m%d'),udid ) t2
on t1.dt = t2.dt and t1.udid =t2.udid
group by t1.dt,t1.city
