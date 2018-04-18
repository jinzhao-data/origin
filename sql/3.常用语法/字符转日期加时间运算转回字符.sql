date_format(date_add('day',-1,parse_datetime(dt,'yyyyMMdd')),'%Y%m%d')

####hive
from_unixtime(unix_timestamp('2016/06/01','yyyy/MM/dd'),'yyyy-MM-dd')
month(from_unixtime(unix_timestamp(dt,'yyyyMMdd'),'yyyy-MM-dd'))
