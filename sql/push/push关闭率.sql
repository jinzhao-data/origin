--push关闭
select t1.dt,t1.abid,t1.locklock,count(t1.locklock)
from
(SELECT dt,
       abid,
       (CASE
            WHEN eventparams['sysOpen'] = 'true'
                 AND (eventparams['setOpen'] in ('true','0','1') )  THEN 'Y'
            ELSE 'n'
        END) AS locklock
FROM dwd_logs.dwd_bobo_fast
WHERE dt >= '20171207' and dt <= '20171207' and eventid ='push_arrive'
  AND abid IN ('133-118','134-118','135-118','136-118') ) t1
group by t1.dt,t1.abid,t1.locklock
