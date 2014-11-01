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
