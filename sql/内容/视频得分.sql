select parameters['vid'] as vid,
                 from_unixtime(parameters['createtime']) as orgintime,
                 count(1) as playtimes
from dwd_logs.dws_bobo_sdk_all
where dt >='20180401'
    and dt <= '20180425'
    and mact(dt - from_unixtime(createtime)) < 7
group by parameters['vid']
having playtimes > 1000000