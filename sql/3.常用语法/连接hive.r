library(RJDBC)
library(rJava)
library(DBI)
library(tidyverse)
for (l in list.files("/Users/jinzhao/Documents/lib/")) {
    .jaddClassPath(paste("/Users/jinzhao/Documents/lib/", l, sep = ""))
}
drv <- JDBC("org.apache.hive.jdbc.HiveDriver", "/Users/jinzhao/Documents/lib/hive-jdbc-1.1.0-cdh5.11.2.jar")
for (l in list.files("/Users/jinzhao/Documents/lib/")) {
    .jaddClassPath(paste("/Users/jinzhao/Documents/lib/", l, sep = ""))
}
drv <- JDBC("org.apache.hive.jdbc.HiveDriver", "/Users/jinzhao/Documents/lib/hive-jdbc-1.1.0-cdh5.11.2.jar")
conn <- dbConnect(drv, "jdbc:hive2://10.10.13.107:10000", "hive", "hive", characterEncoding = "UTF-8")
dt_pcid <- dbGetQuery(conn, "")
