SELECT t2.tag_id,
       t1.vid,
       t1.showtimes
FROM
    ( SELECT PARAMETERS ['videoId'] AS vid,
                        count( CASE
                                   WHEN eventid = 'event_clientshow' THEN '1'
                                   ELSE NULL
                               END ) AS showtimes
     FROM matrix_log.dwv_bobo_sdk
     WHERE dt = '20180201'
         AND eventid = 'event_clientshow'
     GROUP BY PARAMETERS ['videoId'] ) t1
JOIN
    ( SELECT video_id,
             tag_id,
             expire_time,
             shoot_type
     FROM dim_mp.dim_mp_rec_video
     WHERE shoot_type = 2
         AND ( tag_id IN (0,
                          325)
              OR expire_time = 0 ) ) t2 ON t1.vid = cast(t2.video_id AS string)
ORDER BY t1.showtimes DESC
LIMIT 20000