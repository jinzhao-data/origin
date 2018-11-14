library(tidyverse)
dt <- read.csv("/Users/jinzhao/Desktop/t.csv", header = FALSE, sep = "")
for (n in 1:5) {
    slice(dt, ((126701%/%5) * (n - 1)):((126701%/%5) * n)) %>% write.csv(str_c("/Users/jinzhao/Desktop/t", 
        n, ".csv"), fileEncoding = "GBK")
}
