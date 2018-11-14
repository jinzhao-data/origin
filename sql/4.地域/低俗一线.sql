select t1.dt,
       t1.city,
       count(t1.udid),
       count(t2.udid)
from
    (select dt,
            city,
            udid
     from matrix_log.dwv_bobo_sdk
     where dt = '20180420'
         and eventid = 'app_start'
     group by dt,
              city,
              udid) t1
JOIN (trek_tmp.jinzhao_disu1) t3 on t1.city = t3.city
left join
    (select udid
     from matrix_log.dwv_bobo_sdk
     where dt = '20180421'
         and eventid = 'app_start'
     group by udid) t2 on t1.udid = t2.udid
group by t1.dt,
         t1.city ---

select t1.dt,
       t1.city,
       t1.utype count(t1.udid),
                count(t2.udid)
from
    (select dt,
            parameters['city'] as city,
                      parameters['new_device_tag'] as utype udid
     from matrix_dim.dim_bobo_sdk_all
     where dt = '20180420'
         and eventid = 'app_start'
     group by 1,
              2,
              3,
              4) t1
JOIN (trek_tmp.jinzhao_disu1) t3 on t1.city = t3.city
left join
    (select udid
     from matrix_dim.dim_bobo_sdk_all
     where dt = '20180421'
         and eventid = 'app_start'
     group by udid) t2 on t1.udid = t2.udid
group by t1.dt,
         t1.utype,
         t1.city