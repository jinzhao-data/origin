SELECT t3.tag_name,
       t2.level,
       count(1)
FROM
    (SELECT user_id,
            tag_id
     FROM hive.dim_mp."dim_mp_rec_video"
     WHERE rmdstatus = 1
         AND del_status >= 0
         AND public_status = 2
         AND (format_datetime(from_unixtime(expire_time),'yyyyMMdd') >= '20180821'
              OR expire_time = 0)
         AND rmdlable LIKE '%11%') t1
LEFT JOIN
    (SELECT userid,
            LEVEL
     FROM hive.dim_mp."dim_mp_user_level_old") t2 ON t1.user_id = t2.userid
LEFT JOIN
    (SELECT id,
            tag_name
     FROM hive.dim_mp."dim_mp_rec_video_tag") t3 ON t1.tag_id = t3.id
GROUP BY 1,
         2