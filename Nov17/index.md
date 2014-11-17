---
title       : Creating Efficiencies
subtitle    : 
author      : Jeremy Holden
job         : 
framework   : io2012       # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---
## Outline
1.  Control Structures
  * `for`, `while`,`if`, `ifelse`
2.  Apply family
    * `apply`, `tapply`, `lapply`
3.  Custom Functions    

---
for
`for` is used to create loops
### What's a loop?
A `for` loop some instruction(s) is repeated over a **fixed** length of time

```r
for (placeholder in 1:10) {print (placeholder)}
```

```
## [1] 1
## [1] 2
## [1] 3
## [1] 4
## [1] 5
## [1] 6
## [1] 7
## [1] 8
## [1] 9
## [1] 10
```

`placeholder` can be anything but the general convention uses `i` then `j` for nested loops.

---
## while
`while` works similarly to `for` but instead of a fixed duration the loop operates as long as the condition is `TRUE`


```r
x<-1
while(x < 5) {cat(x); x<-x+1}
```

```
## 1234
```

```r
x
```

```
## [1] 5
```
### Watch out for runaway loops!!!

---
### Nested loops
It's possible to nest loops within each other although much more than 1 nested loop (loop within a loop) becomes difficult to write/interpret.


```r
for (i in 1:5){
  for (j in 6:10){
    cat(paste(i*j, " "))
  }
}
```

```
## 6  7  8  9  10  12  14  16  18  20  18  21  24  27  30  24  28  32  36  40  30  35  40  45  50
```

---
## Counter vs contents
The placeholder can be numeric (counter) or can cylcle through elements of a vector

```r
a<-letters[1:10]
for (i in a) {cat(i)}
```

```
## abcdefghij
```

```r
for (i in 1:10) {cat(paste(i, a[i]))}
```

```
## 1 a2 b3 c4 d5 e6 f7 g8 h9 i10 j
```

---
## Debugging
`cat` and `print` commands embedded in loops/functions can help with debugging.  

`debug`, `browser` and `trace` are other debugging features in R if you want to explore.

---
## How can we use loops...???
Any repetive task can be incorporated in to a loop to condense code.

### Plotting Example

```r
mydat<-read.csv('Tufts/StatsClass/lengthdata.csv')
spc<-unique(mydat$SPC)
spc<-spc[spc!=380]
par(mfrow=c(3,2), mar=c(5,4,1,1))
for (i in spc){
  x<-mydat[mydat$SPC==i,]
  boxplot(FLEN~SEX, x)
}
```

---
### Apply family
Apply family is a vectorized loop function.  Generally it runs faster since loop is preformed in C.


```r
mydf<-data.frame(x=rep(a, 1000), y=(rnorm(10000)))
system.time(for (i in a) {cat(mean(mydf$y[mydf$x==i]))})
```

```
## 0.047940.00033680.05862-0.008488-0.03931-0.028820.0536-0.03348-0.01688-0.04193
```

```
##    user  system elapsed 
##   0.004   0.000   0.008
```

```r
system.time(cat(tapply(mydf$y, mydf$x, mean)))
```

```
## 0.04794 0.0003368 0.05862 -0.008488 -0.03931 -0.02882 0.0536 -0.03348 -0.01688 -0.04193
```

```
##    user  system elapsed 
##   0.000   0.000   0.002
```

---
## Apply family
* lapply: Loop over a list and evaluate a function on each element, returns a list
* sapply: Same as lapply but try to simplify the result
* apply: Apply a function over the margins of an array
* tapply: Apply a function over subsets of a vector
* mapply: Multivariate version of lapply

---
## lapply vs sapply

```r
mylist<-list(a=1:10, b=100:200, c=sample(100, 1:100), d=rnorm(100))
lapply(mylist, mean)
```

```
## $a
## [1] 5.5
## 
## $b
## [1] 150
## 
## $c
## [1] 26
## 
## $d
## [1] -0.02387
```

```r
sapply(mylist, mean)
```

```
##         a         b         c         d 
##   5.50000 150.00000  26.00000  -0.02387
```


