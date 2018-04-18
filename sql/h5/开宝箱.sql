SELECT dt,
       count(distinct parameters['uid'])
FROM hive.matrix_log.dws_bobo_h5_log
WHERE dt>='20180308'
    and dt<='20180311'
    and eventid = 'red_in_h5_click'
    and parameters['btnFrom'] = '5'
group by dt