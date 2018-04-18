--presto

select cast(coalesce(parameters['playduration'],'0') as bigint) as playduration,
       cast(coalesce(parameters['duration'],'0') as bigint) as duraion,
       round(cast(coalesce(parameters['playduration'],'0') as double)/cast(coalesce(parameters['duration'],'0') as double),4) as p
from dws_bobo_logs.dws_bobo_sdk_all
where dt = '20180409'
    and eventid = 'play'
    and cast(coalesce(parameters['playduration'],'0') as bigint)>0
    and cast(coalesce(parameters['duration'],'0') as bigint)>0
    and cast(coalesce(parameters['duration'],'0') as bigint) < cast(coalesce(parameters['playduration'],'0') as bigint)*10
    and cast(coalesce(parameters['duration'],'0') as bigint)<7200 --hive

    select cast(nvl(parameters['playduration'],0) as bigint) as playduration,
           cast(nvl(parameters['duration'],0) as bigint) as duraion,
           round(cast(nvl(parameters['playduration'],0) as double)/cast(nvl(parameters['duration'],0) as double),4) as p
    from dws_bobo_logs.dws_bobo_sdk_all where dt = '20180409'
    and eventid = 'play'
    and cast(nvl(parameters['playduration'],0) as bigint)>0
    and cast(nvl(parameters['duration'],0) as bigint)>0
    and cast(nvl(parameters['duration'],0) as bigint) < cast(nvl(parameters['playduration'],0) as bigint)*10
    and cast(nvl(parameters['duration'],0) as bigint)<7200
limit 10