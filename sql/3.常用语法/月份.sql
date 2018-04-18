month(parse_datetime(dt,'yyyyMMdd')) --hive
from_unixtime(unix_timestamp(dt,'yyyyMMdd'),'yyyy-MM-dd')