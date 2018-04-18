select t1.m,
       t1.m,
       ceiling(t1.vv/100000),
       count(1) as num
from
    (select month(parse_datetime(dt,'yyyyMMdd')) as m,
            parameters['vid'] as vid,
                      count(1) as vv
     from dws_bobo_logs.dws_bobo_sdk_all
     where dt >= '20171101'
         and dt <='20180331'
         and eventid = 'event_clienshow'
     group by month(parse_datetime(dt,'yyyyMMdd')),
              parameters['vid']) t1
group by t1.m,
         ceiling(t1.vv/100000) --hive

select t1.m,
       ceiling(t1.vv/10000),
       count(1)
from
    (select month(from_unixtime(unix_timestamp(dt,'yyyyMMdd'),'yyyy-MM-dd')) as m,
            parameters['vid'] as vid,
                      count(1) as vv
     from dws_bobo_logs.dws_bobo_sdk_all
     where dt >= '20171101'
         and dt <='20171231'
     group by month(from_unixtime(unix_timestamp(dt,'yyyyMMdd'),'yyyy-MM-dd')),
              parameters['vid']) t1
group by t1.m,
         ceiling(t1.vv/10000)