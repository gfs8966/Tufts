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
a[2:4]
b[order(b)]
b[order(b, decreasing=T)]
b[order(-b)]

## Ordering a dataframe
len.dat<-read.csv('Tufts/StatsClass/lengthdata.csv')
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
dcast(len.dat.wide, SAM~SPC, mean, value.var='TLEN')

##### Using aggregate
head(len.dat)
sum1<-aggregate(FLEN~SPC, len.dat, mean)
sum1

# similar to the dcast example...
sum2<-aggregate(FLEN~SPC+SEX, data=len.dat, mean)
sum2 # notice it only returns combinations that exist

x<-as.data.frame(unique(len.dat$SPC))
y<-as.data.frame(c(1,2))
df<-merge(x,y)
names(df)<-c('SPC', 'SEX')
merge(sum2, df, by=c('SPC','SEX'), all.y=T)


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
library(lubridate)
Sys.time()
Sys.time()+years(1)
leap_year(2016)
ymd('20150301')+years(1)
ymd('20150301')+days(365)

ymd('020301')
ymd('020301')-years(100)

##### Practical example

# enter the data
SAM<-c(1:3)
SetDate<-c('02/07/14','05/08/14','09/08/14')
LiftDate<-c('03/07/14','07/08/14','11/08/14')
SetTime<-c('09:45', '10:15', '13:45')
LiftTime<-c('11:45', '9:30', '10:00')
Gear<-c('Gnet', 'GNet', 'GNet')
set.data<-data.frame(SAM, SetDate, LiftDate, SetTime, LiftTime, Gear, stringsAsFactors=F)
# check classes
str(set.data)

# make 1 long date/time field
set.data$SET<-paste(SetDate, SetTime)
set.data$LIFT<-paste(LiftDate, LiftTime)
head(set.data)

# convert to date class
set.data$SET1<-as.Date(set.data$SET, format="%d/%m/%y %H:%M")
set.data$LIFT1<-as.Date(set.data$LIFT, format="%d/%m/%y %H:%M")
with(set.data, LIFT1-SET1)
# not exactly what we wanted...

# try using lubridate functions
set.data$SET2<-dmy_hm(set.data$SET)
set.data$LIFT2<-dmy_hm(set.data$LIFT)
dur<-with(set.data, LIFT2-SET2)
dur
class(dur)
as.period(dur)

as.numeric(dur, units='hours')
as.numeric(dur, units='days')
as.numeric(dur, units='mins')

### homework solution
sum1<-aggregate(FISH~SAM+SPC, data=len.dat, length)
set.data$dur<-with(set.data, as.numeric(LIFT2-SET2, units='hours'))
x<-as.data.frame(unique(len.dat$SPC))
y<-as.data.frame(unique(len.dat$SAM))
df<-merge(x,y)
names(df)<-c('SPC', 'SAM')
sum3<-merge(sum1, df, by=c('SPC','SAM'), all.y=T)
sum3$FISH[is.na(sum3$FISH)]<-0
names(sum3)<-c('SPC','SAM', 'N')
sum4<-merge(sum3, set.data, by='SAM')
head(sum4)
sum4$catstan<-with(sum4, N/dur)
perdaymean<-function(x){mean(x)*24}
aggregate(catstan~SPC, sum4, perdaymean)
sum4[sum4$SPC==61,]
