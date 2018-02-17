select t1.*,t2.rihuo
from
(select dt,
    eventparams['new_device_tag'] as newdevicetag,
    eventparams['source'] as source,eventparams['channelId'] as channleid,
    abid,
    count(distinct case when eventid='play' then udid else null end) as vvpeople,
    count(case when eventid='play' then 1 else null end)as vv,
    sum(case when eventid='play' then cast(nvl(eventparams['playDuration'],0)as bigint) else 0 end) as vvtimes,
    sum(case when eventid='play' then cast(nvl(eventparams['duration'],0)as bigint) else 0 end) as alltimes
from dwmf_bobo.dwm_bobo_sdk_all_new
where dt between '20171206' and '20171212'
    and is_first_test=true and abid in ('191-125','192-125','193-125','194-125')
group by dt,
    eventparams['new_device_tag'],
    eventparams['source'],
    eventparams['channelId'],
    abid) t1
Left join
(Select dt,
    eventparams['new_device_tag'] as newdevicetag,
    count(distinct udid ) as rihuo
from  dwmf_bobo.dwm_bobo_sdk_all_new
where dt between '20171206' and '20171212' and is_first_test=true
group by dt,
    eventparams['new_device_tag']) t2
on t1.dt = t2.dt and t1.newdevicetag = t2.newdevicetag
