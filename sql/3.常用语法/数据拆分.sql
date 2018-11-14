SELECT video_id,
       tp
from dim_mp.dim_mp_rec_video
CROSS JOIN UNNEST(split(rmdlable,',')) as t (tp)
where trim(tp) = '11'
limit 10