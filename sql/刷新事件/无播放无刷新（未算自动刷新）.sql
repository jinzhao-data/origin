select t1.udid
from
    (select distinct udid
     from dws_bobo_logs.dws_bobo_sdk_all
     where dt ='20180211'
         and eventid ='app_start') t1
left join
    (select distinct udid
     from dws_bobo_logs.dws_bobo_sdk_all
     where dt='20180211'
         and eventid in ('play',
                         'refresh_by_pull_down',
                         'refresh_by_home_top_tab',
                         'refresh_by_home_bottom_tab',
                         'refresh_by_pull_up',
                         'refresh_by_last_tip')) t2 on t1.udid = t2.udid
where t2.udid is null
    select t3.dt,
           count(t1.udid),
           sum(vv),
           sum(vvtimes),
           sum(alltimes)
    from
        (select dt,
                udid,
                count(distinct case
                                   when eventid='play' then udid
                                   else null
                               end) as vvpeople,
                count(case
                          when eventid='play' then 1
                          else null
                      end)as vv,
                sum(case
                        when eventid='play' then cast(COALESCE(parameters['playDuration'],'0')as bigint)
                        else 0
                    end) as vvtimes,
                sum(case
                        when eventid='play' then cast(COALESCE(parameters['duration'],'0')as bigint)
                        else 0
                    end) as alltimes
         from dwd_logs.dwd_bobo_fast
         where dt >= '20180217'
             and dt <= '20180223'
         group by dt,
                  udid) t3
    JOIN
        (select t1.udid
         from
             (select distinct udid
              from dws_bobo_logs.dws_bobo_sdk_all
              where dt ='20180211'
                  and eventid ='app_start') t1
         left join
             (select distinct udid
              from dws_bobo_logs.dws_bobo_sdk_all
              where dt ='20180211'
                  and eventid in ('play',
                                  'refresh_by_pull_down',
                                  'refresh_by_home_top_tab',
                                  'refresh_by_home_bottom_tab',
                                  'refresh_by_pull_up',
                                  'refresh_by_last_tip')) t2 on t1.udid = t2.udid
         where t2.udid is null) t12
group by t3.dt