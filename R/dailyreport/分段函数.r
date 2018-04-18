df <- df %>% mutate(
  F = cut(
    数量,   #计算字段
    breaks = c(0, 5, 10, 20, 40, Inf),  #按该区间分类
    include.lowest = T,  #包括最低值，零
    labels = 1:5 #类别的标签，这里是得分
  )
)
