#######################################################################
#  Author: Ignacio Sarmiento-Barbieri (i.sarmiento at uniandes.edu.co)
# please do not cite or circulate without permission
#######################################################################

#Clean the workspace
rm(list=ls())
cat("\014")

require("ggplot2")
require("haven")

# set.seed(101010)
# N<-2000
# x<- runif(N,0,10)
# u<-rchisq(N,25)
# f<-10+0.8*x-0.07*x^2-.01*x^3
# 
# V<-(f*((1-0.8)/0.8))*var(u)
# u<-(u-mean(u))/(sqrt(V))
# 
# 
# y<-f+u
# db<-data.frame(y=x,x=y)

db<-read.csv("motorcicle.csv")
colnames(db)<-c("y","x")
p<-ggplot(db,aes(x=y,y=x)) +
  geom_point(shape=1,alpha=0.5) + 
  theme_bw()  +
  #ylim(8,15) +
  theme(legend.position = "none",
        axis.title =element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()
  )
p
ggsave("fig_1.pdf",height = 7, width = 12)

p1<-p +stat_smooth(method="lm", se=FALSE, fill=NA, colour="blue",size=1,lty=1)
p1
ggsave("fig_1b.pdf",height = 7, width = 12)


p2<-p +  stat_smooth(method="loess", se=FALSE, fill=NA,colour="red",size=1,lty=2)
ggsave("fig_1c.pdf",height = 7, width = 12)

p3<- p+ 
  stat_smooth(method="lm", se=FALSE, fill=NA,colour="blue",size=1,lty=1) +
  stat_smooth(method="loess", se=FALSE, fill=NA,colour="red",size=1,lty=2) 
p3
ggsave("fig_1d.pdf",height = 7, width = 12)


