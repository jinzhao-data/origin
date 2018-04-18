select t1.udid
from
    (select distinct udid
     from dws_bobo_logs.dws_bobo_sdk_all
     where dt = '20180305'
         and eventid = 'app_start') t1
left join
    (
         (select t2.udid
          from
              (select distinct udid
               from dws_bobo_logs.dws_bobo_sdk_all
               where dt = '20180305'
                   and eventid = 'app_start') t2
          join
              (select distinct udid
               from dws_bobo_logs.dws_bobo_sdk_all
               where dt = '20180304'
                   and eventid = 'app_start'
                   and parameters['new_device_tag'] = 'N') t3 on t2.udid = t3.udid)
     union select distinct udid
     from dws_bobo_logs.dws_bobo_sdk_all
     where dt = '20180305'
         and eventid = 'app_start'
         and parameters['new_device_tag'] = 'Y') t4 on t1.udid = t4.udid
where t4.udid is null