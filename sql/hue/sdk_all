SELECT dt,
       eventparams['owner'] AS OWNER,
       eventparams['nick'] AS nick,
       eventparams['video_sex_tag'] AS sex,
       eventparams['tag_id'] AS tagid,
       eventparams['vid'] AS vid,
       eventparams['video_title'] AS title,
       eventparams['video_timeliness_tag'] AS timetag,
       eventparams['tag_name'] AS tagname,
       sum(CASE
               WHEN eventparams['is_rec_show']='Y' THEN 1
               ELSE 0
           END) AS showtimes,
       sum(CASE
               WHEN eventparams['is_rec_play']='Y' THEN 1
               ELSE 0
           END) AS click,
       count(CASE
                 WHEN eventid='play' THEN 1
                 ELSE NULL
             END)AS vv,
       sum(CASE
               WHEN eventid='play' THEN cast(nvl(eventparams['playDuration'],0)AS bigint)
               ELSE 0
           END) AS vvtimes,
       sum(CASE
               WHEN eventid='play' THEN cast(nvl(eventparams['duration'],0)AS bigint)
               ELSE 0
           END) AS alltimes
FROM dwmf_mp.dwm_mp_sdk_all
WHERE dt='20171015'
    AND is_first_test=TRUE
GROUP BY dt,
         eventparams['owner'],
         eventparams['nick'],
         eventparams['video_sex_tag'],
         eventparams['tag_id'],
         eventparams['vid'],
         eventparams['video_title'],
         eventparams['video_timeliness_tag'],
         eventparams['tag_name']