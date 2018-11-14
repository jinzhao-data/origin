select format_datetime(from_unixtime(cast (parameters['createtime'] as bigint)),'yyyyMMdd') as updt,
       parameters['vid'] as vid,
                 parameters['video_title'] as title,
                           parameters['tag_name'] as cate,
                                     sum(case
                                             when parameters['is_rec_show']='Y' then 1
                                             else 0
                                         end) as showtimes,
                                     sum(case
                                             when parameters['is_rec_play']='Y' then 1
                                             else 0
                                         end) as click,
                                     sum(case
                                             when eventid='play' then cast(COALESCE(parameters['playduration'],'0')as bigint)
                                             else 0
                                         end) as vvtimes,
                                     sum(case
                                             when eventid='play' then cast(COALESCE(parameters['duration'],'0')as bigint)
                                             else 0
                                         end) as alltimes,
                                     round(cast(sum(case
                                                        when parameters['is_rec_play']='Y' then 1
                                                        else 0
                                                    end) as double)/ cast(sum(case
                                                                                  when parameters['is_rec_show']='Y' then 1
                                                                                  else 0
                                                                              end) as double),2) as ctr,
                                     round(cast(sum(case
                                                        when eventid='play' then cast(COALESCE(parameters['playduration'],'0')as bigint)
                                                        else 0
                                                    end) as double)/cast(sum(case
                                                                                 when eventid='play' then cast(COALESCE(parameters['duration'],'0')as bigint)
                                                                                 else 0
                                                                             end) as double),2) as p
from dws_bobo_logs.dws_bobo_sdk_all
where dt >='20180429'
    and dt <= '20180430'
    and eventid in ('play',
                    'event_clientshow')
    and format_datetime(from_unixtime(cast (parameters['createtime'] as bigint)),'yyyyMMdd') = '20180429'
group by format_datetime(from_unixtime(cast (parameters['createtime'] as bigint)),'yyyyMMdd'),
         parameters['vid'],parameters['video_title'],parameters['tag_name']
order by showtimes desc
limit 1000