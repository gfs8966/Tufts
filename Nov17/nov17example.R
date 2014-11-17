setwd('Tufts')

## Custom functions
my.function<-function(x){cbind(xbar=mean(x),n=length(x))}
my.function(0:10)

## Standar Error function
se<-function(x){sd(x)/sqrt(length(x))}
se(rnorm(100))
se(rnorm(100, sd=10))

## custom plots
cust.plot<-function(x,y) {
  par(mar=c(5,5,5,1), cex.axis=0.75, cex.lab=0.75, mfrow=c(1,1))
  plot(x,y, pch=23, col='red', bg='blue')
  abline(v=mean(x), lty=3)
  abline(h=mean(y), lty=3)
  abline(lm(y~x+1), col='red', lty=2, lwd=3)
  title("Best Plot Ever")
}

cust.plot(rnorm(100), rnorm(100))
cust.plot(rnorm(100), rnorm(100))
cust.plot(rnorm(100), rnorm(100))
cust.plot(rnorm(100), rnorm(100))

## load a custom function
FUN1(2)
source('~/Tufts/StatsClass/customFUN1.R')
FUN1(2)


## Setting Defaults
myfun<-function(x, y=5) {x*y}
myfun(5)
myfun(5,2)

### Globabl Environment
myfun<-function(){invis<-rnorm(100); print(mean(invis))}
myfun()
invis
myfun2<-function(){invis2<<-rnorm(100); print(mean(invis2))}
myfun()
invis2


### for loop
for (placeholder in 1:10) {print (placeholder)}

### while loop
x<-1
while(x < 5) {cat(x); x<-x+1}
x

### nested loop
for (i in 1:5){
  for (j in 6:10){
    cat(paste(i*j, " "))
  }
}

###
a<-letters[1:15]
# you can print the value of ‘i' by using "i in a"
for (i in a){print(i)}
# or use i as a counter
for (i in 5:length(a)){print (i)}
# or combine the two...
for (i in 1:length(a)){print(paste(i,a[i]))}
b<-numeric() # creates a 'storage' vector
for (i in 1:5){  
  print(i)  
  b<-rbind(b, mean(rnorm(10)))  
  print(b)  
  # adding a manual pause will help you see what is going on
  # need to press <return> while in console to advance 
  readline("Press <return> to continue")
  
}

### Plot example
mydat<-read.csv('StatsClass/lengthdata.csv')
spc<-unique(mydat$SPC)
spc<-spc[spc!=380]
par(mfrow=c(3,2), mar=c(5,4,1,1))
for (i in spc){
  x<-mydat[mydat$SPC==i,]
  boxplot(FLEN~SEX, x)
}

## ifelse, if & else
x<-1:10
ifelse(x>5, x+1, x^2)

# %% gives the remainder in division
10%%2
10%%3

for (i in x){
  if (i%%2==0) {print(i^2)}
  else {print(i/10)}
}

## break and next
for (i in x){
  if (i%%2==0) {next}
  else(cat(i))
}
for (i in x){
  if (i^2>25) {break}
  else(cat(i))
}

custom.csv<-function(filename) {
  if(file.exists(filename)){mycsv<<-read.csv(filename)}
  else{cat('File does not exist')}
}

custom.csv('junk123.csv')
custom.csv('StatsClass/lengthdata.csv')
head(mycsv)


## Apply
mydf<-data.frame(x=rep(a, 1000), y=(rnorm(10000)))
system.time(for (i in a) {cat(mean(mydf$y[mydf$x==i]))})
system.time(cat(tapply(mydf$y, mydf$x, mean)))

## lapply vs sapply
mylist<-list(a=1:10, b=100:200, c=sample(100, 1:100), d=rnorm(100))
lapply(mylist, mean)
sapply(mylist, mean)

## more complex example
# let's make some fake data
w<-100
for (i in 1:4) {
  filename<-paste('StatsClass/myfile', i, '.csv', sep="")
  set.seed(w)
  df<-data.frame(x=1:100, y=rnorm(100))
  write.csv(df, filename, row.names=F)
  w<-w+1
}

# now let's each csv file in as an item of a list
allfiles<-dir('StatsClass/')
allfiles
allfiles<-grep(allfiles, pattern='^myfile', value=T) 
# grep is a text operator that uses 'Regular Expressions', the '^' means, 'starts with'
allfiles<-paste('StatsClass/', allfiles, sep="")
newlist<-lapply(allfiles, read.csv)
str(newlist)
lapply(newlist, FUN=function(x) mean(x[,2])) # note the use of the anonymous function
sapply(newlist, FUN=function(x) mean(x[,2]))

## practical example...
len.dat<-read.csv('StatsClass/lengthdata.csv')
len.list<-split(len.dat, len.dat$SPC)
sapply(len.list, FUN=function(x) mean(x$FLEN)) # note the use of the anonymous function
lapply(len.list, FUN=function(x) hist(x$FLEN, main=x$SPC[1]))
