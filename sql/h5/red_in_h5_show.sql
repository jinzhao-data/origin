SELECT dt,PARAMETERS['from'] as from_red
       count(1) AS pv,
       count(DISTINCT PARAMETERS['uid']) AS uv
FROM matrix_log.dws_bobo_h5_log
WHERE dt >= '20180118'
    AND dt <= '20180128'
    AND eventid = 'red_in_h5_show'
    AND PARAMETERS['from'] in ('0','1','2')
GROUP BY dt，PARAMETERS['from']


##排重量
SELECT dt,eventid
       count(DISTINCT PARAMETERS['uid']) AS uv
FROM matrix_log.dws_bobo_h5_log
WHERE dt >= '20180118'
    AND dt <= '20180128'
    AND eventid in ('red_in_h5_show','download_show')
GROUP BY dt,eventid
