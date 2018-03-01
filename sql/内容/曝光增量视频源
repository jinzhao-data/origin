select (case
            when t2.vid is not null then 'oldvideo'
            else 'addvideo'
        end) as tpye,
       count(distinct t1.vid) as vidcount,
       sum(t1.showtimes - cast(coalesce(t2.showtimes,0) as bigint)) as addshowcome
from
    (select parameters['vid'] as vid,
                      sum(CASE
                              WHEN PARAMETERS['is_rec_show']='Y' THEN 1
                              ELSE 0
                          END) AS showtimes
     from dws_bobo_logs.dws_bobo_sdk_all
     where dt = '20180216'
         and eventid = 'event_clientshow'
     group by parameters['vid']) t1
left join
    (select parameters['vid'] as vid,
                      sum(CASE
                              WHEN PARAMETERS['is_rec_show']='Y' THEN 1
                              ELSE 0
                          END) AS showtimes
     from dws_bobo_logs.dws_bobo_sdk_all
     where dt = '20180215'
         and eventid = 'event_clientshow'
     group by parameters['vid']) t2 on t1.vid = t2.vid
group by (case
              when t2.vid is not null then 'oldvideo'
              else 'addvideo'
          end)