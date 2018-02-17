SELECT t1.tag_id,
       count(t1.video_id),
       avg(t1.duration)
FROM
  (SELECT tag_id,
          video_id,
          content_id,
          user_id,
          duration
   FROM recommend.video_info
   WHERE rmdstatus=1 #可推荐
     AND del_status>=0 #非删除
     AND (expire_time>= UNIX_TIMESTAMP(20171215)   #有效期为大于当前日期或者=0
          OR expire_time=0)
     AND public_status=2 #公开状态为可用
     AND length(title)>=8) t1 #标题长度大于等于8
JOIN
  (SELECT user_id
   FROM recommend.user_info
   WHERE user_status>=0 and user_lvl >= 4) t2 ON (t1.user_id = t2.user_id) #用户状态可用，用户等级4级以上
JOIN
  (SELECT video_id
   FROM recommend.content_info
   WHERE status!=0 ) t3 ON (t1.video_id=t3.video_id) #视频类型状态为非0
GROUP BY t1.tag_id;
