SELECT dt,
       pcid,
       COUNT(DISTINCT udid) AS pcid_dau
FROM dws_bobo_logs.dws_bobo_sdk_all
WHERE dt IN ('20180117',
             '20180204')
    AND eventid = 'app_start'
    AND PARAMETERS['new_device_tag'] = 'Y'
    AND (pcid IN ('oppo_market',
                  'vivo_market',
                  'xiaomi_market')
         OR pcid LIKE '%wifi%')
GROUP BY dt,
         pcid