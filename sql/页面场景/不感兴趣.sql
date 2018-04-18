select dt,
       (case
            when (abid like '%618%') then 'abid618'
            when (abid like '%619%') then 'abid619'
            when (abid like '%38%') then 'abid38'
            else 'abid39'
        end) as abid,
       count(case
                 when eventid = 'video_uninterested_btn_click' then 1
                 else null
             end) as disliketimes,
       count(case
                 when eventid = 'play' then 1
                 else null
             end) as playtimes
from dwd_logs.dwd_bobo_fast
where dt >= '20180403'
    and dt <= '20180403'
    and eventid in ('video_uninterested_btn_click',
                    'play')
    and (abid like '%618%'
         or abid like '%619%'
         or abid like '%38%'
         or abid like '%39%')
group by dt,(case
                 when (abid like '%618%') then 'abid618'
                 when (abid like '%619%') then 'abid619'
                 when (abid like '%38%') then 'abid38'
                 else 'abid39'
             end)