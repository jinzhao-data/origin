-- city
select
  dt,
  parameters['city'] as cty,
  count(distinct udid) as dau
from
  matrix_log.dwv_bobo_sdk
where
  dt >= '20180408'
  and dt <= '20180412'
  and eventid = 'app_start'
  and parameters['city'] in (
    '成都',
    '杭州',
    '武汉',
    '重庆',
    '南京',
    '天津',
    '苏州',
    '西安',
    '长沙',
    '沈阳',
    '青岛',
    '郑州',
    '大连',
    '东莞',
    '宁波',
    '厦门',
    '福州',
    '无锡',
    '合肥',
    '昆明',
    '哈尔滨',
    '济南',
    '佛山',
    '长春',
    '温州',
    '石家庄',
    '南宁',
    '常州',
    '泉州',
    '南昌',
    '贵阳',
    '太原',
    '烟台',
    '嘉兴',
    '南通',
    '金华',
    '珠海',
    '惠州',
    '徐州',
    '海口',
    '乌鲁木齐',
    '绍兴',
    '中山',
    '台州',
    '兰州',
    '北京',
    '上海',
    '广州',
    '深圳'
  )
group by
  dt,
  parameters['city']
