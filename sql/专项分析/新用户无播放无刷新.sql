select t7.*,
       t9.*
from
    (select t6.*
     from
         (select t5.*,
                 Row_Number() OVER (PARTITION BY t5.dt
                                    ORDER BY t5.times DESC) as times_rank
          from
              (select t12.dt,
                      t3.vid,
                      count(1) as times
               from
                   (select t1.dt,
                           t1.udid
                    from
                        (select distinct dt,
                                         udid
                         from dws_bobo_logs.dws_bobo_sdk_all
                         where dt ='20180227'
                             and eventid ='app_start') t1
                    left join
                        (select distinct dt,
                                         udid
                         from dwd_logs.dwd_bobo_fast
                         where dt ='20180227'
                             and eventid in ('play',
                                             'refresh_by_pull_down',
                                             'refresh_by_home_top_tab',
                                             'refresh_by_home_bottom_tab',
                                             'refresh_by_pull_up',
                                             'refresh_by_last_tip')) t2 on t1.udid = t2.udid
                    and t1.dt = t2.dt
                    where t2.udid is null) t12
               join
                   (select dt,
                           udid,
                           parameters['vid'] as vid
                    from dws_bobo_logs.dws_bobo_sdk_all
                    where dt ='20180227'
                        and eventid = 'event_clientshow') t3 on t3.dt = t12.dt
               and t3.udid = t12.udid
               group by t12.dt,
                        t3.vid) t5) t6
     where t6.times_rank <1000) t7
left join
    (select dt,
            parameters['vid'] as vid,
                      sum(CASE
                              WHEN PARAMETERS['is_rec_show']='Y' THEN 1
                              ELSE 0
                          END) AS showtimes,
                      sum(CASE
                              WHEN PARAMETERS['is_rec_play']='Y' THEN 1
                              ELSE 0
                          END) AS click
     from dws_bobo_logs.dws_bobo_sdk_all
     where dt ='20180227'
         and eventid in ('play',
                         'event_clientshow')
     group by dt,
              parameters['vid']) t9 on t7.vid = t9.vid
and t7.dt = t9.dt