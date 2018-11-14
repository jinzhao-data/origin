library(readr)
setwd("") #设置读取路径
file_list <- list.files() #路径下的所有文件list
file_list #查看所有文件
num_file <- length(file_list) #文件个数
num_file #查看文件数量
dat <- data.frame() #创建空dt
for (i in 1:num_file) {
  new_data <-  read_csv(file = file_list[i])
  dat <-  rbind(dat, new_data)
} #循环每次都将读取的文件到空dt中
t <- write.csv(ttl, "D:/ka/merger.csv") #到处合并后的csv文件
