select parameters['vid'] as vid,
                 parameters['duration'] as duration
from dws_bobo_logs.dws_bobo_sdk_all
where dt = '20180703'
    and eventid ='play'
group by 1,
         2