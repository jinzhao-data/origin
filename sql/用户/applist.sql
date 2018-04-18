select
from
CROSS JOIN UNNEST(split(queue,' ')) AS t (queue_name)