SELECT dt,
       parameters['watchtype'] as wtype,
                 count(1) as times,
                 count(distinct udid) as dau
FROM dwd_logs.dwd_bobo_fast
WHERE dt >= '20180403'
    and dt <= '20180404'
    and eventid = 'play'
group by dt,
         parameters['watchtype']