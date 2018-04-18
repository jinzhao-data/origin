select parameters['vid'] as vid,
                 parameters['shoottype'] as videocome,
                           count(1) as times
from dws_bobo_logs.dws_bobo_sdk_all
where dt = '20180324'
    and eventid = 'event_clientshow'
    and parameters['shoottype'] in ('2',
                                    '20')
group by parameters['vid'] as vid,
                   parameters['shoottype']