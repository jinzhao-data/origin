SELECT dt,
       PARAMETERS['from'] AS download_show,
                 count(1) AS pv,
                 count(DISTINCT PARAMETERS['uid']) AS uv
FROM matrix_log.dws_bobo_h5_log
WHERE dt >= '20180126'
    AND dt <= '20180131'
    AND eventid = 'download_show'
    AND PARAMETERS['from'] IN ('0',
                               '1',
                               '2')
GROUP BY dt,
         PARAMETERS['from']