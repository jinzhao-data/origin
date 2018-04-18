--miaopai

select dt,
       count(case
                 when event['eventid'] = 'play' then 1
                 else null
             end) as usetime,
       count(distinct case
                          when event['eventid'] = 'start' then unique_id
                          else null
                      end) as dau
from dwd_logs.dwd_mp_sdk_fast
where dt >='20171101'
    and dt <= '20180331'
    and event['eventid'] in ('start',
                             'play')
group by dt