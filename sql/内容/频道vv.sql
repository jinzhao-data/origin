select month(parse_datetime(dt,'yyyyMMdd')),
       parameters['channelid'] as chid,
                 count(case
                           when eventid = 'event_clienshow' then 1
                           else null
                       end) as shows,
                 count(case
                           when eventid = 'play' then 1
                           else null
                       end) as vv
from dws_bobo_logs.dws_bobo_sdk_all
where dt >='20171101'
    and dt <= '20180331'
    and eventid in ('event_clienshow',
                    'play')
    and parameters['source'] = '1'
    and parameters['channelid'] in ('106',
                                    '109',
                                    '103',
                                    '113')
group by month(parse_datetime(dt,'yyyyMMdd')),
         parameters['channelid']