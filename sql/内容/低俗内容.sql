SELECT a.dt,
       sum(CASE
               WHEN a.is_rec_show='Y' THEN 1
               ELSE 0
           END) AS showtimes,
       count(case
                 when eventid='play' then 1
                 else null
             end) as vv,
       sum(CASE
               WHEN a.eventid='play' THEN cast(coalesce(a.playduration,'0')AS bigint)
               ELSE 0
           END) AS playtimes,
       sum(CASE
               WHEN a.eventid='play' THEN cast(coalesce(a.duration,'0')AS bigint)
               ELSE 0
           END) AS videotimes
FROM
    (SELECT dt,
            parameters['vid']as vid,
                      parameters['is_rec_show'] as is_rec_show,
                                eventid,
                                parameters['playduration'] as playduration,
                                          parameters['duration']as duration
     FROM dws_bobo_logs.dws_bobo_sdk_all
     where dt>='20180406'
         and dt < ='20180420'
         and eventid in ('play',
                         'event_clientshow')) a
JOIN dim_mp.dim_mp_rec_video d ON cast(a.vid as bigint)=d.video_id
and (d.rmdlable like '%,1'
     or d.rmdlable like '1,%'
     or d.rmdlable ='1'
     or d.rmdlable like '%,1,%')
group by a.dt