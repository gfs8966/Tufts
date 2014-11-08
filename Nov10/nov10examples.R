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

##### Summarizing with dcast
dcast(len.dat.wide, SPC~SEX, mean, value.var='FLEN')
dcast(len.dat.wide, SAM~SPC, max, value.var='TLEN')

##### Using aggregate
head(len.dat)
sum1<-aggregate(FLEN~SPC, len.dat, mean)
sum1

# similar to the dcast example...
sum2<-aggregate(FLEN~SPC+SEX, data=len.dat, mean)
sum2 # notice it only returns combinations that exist
aggregate(TLEN~SAM+SPC, len.dat, max)
# generate a catch summary
aggregate(FISH~SAM+SPC, data=len.dat, length)

# now FLEN and TLEN
aggregate(cbind(FLEN, TLEN)~SPC+SEX, data=len.dat, mean)
aggregate(cbind(FLEN, TLEN)~SPC, data=len.dat, mean)

# suppose we wanted mean, sd and n...
# need to write a custom function
myfunct<-function(x) {c(xbar=mean(x), stdev=sd(x), n=length(x))}
b
myfunct(b)
aggregate(FLEN~SAM+SPC, len.dat, myfunct)
aggregate(cbind(FLEN,TLEN)~SPC, data=len.dat, myfunct)


##### Dates
SAM<-c(1:3)
SetDate<-c('02/07/14','05/08/14','09/08/14')
LiftDate<-c('03/07/14','07/08/14','11/08/14')
SetTime<-c('09:45', '10:15', '13:45')
LiftTime<-c('11:45', '9:30', '10:00')
Gear<-c('Gnet', 'GNet', 'GNet')
set.data<-data.frame(SAM, SetDate, LiftDate, SetTime, LiftTime, Gear, stringsAsFactors=F)
str(set.data)

set.data$SET<-paste(SetDate, SetTime)
set.data$LIFT<-paste(LiftDate, LiftTime)
head(set.data)
set.data$SET1<-as.Date(set.data$SET, format="%d/%m/%y %H:%M")
set.data$LIFT1<-as.Date(set.data$LIFT, format="%d/%m/%y %H:%M")
with(set.data, LIFT1-SET1)

library(lubridate)
set.data$SET2<-dmy_hm(set.data$SET)
set.data$LIFT2<-dmy_hm(set.data$LIFT)
dur<-with(set.data, LIFT2-SET2)
dur
as.period(dur)
