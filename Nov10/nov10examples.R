#####################################
## Nov. 10, Data Manipulation in R ##
## Jeremy Holden                   ##
#####################################

##### Ordering
a<-c(letters[3:5], letters[1:2], letters[6:10])
a
order(a)

set.seed(123)
b<-round(runif(10, min=0, max=50),0)
b
order(b)

##### Reverse ordering
order(a, decreasing = T)
order(b, decreasing=T)
# a shorter way for numbers..
order(-b)

##### Getting the values
myord<-order(a)
a[myord]
a[order(a)]

b[order(b)]
b[order(b, decreasing=T)]
b[order(-b)]

## Ordering a dataframe
len.dat<-read.csv('StatsClass/lengthdata.csv')
View(len.dat[order(len.dat$SAM),])
View(len.dat[order(len.dat$SAM, len.dat$SPC),])


## Long to Wide
len.dat<-len.dat[len.dat$SPC!=380,] # sculpins don't have a FLEN
len.dat$TLEN<-(len.dat$FLEN+10)/10
head(len.dat)

library(reshape2)

len.dat.long<-melt(len.dat, id=c('SAM', 'SPC', 'FISH', 'SEX'))
head(len.dat.long)
tail(len.dat.long)

units<-data.frame(variable=c('TLEN', 'FLEN'), unit=c('cm','mm'))
units
len.dat.long<-merge(len.dat.long, units, by='variable')
head(len.dat.long)
tail(len.dat.long)
len.dat.long<-len.dat.long[,c(2:5,1,6:7)]

##### reshape
len.dat.long<-len.dat.long[,-7]
len.dat.wide<-reshape(len.dat.long, direction='wide', idvar=c('SAM','SPC','FISH','SEX'), 
                      v.names='value', timevar='variable')
head(len.dat.wide)
names(len.dat.wide)[5:6]<-c('FLEN','TLEN')
head(len.dat.wide)
