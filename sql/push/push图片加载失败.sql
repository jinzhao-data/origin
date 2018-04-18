SELECT dt,
       vname,
       count(CASE
                 WHEN eventid = 'push_load_img_err' THEN 1
                 ELSE NULL
             END) AS push_load_img_err,
       count(DISTINCT CASE
                          WHEN eventid = 'push_load_img_err' THEN udid
                          ELSE NULL
                      END) AS pushudids,
       count(DISTINCT CASE
                          WHEN eventid = 'app_start' THEN udid
                          ELSE NULL
                      END) AS udids
FROM dwd_logs.dwd_bobo_fast
WHERE dt >='20180103'
    AND dt <='20180110'
    AND eventid IN ('push_load_img_err',
                    'app_start')
GROUP BY dt,
         vname
ORDER BY dt DESC