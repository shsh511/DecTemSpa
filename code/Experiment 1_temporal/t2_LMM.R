rm(list=ls()) 

library(lme4) 
library(lmerTest)
dataT <- read.csv("data\\T.LMM.csv")
names(dataT) <-c("PARTICIPANT","tTDEA","tDDT","RT","P3")

modT.RT.tDDT <- lmer(RT ~ tDDT + (0 + tDDT |PARTICIPANT) + (1|PARTICIPANT), data=dataT, REML=T)
summary(modT.RT.tDDT)
anova(modT.RT.tDDT)
aic_value <- AIC(modT.RT.tDDT)
print(aic_value)
predictions.RT.tDDT <- predict(modT.RT.tDDT, newdata = dataT) 
write.csv(predictions.RT.tDDT, "data\\T.RT.tDDT.predict.csv", row.names = FALSE)


modT.RT.tTDEA <- lmer(RT ~ tTDEA + (0 + tTDEA |PARTICIPANT) + (1|PARTICIPANT), data=dataT, REML=T)
summary(modT.RT.tTDEA)
anova(modT.RT.tTDEA)
aic_value <- AIC(modT.RT.tTDEA)
print(aic_value)
predictions.RT.tTDEA <- predict(modT.RT.tTDEA, newdata = dataT) 
write.csv(predictions.RT.tTDEA, "data\\T.RT.tTDEA.predict.csv", row.names = FALSE)


modT.P3.tDDT <- lmer(P3 ~ tDDT + (0 + tDDT |PARTICIPANT) + (1|PARTICIPANT), data=dataT, REML=T)
summary(modT.P3.tDDT)
anova(modT.P3.tDDT)
aic_value <- AIC(modT.P3.tDDT)
print(aic_value)
predictions.P3.tDDT <- predict(modT.P3.tDDT, newdata = dataT) 
write.csv(predictions.P3.tDDT, "data\\T.P3.tDDT.predict.csv", row.names = FALSE)


modT.P3.tTDEA <- lmer(P3 ~ tTDEA + (0 + tTDEA |PARTICIPANT) + (1|PARTICIPANT), data=dataT, REML=T)
summary(modT.P3.tTDEA)
anova(modT.P3.tTDEA)
aic_value <- AIC(modT.P3.tTDEA)
print(aic_value)
predictions.P3.tTDEA <- predict(modT.P3.tTDEA, newdata = dataT) 
write.csv(predictions.P3.tTDEA, "data\\T.P3.tTDEA.predict.csv", row.names = FALSE)
