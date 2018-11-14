--presto
date_format(date_add('day',-1,parse_datetime(dt,'yyyyMMdd')),'%Y%m%d') --hive
unix_timestamp(dt,'yyyyMMdd') date_add(from_unixtime(unix_timestamp(dt,'yyyyMMdd'),'yyyy-MM-dd'),-1)