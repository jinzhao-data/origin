

select t12.dt,t12.min_hour, count(t12.udid) as t12countudid,count(t3.udid) as t3countudid
from
(select t1.dt,t1.udid,t1.min_hour
from
(select dt, udid,min(hour) as min_hour from dwd_logs.dwd_bobo_fast where dt = '20171229' group by dt,udid) t1
join
(select udid from dwd_logs.dwd_bobo_new_user where dt = '20171229') t2
on t1.udid = t2.udid) t12
left join
(select distinct udid from dwd_logs.dwd_bobo_fast where dt = '20171230' and eventid = 'app_start') t3
on t12.udid = t3.udid
group by t12.dt,t12.min_hour
union
select t12.dt,t12.min_hour, count(t12.udid) as t12countudid,count(t3.udid) as t3countudid
from
(select t1.dt,t1.udid,t1.min_hour
from
(select dt, udid,min(hour) as min_hour from dwd_logs.dwd_bobo_fast where dt = '20171230' group by dt,udid) t1
join
(select udid from dwd_logs.dwd_bobo_new_user where dt = '20171230') t2
on t1.udid = t2.udid) t12
left join
(select distinct udid from dwd_logs.dwd_bobo_fast where dt = '20171231' and eventid = 'app_start') t3
on t12.udid = t3.udid
group by t12.dt,t12.min_hour
union
select t12.dt,t12.min_hour, count(t12.udid) as t12countudid,count(t3.udid) as t3countudid
from
(select t1.dt,t1.udid,t1.min_hour
from
(select dt, udid,min(hour) as min_hour from dwd_logs.dwd_bobo_fast where dt = '20171231' group by dt,udid) t1
join
(select udid from dwd_logs.dwd_bobo_new_user where dt = '20171231') t2
on t1.udid = t2.udid) t12
left join
(select distinct udid from dwd_logs.dwd_bobo_fast where dt = '20180101' and eventid = 'app_start') t3
on t12.udid = t3.udid
group by t12.dt,t12.min_hour
union
select t12.dt,t12.min_hour, count(t12.udid) as t12countudid,count(t3.udid) as t3countudid
from
(select t1.dt,t1.udid,t1.min_hour
from
(select dt, udid,min(hour) as min_hour from dwd_logs.dwd_bobo_fast where dt = '20180101' group by dt,udid) t1
join
(select udid from dwd_logs.dwd_bobo_new_user where dt = '20180101') t2
on t1.udid = t2.udid) t12
left join
(select distinct udid from dwd_logs.dwd_bobo_fast where dt = '20180102' and eventid = 'app_start') t3
on t12.udid = t3.udid
group by t12.dt,t12.min_hour
