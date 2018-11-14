select t1.dt,
       count(1)
from
    (select dt,
            parameters['impressionid'] as impressionid,
                      parameters['videoid'] as vid,
                                count(1)
     from dwd_logs.dwd_bobo_fast
     where dt >='20180501'
         and dt<='20180507'
         and eventid ='event_clientshow'
     group by 1,
              2,
              3
     HAVING count(1) > 2) t1
group by t1.dt