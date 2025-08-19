rm(list=ls()) 
library(quickpsy)

data <- read.csv("data\\spatial.csv",header = TRUE)
names(data) <-c("subject", "Length", "RESP", "RT")
fit <- quickpsy(data, Length, RESP, fun = cum_normal_fun, guess = FALSE, bootstrap = "none",prob = .5) 
fit
write.csv(fit$par,file = "data\\s.PSE.csv",quote = F)
