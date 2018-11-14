select
FROM dws_bobo_logs.dws_bobo_sdk_all
where dt>='20180406'
    and dt < ='20180420'
    and eventid in ('event_clientshow')