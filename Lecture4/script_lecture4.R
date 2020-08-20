
#Set repo
local({r <- getOption("repos"); r["CRAN"] <- "http://cran.r-project.org"; options(repos=r)}) #set repo

#Load packages, remember install dependencies
library("dplyr")
library("McSpatial")

#Help matchdata
data(matchdata)

#set seed
set.seed(10101)
?set.seed

#70% train
?sample
indic<-sample(1:nrow(matchdata),floor(.7*nrow(matchdata)))

#Partition the sample
train<-matchdata[indic,]
test<-matchdata[-indic,]


#Regrsion on the train sample
reg1<-lm(lnprice~bathrooms,data=train)
summary(reg1)
# require("stargazer")
# stargazer(reg1,type="text")

#Prediction on the test sample
yhat<-predict(reg1,test)
test$yhat<-predict(reg1,test)

#Calculation of the prediction error
test<- test %>% mutate(err=(lnprice-yhat)^2)
sqrt(mean(test$err))

#Same for model 2
reg2<-lm(lnprice~bathrooms+rooms+fireplace,data=train)
test$yhat_2<-predict(reg2,test)

test<- test %>% mutate(err2=(lnprice-yhat_2)^2)
sqrt(mean(test$err))
sqrt(mean(test$err2))
