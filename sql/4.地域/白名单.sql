--黑白名单留存
select t1.white_black,t1.utype,count(t1.udid) as dau,count(t2.udid) as retain
from
(select (case when (parameters['city'] in
    ('珠海','北京','上海','广州','深圳','杭州','成都','都江堰','广汉','德阳','海外','香港','澳门','台湾'))
    then 'white' else 'other' end) as white_black,parameters['new_device_tag'] as utype,
    udid
from matrix_dim.dim_bobo_sdk_all where dt = '20180512' and eventid = 'app_start'
group by 1,2,3) t1
left join
(select distinctudid
from matrix_dim.dim_bobo_sdk_all where dt = '20180513' and eventid = 'app_start') t2
on t1.udid = t2.udid
group by t1.white_black,t1.utype

--黑白名单使用时长，曝光，点击，ctr，播放时长，视频时长，播放完成度
select (case when (parameters['city'] in 
    ('珠海','北京','上海','广州','深圳','杭州','成都','都江堰','广汉','德阳','海外','香港','澳门','台湾'))
    then 'white' else 'other' end) as white_black,parameters['new_device_tag'] as utype,
    sum(case
            when eventid = 'exit' then cast(nvl(parameters['exittime'],'0') as bigint)
            else 0
        end)/60000 as usemins,
        sum(CASE
        WHEN PARAMETERS['is_rec_show']='Y' THEN 1
        ELSE 0
        END) AS showtimes,
        sum(CASE
        WHEN PARAMETERS['is_rec_play']='Y' THEN 1
        ELSE 0
        END) AS click,
        count(CASE
        WHEN eventid='play' THEN 1
        ELSE NULL
        END)AS vv,
        sum(CASE
        WHEN eventid='play' THEN cast(nvl(PARAMETERS['playduration'],'0')AS bigint)
        ELSE 0
        END) AS vvtimes,
        sum(CASE
        WHEN eventid='play' THEN cast(nvl(PARAMETERS['duration'],'0')AS bigint)
        ELSE 0
        END) AS alltimes
from matrix_dim.dim_bobo_sdk_all where dt = '20180512' and eventid in ('exit','play','event_clientshow')
group by (case when (parameters['city'] in
    ('珠海','北京','上海','广州','深圳','杭州','成都','都江堰','广汉','德阳','海外','香港','澳门','台湾'))
    then 'white' else 'other' end),parameters['new_device_tag']













city in
('珠海','北京','上海','广州','深圳','杭州','成都','都江堰','广汉','德阳','海外','香港','澳门','台湾')
