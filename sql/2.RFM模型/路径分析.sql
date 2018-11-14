SELECT SOURCE,
       target,
       count(1) AS value
FROM
    (SELECT t.udid,
            (CASE
                 WHEN t.rank = 1 THEN eventid
                 ELSE 'lost'
             END) AS SOURCE,
            (CASE
                 WHEN t.rank = 2 THEN eventid
                 ELSE 'lost'
             END) AS target
     FROM
         (SELECT t1.udid,
                 t1.eventid,
                 Row_Number() OVER (PARTITION BY t1.udid
                                    ORDER BY t1.time) AS rank
          FROM
              (SELECT udid,
                      TIME,
                      eventid
               FROM hive.dwd_bobo."dwd_bobo_fast"
               WHERE dt = '20180701'
                   AND eventid IN ('app_start',
                                   'refresh_auto',
                                   'event_clientshow',
                                   'play',
                                   'main_tab_click',
                                   'exit',
                                   'search_click_btn')) t1
          JOIN
              (SELECT udid
               FROM hive.dwd_bobo."dwd_bobo_new_user"
               WHERE dt = '20180701') t2 ON t1.udid = t2.udid) t
     WHERE t.rank <= 2) t12
GROUP BY 1,
         2