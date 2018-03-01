select dt,
       parameters['from'] as fromfrom,
                 count(1) as times,
                 count(DISTINCT uid) as uv
from matrix_log.dws_bobo_h5_log
where dt >= '20180221'
    and dt <= '20180221'
    and eventid = 'download_click'
    and parameters['from'] in ('0',
                               '2')