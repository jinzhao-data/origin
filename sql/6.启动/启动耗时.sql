select dt,
       parameters['from'] as frm,
                 sum(cast(parameters['spend'] as bigint)) as spendtime,
                 count(1) times
from dwd_logs.dwd_bobo_fast
where dt >='20180401'
    and eventid = 'app_start_finish'
    and cast(parameters['spend'] as bigint) > 0
    and cast(parameters['spend'] as bigint) < 10000
group by dt,
         parameters['from']