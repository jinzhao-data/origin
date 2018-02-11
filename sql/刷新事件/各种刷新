select dt,eventid
    count(1) as "刷新次数",
    count(distinct udid) as "刷新人数"
from dwd_logs.dwd_bobo_fast
where dt >= date_format(date_add('day',-8,current_date),'%Y%m%d') and dt <= date_format(date_add('day',-1,current_date),'%Y%m%d')
and eventid in ('refresh_auto','refresh_by_pull_down','refresh_by_home_top_tab',
'refresh_by_svideo_bottom_tab','refresh_by_home_bottom_tab','refresh_by_pull_up','refresh_by_last_tip')
group by dt,eventid
order by dt desc

####刷新不上报source，只上报channelid
select *
from dwd_logs.dwd_bobo_fast
where dt = '20180101'
and eventid in ('refresh_auto','refresh_by_pull_down','refresh_by_home_top_tab',
'refresh_by_svideo_bottom_tab','refresh_by_home_bottom_tab','refresh_by_pull_up','refresh_by_last_tip') limit 100



####新老用户刷新
SELECT t1.dt,
       (CASE
            WHEN t2.udid IS NULL THEN 'old'
            ELSE 'new'
        END) AS usertpye,
       t1.eventid,
       count(t1.refreshtime) AS times,
       count(DISTINCT t1.udid) AS countudid
FROM
    (SELECT dt,
            udid,
            eventid,
            count(1) AS refreshtime
     FROM dwd_logs.dwd_bobo_fast
     WHERE dt >= date_format(date_add('day',-3,CURRENT_DATE),'%Y%m%d')
         AND dt <= date_format(date_add('day',-1,CURRENT_DATE),'%Y%m%d')
         AND eventid IN ('refresh_auto',
                         'refresh_by_pull_down',
                         'refresh_by_home_top_tab',
                         'refresh_by_svideo_bottom_tab',
                         'refresh_by_home_bottom_tab',
                         'refresh_by_pull_up',
                         'refresh_by_last_tip')
     GROUP BY dt,
              udid,
              eventid) t1
LEFT JOIN
    (SELECT dt,
            udid
     FROM dwd_logs.dwd_bobo_new_user
     WHERE dt >= date_format(date_add('day',-3,CURRENT_DATE),'%Y%m%d')
         AND dt <= date_format(date_add('day',-1,CURRENT_DATE),'%Y%m%d')) t2 ON t1.udid = t2.udid
AND t1.dt =t2.dt
GROUP BY t1.dt,(CASE
                    WHEN t2.udid IS NULL THEN 'old'
                    ELSE 'new'
                END),t1.eventid
