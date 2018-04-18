select parameters['vid'] as vid,
                 parameters['shoottype'] as vidcome,
                           parameters['tag_nanme'] as tag,
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
                                             WHEN eventid='play' THEN cast(coalesce(PARAMETERS['playduration'],'0')AS bigint)
                                             ELSE 0
                                         END) AS vvtimes,
                                     sum(CASE
                                             WHEN eventid='play' THEN cast(coalesce(PARAMETERS['duration'],'0')AS bigint)
                                             ELSE 0
                                         END) AS alltimes
from dws_bobo_logs.dws_bobo_sdk_all
where dt = '20180319'
    and eventid in ('play',
                    'event_clientshow')
group by 1,
         2,
         3
order by showtimes DESC
limit 1000