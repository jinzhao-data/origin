SELECT dt,
       count(1) AS pv,
       count(DISTINCT PARAMETERS['uid']) AS uv
FROM matrix_log.dws_bobo_h5_log
WHERE dt >= '20180118'
    AND dt <= '20180128'
    AND eventid = 'red_in_h5_show'
    AND PARAMETERS['from'] = '5'
GROUP BY dt