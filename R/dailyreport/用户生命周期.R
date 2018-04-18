---
title: "用户生命周期分布-波波"
output:
  html_document: default
  pdf_document: default
---

```{r setup, include=FALSE}
library(DBI)
library(tidyverse)
library(RPresto)
library(plotly)
con <- dbConnect(RPresto::Presto(), host = "47.93.29.9", port = 8080, user = "yanagishima",
                 schema = "default", catalog = "hive", source = "yanagishima")
dt <- dbGetQuery(con,"select t1.udid,date_diff('day',parse_datetime(min(t1.dt),'yyyyMMdd'),parse_datetime(max(t1.dt),'yyyyMMdd')) as diff
FROM
                 (select dt,udid from dws_bobo_logs.dws_bobo_sdk_all where dt >= '20180201' and
                 dt <= '20180301' and eventid = 'app_start' group by dt,udid) t1
                 JOIN
                 (select udid from dwd_logs.dwd_bobo_new_user where dt = '20180201') t2
                 on t1.udid = t2.udid
                 group by t1.udid")
p <- ggplot(dt,aes(x = diff)) + geom_histogram(binwidth = 1)
```

```{r warning= FALSE,message= FALSE}
ggplotly(p)
```

#### **1. 用户流失分布**
定义：
生命周期 = 用户最后一次登录日期 - 用户首次启动app日期

如上用户生命周期分布图，横轴为用户的死亡周期，纵轴为用户个数，整个分布呈现为中间低，两侧低的形状，
其中最左端约为新客当日死亡的数量，最右端为新用户在30后的存留的数量。

* 新客当日死亡的用户数为首日非留存用户，流失占比为43%，当日次日留存为32%；
* 用户30日死亡的用户占新用户整体的10%，约等于30日留存；
以上，可以说明用户43%的用户首次登陆日流失，15%的用户在一个月内逐渐流失，数量随生命周期递减，10%用户为忠诚用户。

备注：

* 计算周期为一个月

```{r include=FALSE,warning= FALSE,message= FALSE}
library(DBI)
library(tidyverse)
library(RPresto)
library(plotly)
con <- dbConnect(RPresto::Presto(), host = "47.93.29.9", port = 8080, user = "yanagishima",
                 schema = "default", catalog = "hive", source = "yanagishima")
dt <- dbGetQuery(con,"select t1.dt,count(t2.udid) as first,count(t1.udid) as to60
from
(select dt,udid from dwd_logs.dwd_bobo_new_user where dt >= '20180120' and dt <= '20180127') t1
left JOIN
(select date_format(date_add('day',-60,parse_datetime(dt,'yyyyMMdd')),'%Y%m%d') as dt,udid from dws_bobo_logs.dws_bobo_sdk_all where dt >= '20180321' and dt <= '20180329'
and eventid = 'app_start' group by date_format(date_add('day',-60,parse_datetime(dt,'yyyyMMdd')),'%Y%m%d'),udid) t2
on t1.udid = t2.udid and t1.dt = t2.dt
group by t1.dt")
```


```{r warning= FALSE,message= FALSE}
p2 <- dt %>% mutate( ratio = first/to60)
ggplot(p2,aes(x = dt, y = ratio)) + geom_point() + ylim(c(0,0.2))
```

**可见用户60日留存保持在9%~10%**

#### **2. 忠实用户**
综上，用户的30日留存于60日留存为10%，说明用户在30日到60日用户留存基本不变，此类用户为忠实用户，暂且认为这部分用户
的生命周为无穷，不在生命周期考虑范围内。

#### **3. 有限生命留存**

生命周期= 用户生命周期*个数/用户总数
        = 6.34天
### 综述，由以上分析过程可见，忠实用户占新用户的10%，非忠实用户占总用户的90%，用户的生命周期在6.34天，其中
次天流失的用户占比较大，占总用户的43%，随时间流失用户逐渐减少，
所以，新用户次日为用户增长的关键日期，对新用户越早采取措施效果越明显。
