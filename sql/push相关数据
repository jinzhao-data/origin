select t2.taskId,date_format((from_unixtime(t2.taskTime)),'%Y%m%d%H%i') as taskTime,
    (case when t2.isPersonal='false' then '强推' else '个性化' end) as isPersonal,
    sum(t1.udids) as udids,
    sum(t1.push_arrive) as push_arrive,
    sum(t1.push_arrive_udids) as push_arrive_udids,
    sum(t1.push_show_notify) as push_show_notify,
    sum(t1.push_show_notify_udids) as push_show_notify_udids,
    sum(t1.push_click_notify) as push_click_notify,
    sum(t1.push_click_notify_udids) as push_click_notify_udids
from
  (select 
  parameters['msgid'] as msgid,
  count(distinct t.udid) udids,
  sum(if(t.eventid='push_arrive',1,0)) push_arrive,
  count(distinct if(t.eventid='push_arrive',t.udid,null)) push_arrive_udids,
  sum(if(t.eventid='push_show_notify',1,0)) push_show_notify,
  count(distinct if(t.eventid='push_show_notify',t.udid,null)) push_show_notify_udids,
  sum(if(t.eventid='push_click_notify',1,0)) push_click_notify,
  count(distinct if(t.eventid='push_click_notify',t.udid,null)) push_click_notify_udids
  from dwd_logs.dwd_bobo_fast t 
  where t.dt>='20171219'
  and t.eventid in('push_arrive','push_show_notify','push_click_notify')
  and date_format((from_unixtime(cast(substr(time,1,10) as bigint))),'%Y%m%d') = '20171219'
  group by parameters['msgid']) t1
join
  (select cast(json_extract(parameters,'$.msgId') as varchar) as msgid,
      cast(json_extract(parameters,'$.isPersonal') as varchar) as isPersonal,
      cast(json_extract(parameters,'$.taskId') as varchar) as taskId,
      cast(json_extract(parameters,'$.taskTime') as bigint) as taskTime
   from dws_bobo_logs.dws_bobo_push_msgid where dt='20171219') t2
on (t1.msgid=t2.msgid)
group by t2.taskId,date_format((from_unixtime(t2.taskTime)),'%Y%m%d%H%i'),
     (case when t2.isPersonal='false' then '强推' else '个性化' end)
order by t2.taskId,date_format((from_unixtime(t2.taskTime)),'%Y%m%d%H%i')
