select dt,abid,eventparams['sysOpen'],eventparams['setOpen'],count(distinct udid)
FROM dwv_mp.dwv_mp_lite_sdk
where dt >= '20171207' and dt <= '20180104' and eventid='push_arrive'
and abid in ('133-118','134-118','135-118','136-118')
group by dt,abid,eventparams['sysOpen'],eventparams['setOpen']
