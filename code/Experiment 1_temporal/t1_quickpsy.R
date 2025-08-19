rm(list=ls()) 
library(quickpsy)

data <- read.csv("data\\temporal.csv",header = TRUE)
names(data) <-c("subject", "Distance", "RESP", "RT")
fit <- quickpsy(data, Distance, RESP, fun = cum_normal_fun, guess = FALSE, bootstrap = "none",prob = .5) 
plot(fit)

write.csv(fit$par,file = "data\\t.PSE.csv",quote = F)





