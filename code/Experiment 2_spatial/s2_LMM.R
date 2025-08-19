rm(list=ls()) 

library(lme4) 
library(lmerTest)
dataS <- read.csv("data\\S.LMM.csv")
names(dataS) <-c("PARTICIPANT","sTDEA","sDDT","RT","P3")

modS.RT.sDDT <- lmer(RT ~ sDDT + (0 + sDDT |PARTICIPANT) + (1|PARTICIPANT), data=dataS, REML=T)
summary(modS.RT.sDDT)
anova(modS.RT.sDDT)
aic_value <- AIC(modS.RT.sDDT)
print(aic_value)
predictions.RT.sDDT <- predict(modS.RT.sDDT, newdata = dataS) 
write.csv(predictions.RT.sDDT, "data\\S.RT.sDDT.predict.csv", row.names = FALSE)

modS.RT.sTDEA <- lmer(RT ~ sTDEA + (0 + sTDEA |PARTICIPANT) + (1|PARTICIPANT), data=dataS, REML=T)
summary(modS.RT.sTDEA)
anova(modS.RT.sTDEA)
aic_value <- AIC(modS.RT.sTDEA)
print(aic_value)
predictions.RT.sTDEA <- predict(modS.RT.sTDEA, newdata = dataS) 
write.csv(predictions.RT.sTDEA, "data\\S.RT.sTDEA.predict.csv", row.names = FALSE)


modS.P3.sDDT <- lmer(P3 ~ sDDT + (0 + sDDT |PARTICIPANT) + (1|PARTICIPANT), data=dataS, REML=T)
summary(modS.P3.sDDT)
anova(modS.P3.sDDT)
aic_value <- AIC(modS.P3.sDDT)
print(aic_value)
predictions.P3.sDDT <- predict(modS.P3.sDDT, newdata = dataS) 
write.csv(predictions.P3.sDDT, "data\\S.P3.sDDT.predict.csv", row.names = FALSE)


modS.P3.sTDEA <- lmer(P3 ~ sTDEA + (0 + sTDEA |PARTICIPANT) + (1|PARTICIPANT), data=dataS, REML=T)
summary(modS.P3.sTDEA)
anova(modS.P3.sTDEA)
aic_value <- AIC(modS.P3.sTDEA)
print(aic_value)
predictions.P3.sTDEA <- predict(modS.P3.sTDEA, newdata = dataS) 
write.csv(predictions.P3.sTDEA, "data\\S.P3.sTDEA.predict.csv", row.names = FALSE)

