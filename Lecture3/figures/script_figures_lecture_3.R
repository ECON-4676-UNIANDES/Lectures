#######################################################################
#  Author: Ignacio Sarmiento-Barbieri (i.sarmiento at uniandes.edu.co)
# please do not cite or circulate without permission
#######################################################################

rm(list=ls())
cat("\014")

require("ggplot2")
set.seed(10101)

N<-20
x = runif(N,2,10)
u<- rchisq(N,25)
f<- 2 + 5*x
y = f +u 

db<-data.frame(x=x,y=y)

p<-ggplot(db,aes(x=x,y=y)) +
  geom_point(shape=1,alpha=1,size=2) + 
  theme_bw()  +
  #ylim(8,15) +
  theme(legend.position = "none",
        #axis.title =element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()
  )

p
ggsave("fig_1.pdf",height = 7, width = 12)

p + 
  geom_smooth(method = lm, se = FALSE, col = "black",size=.5) +
  geom_segment(aes(y = predict(lm(y ~ x)), yend = y, x = x, xend = x), col = "red")
ggsave("fig_1b.pdf",height = 7, width = 12)



require("McSpatial")
require("sf")
data(matchdata)
cmap <- read_sf(system.file("maps/CookCensusTracts.shp",package="McSpatial"))
cmap <- cmap[cmap$CHICAGO==1,]
ggplot(data = cmap) +
  geom_sf(fill="white") +
  geom_point(data=matchdata, aes_string(x="longitude", y="latitude"),col="red",size=.3,alpha=0.8)  +
  guides( colour=guide_legend()) +
  theme_bw() +
  theme(plot.margin=unit(c(0,0,0,0),"mm"),
        axis.title =element_text(size=10),
        axis.text = element_text(size=5))
ggsave("chicago.pdf",height = 7, width = 12)
