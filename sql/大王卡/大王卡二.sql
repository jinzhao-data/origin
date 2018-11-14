select dt,
       PARAMETERS['status'] as status count(distinct udid),
                                      count(1)
from matrix_log.dwv_bobo_sdk
where dt >= '20180507'
    and dt <= '20180507'
    and eventid = 'event_free_king_card_user_status'
group by dt,
         PARAMETERS['status']