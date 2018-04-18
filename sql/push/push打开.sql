--push打开
select dt, (case when (t1.app in ('0','1','true') and t1.sys = 'true') then '2open'
            when (t1.app in ('0','1','true') and t1.sys = 'false') then 'appopensyslock'
            when (t1.app in ('2','false') and t1.sys = 'true') then 'applocksysopen'
            when (t1.app in ('2','false') and t1.sys = 'false') then '2lock'
            else 'unkown' end) as pushstatus,count(distinct udid ) as dau
from
(select dt,udid,parameters['sysopen'] as sys,parameters['setopen'] as app from dwd_logs.dwd_bobo_fast
WHERE dt >= '20180406' and dt <= '20180410' and eventid ='push_arrive'
group by dt,udid,parameters['sysopen'],parameters['setopen']) t1
group by dt,(case when (t1.app in ('0','1','true') and t1.sys = 'true') then '2open'
            when (t1.app in ('0','1','true') and t1.sys = 'false') then 'appopensyslock'
            when (t1.app in ('2','false') and t1.sys = 'true') then 'applocksysopen'
            when (t1.app in ('2','false') and t1.sys = 'false') then '2lock'
            else 'unkown' end)
