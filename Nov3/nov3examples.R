# Nov. 3, Managing Data in R

# Vectors
a<-c(1:10)
b<-letters[1:10]

class(a); class(b)
str(a); str(b)
summary(a) 
summary(b)
length(a); length(b)

# Numeric vectors
mean(a)
min(a)
max(a)
quantile(a)
quantile(a, probs=seq(0,1,0.1))

# NA example
c<-c(1:5,NA,6:10)
mean(c)
mean(c, na.rm=T)
anyNA(c)
d<-c(1:5, NULL, 6:10)
mean(d)

# Matrix and Array
## We're not likely going to spend much time with these
matrix(a, ncol=2)
array(a, dim=c(2,2,3))

# Dataframe - our main work horse!
data.frame(a,b,d)
data.frame(a,b,c)

# Dataframe
spc<-rep(c('red fish', 'blue fish'), 5)
set.seed(16)
tl<-round(runif(10, min=250, max=500),0)
fish.data<-data.frame(spc, tl)
fish.data
str(fish.data)

# default is to assign as text as 'Factors', why is this important?
barplot(fish.data$tl, col=as.factor(spc))
plot(tl~spc, fish.data)
table(fish.data$spc)
with(fish.data, by(tl, spc, mean)) #same as writing by(fish.data$tl, fish.data$spc, mean)
tapply(fish.data$tl, fish.data$spc, mean) # we'll deal with the apply family in more detail later

###### 
# Reading data
getwd()
setwd('/home/jer/Tufts')
dir()
dir.create('StatsClass')
dir()
# move lengthdata.csv to this new directory
len.dat<-read.csv('StatsClass/lengthdata.csv')
str(len.dat)
# maybe we want to convert
len.dat$SPC<-as.factor(len.dat$SPC)
len.dat$SEX<-as.factor(len.dat$SEX)

# Figures
hist(len.dat$FLEN)
barplot(table(len.dat$SPC))

pdf('StatsClass/myhist.pdf')
hist(len.dat$FLEN)
dev.off()

pdf('StatsClass/mybar.pdf')
barplot(table(len.dat$SPC))
dev.off()

pdf('StatsClass/allfigs.pdf')
hist(len.dat$FLEN)
barplot(table(len.dat$SPC))
dev.off()

mysummary<-with(len.dat, tapply(FLEN, SPC, length)) # length = number of obs.
mysummary
as.data.frame(mysummary)

write.csv(as.data.frame(mysummary), 'StatsClass/mysummary.csv', row.names=T)
dir('StatsClass')
