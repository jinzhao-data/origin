####push到达展现点击
select t1.dt,t2.type,sum(t1.push_arrive),sum(t1.push_show_notify),sum(t1.push_click_notify)
from
(select dt,udid,
sum(if(t.eventid='push_arrive',1,0)) push_arrive,
sum(if(t.eventid='push_show_notify',1,0)) push_show_notify,
sum(if(t.eventid='push_click_notify',1,0)) push_click_notify
from matrix_log.dwv_bobo_sdk t
where t.dt >='20180303' and t.dt >='20180308'
and t.eventid in('push_arrive','push_show_notify','push_click_notify')
group by t.dt,t.udid) t1
join
(select * from tmp.jinzhao_csv ) t2
on t1.udid = t2.scorce
group by t1.dt,t2.type


####次留
select t12.dt,t12.type,count(t12.udid) as first,count(t3.udid) as secday
from
(select t1.dt,t2.type,t1.udid
from
(select distinct dt,udid from matrix_log.dwv_bobo_sdk where dt >= '20180303' and dt <= '20180308'  and eventid = 'app_start')  t1
join
(select * from tmp.jinzhao_csv) t2
on t1.udid = t2.scorce) t12
left join
(select distinct date_format(date_add('day',-1,parse_datetime(dt,'yyyyMMdd')),'%Y%m%d') as dt,udid from matrix_log.dwv_bobo_sdk where
dt >= '20180304' and dt <= '20180309' and eventid = 'app_start') t3
on t12.dt =t3.dt and t12.udid = t3.udid
group by t12.dt,t12.type

####使用时长与人均vv
select t1.dt,sum(vv) as vvall, sum(alltimes) as usetime
from
(select dt,
        udid,
        count(CASE
                  WHEN eventid='play' THEN 1
                  ELSE NULL
              END)AS vv,
        sum(CASE
                WHEN eventid='exit' THEN cast(coalesce(PARAMETERS['duration'],'0') AS bigint)
                ELSE 0
            END) AS alltimes
 from matrix_dim.dim_bobo_sdk_all
 where dt >= '20180303'
     and dt <= '20180308'
     and eventid in ('exit',
                     'play') group by dt,udid) t1
join
(select * from tmp.jinzhao_csv) t2
on t1.udid = t2.scorce
group by t1.dt
