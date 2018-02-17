SELECT eventparams['vid'] AS vid,
       eventparams['tag_name'] AS tag,
       eventparams['video_sex_tag'] AS sex,
       sum(CASE
               WHEN eventparams['is_rec_show']='Y' THEN 1
               ELSE 0
           END) AS showtimes,
       sum(CASE
               WHEN eventparams['is_rec_play']='Y' THEN 1
               ELSE 0
           END) AS click,
       sum(CASE
               WHEN eventid='play' THEN cast(nvl(eventparams['playDuration'],0)AS bigint)
               ELSE 0
           END) AS vvtimes,
       sum(CASE
               WHEN eventid='play' THEN cast(nvl(eventparams['duration'],0)AS bigint)
               ELSE 0
           END) AS alltimes
FROM dwmf_bobo.dwm_bobo_sdk_all_new
WHERE dt >= '20171001'
    AND dt <= '20171031'
    AND eventid IN ('event_clientshow',
                    'play')
GROUP BY eventparams['vid'],
         eventparams['tag_name'],
         eventparams['video_sex_tag']
ORDER BY showtimes DESC
LIMIT 20000