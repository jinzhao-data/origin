library(tidyverse)
library(RPresto)
library(DBI)
con <- dbConnect(RPresto::Presto(), host = "47.93.29.9", port = 8080, user = "yanagishima",
    schema = "default", catalog = "hive", source = "yanagishima")
res <- dbGetQuery(con,
