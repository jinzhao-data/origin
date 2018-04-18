SELECT dt,
       udid,
       count(1) as times
FROM dwd_logs.dwd_bobo_fast
WHERE dt >= '20180403'
    and dt <= '20180404'
    and eventid in ('refresh_by_pull_down',
                    'refresh_by_home_top_tab',
                    'refresh_by_home_bottom_tab',
                    'refresh_by_pull_up',
                    'refresh_by_last_tip')
group by dt,
         udid