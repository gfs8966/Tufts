################################
## Nov. 3, Managing Data in R ##
## Jeremy Holden              ##
################################

##### Vectors
a<-c(1:10)
b<-letters[1:10]

class(a); class(b)
str(a); str(b)
summary(a) 
summary(b)
length(a); length(b)

##### Numeric vectors
mean(a)
min(a)
max(a)
quantile(a)
quantile(a, probs=seq(0,1,0.1))


###### NA example
c<-c(1:5,NA,6:10)
mean(c)
mean(c, na.rm=T)
anyNA(c)
d<-c(1:5, NULL, 6:10)
mean(d)

##### Matrix, Array and Dataframes
matrix(a, ncol=2)
array(a, dim=c(2,2,3))
# We're not likely going to spend much time with matrices and arrays

# Dataframe - our main work horse!
data.frame(a,b,d)
data.frame(a,b,c)

###### Using 'rep' to make a dataframe
spc<-rep(c('red fish', 'blue fish'), 5)
set.seed(16)
tl<-round(runif(10, min=250, max=500),0)
fish.data<-data.frame(spc, tl)
fish.data
str(fish.data)

###### default is to assign as text as 'Factors', why is this important?
barplot(fish.data$tl, col=as.factor(spc))
plot(tl~spc, fish.data)
table(fish.data$spc)
with(fish.data, by(tl, spc, mean)) #same as writing by(fish.data$tl, fish.data$spc, mean)
tapply(fish.data$tl, fish.data$spc, mean) # we'll deal with the apply family in more detail later

##### Reading data
getwd()
setwd('/home/jer/Tufts')
dir()
dir.create('StatsClass')
dir()
# move lengthdata.csv to this new directory
len.dat<-read.csv('StatsClass/lengthdata.csv')
str(len.dat)
# maybe we want to convert to some factors
len.dat$SPC<-as.factor(len.dat$SPC)
len.dat$SEX<-as.factor(len.dat$SEX)
len.dat$SAM<-as.factor(len.dat$SAM)

##### Saving Figures
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

##### Saving as text
mysummary<-with(len.dat, tapply(FLEN, SPC, length)) # length = number of obs.
mysummary
as.data.frame(mysummary)

write.csv(as.data.frame(mysummary), 'StatsClass/mysummary.csv', row.names=T)
dir('StatsClass')

##### Operators
7>6
a>3
a<2 | a>9

##### Subsetting
subset(a, a>8)
a[a>8]
len.dat[len.dat$FLEN<500,c(2,3)]

len.dat[len.dat$SEX==1 & len.dat$SPC==61,]
len.dat[len.dat$SEX==1 & !is.na(len.dat$SEX) & len.dat$SPC==61,]

spc61<-subset(len.dat, subset=(SPC==61))
plot(FLEN~SPC, spc61)
levels(spc61$SPC)
unique(spc61$SPC)
# What just happened? Subsetting worked but factor levels still present...???
# need to remove all factor levels
#spc61<-subset(len.dat, subset=(SPC==61), drop=T)
spc61$SPC<-droplevels(spc61$SPC)
levels(spc61$SPC)

##### what's the difference between & and |
subset(len.dat, subset=(SPC==380 & SEX==2))
subset(len.dat, subset=(SPC==380 | SEX==2))

##### Merge
# all combinations
x<-letters[1:3]
y<-letters[4:6]
merge(x,y)

##### Lookup table
# let's add some names to decode SEX
len.dat$SEX2<-with(len.dat, ifelse(SEX==1, 'male', ifelse(SEX==2,'female','unk')))
                   
# Using merge
key.table<-data.frame(SEX=c(1,2,3), SEX2=c('male','female','unk'))
merge(len.dat, key.table, by='SEX')

##### Use two fields
malesmelt<-data.frame(SPC=121, SEX=1, NAME='smelt male')
merge(len.dat, malesmelt, by=c('SPC', 'SEX'))
merge(len.dat, malesmelt, by=c('SPC', 'SEX'), all.x=T)

