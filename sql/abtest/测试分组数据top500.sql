select t2.*
from
    (select t1.*,
            Row_Number() OVER (PARTITION BY abid
                               ORDER BY t1.showtimes DESC) as show_rank
     from
         (select dt,
                 (case
                      when abid like '%450%' then '450'
                      else '451'
                  end) as abid,
                 PARAMETERS['video_title'] as title,
                           PARAMETERS['rec_video_sex_tag'] AS sex,
                                     PARAMETERS['shoottype'] as videofrom,
                                               PARAMETERS['tag_name'] AS tagname,
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
          where (abid like '%450%'
                 or abid like '%451%')
              and dt = '20180221'
              and eventid in ('event_clientshow',
                              'play')
              and PARAMETERS['shoottype'] in ('2',
                                              '20')
          group by 1,
                   2,
                   3,
                   4,
                   5,
                   6) t1) t2
where t2.show_rank <= 500