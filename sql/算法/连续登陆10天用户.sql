select tf.vid,sum(tf.showtimes) as shows,sum(playtimes) as clicks,sum(tf.playduration) as play,sum(duration) as vidtime
from
(select t23.*
from
(select udid,count(distinct dt) as startDay from dws_bobo_logs.dws_bobo_sdk_all
where dt>= '20180226' and dt <= '20180307' and eventid ='app_start'
group by udid
having count(distinct dt) = 10) t1
JOIN
(select t2.udid,t2.vid,t2.showtimes,t3.playtimes,t3.playduration,t3.duration
from
(select udid,parameters['vid'] as vid,count(1) as showtimes
from dws_bobo_logs.dws_bobo_sdk_all where dt ='20180307' and eventid ='event_clientshow'
group by udid,parameters['vid']) t2
left join
(select udid,parameters['vid'] as vid,count(1) as playtimes,
sum(cast(COALESCE(PARAMETERS['duration'],'0') as bigint)) as duration,
sum(cast(COALESCE(PARAMETERS['playduration'],'0') as bigint))  as playduration
from dws_bobo_logs.dws_bobo_sdk_all
where dt ='20180307' and eventid ='play' group by udid,parameters['vid']) t3
on t2.vid = t3.vid and t2.udid = t3.udid) t23
on t1.udid = t23.udid) tf
group by tf.vid  having sum(playtimes) is null
order by shows desc
limit  200

###白名单
select tf.vid,sum(tf.showtimes) as shows,sum(playtimes) as clicks,sum(tf.playduration) as play,sum(duration) as vidtime
from
(select t23.*
from
(select udid,count(distinct dt) as startDay from dws_bobo_logs.dws_bobo_sdk_all
where dt>= '20180226' and dt <= '20180307' and eventid ='app_start'
group by udid
having count(distinct dt) = 10) t1
JOIN
(select t2.udid,t2.vid,t2.showtimes,t3.playtimes,t3.playduration,t3.duration
from
(select udid,parameters['vid'] as vid,count(1) as showtimes
from dws_bobo_logs.dws_bobo_sdk_all where dt ='20180307' and eventid ='event_clientshow'
group by udid,parameters['vid']) t2
left join
(select udid,parameters['vid'] as vid,count(1) as playtimes,
sum(cast(COALESCE(PARAMETERS['duration'],'0') as bigint)) as duration,
sum(cast(COALESCE(PARAMETERS['playduration'],'0') as bigint))  as playduration
from dws_bobo_logs.dws_bobo_sdk_all
where dt ='20180307' and eventid ='play' group by udid,parameters['vid']) t3
on t2.vid = t3.vid and t2.udid = t3.udid) t23
on t1.udid = t23.udid) tf
group by tf.vid  having sum(playtimes) is null
order by shows desc
limit  200
