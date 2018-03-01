select  dt,(case when split(ip_info,'|')[5] in ('北京市','上海市','广州市','深圳市','成都市','杭州市','广汉市','德阳市','都江堰') then '北上广'
else 'other' end) as citytype,count(distinct udid) as dau
from dwd_logs.dwd_mpjs_log
where  dt >='20180221' and dt <= '20180222' and  (abid like '%450%'
       or abid like '%451%') and
eventid = 'app_start'
group by dt,(case when split(ip_info,'|')[5] in ('北京市','上海市','广州市','深圳市','成都市','杭州市','广汉市','德阳市','都江堰') then '北上广'
else 'other' end)
