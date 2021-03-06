---
title       : "Advanced Commands in R"
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
1.  Custom Functions  
2.  Control Structures
  * `for`, `while`,`if`, `ifelse`
2.  Apply family
    * `tapply`, `lapply`

---
## Custom functions
Function can be **named** or **anonymous**
- named = allows you to recall it (e.g. `mean`)
- anonymous = **disappears** after use (e.g. function built within `lapply`)


```r
my.function<-function(x){cbind(xbar=mean(x),n=length(x))}
my.function(0:10)
```

```
##      xbar  n
## [1,]    5 11
```

We'll explore anonymous functions with the `apply` family.

---
## Custom functions
### Why write a custom function?
If you need to do something more than once, save it as a function!
### How big is a function?
As big or as small as it needs to be.

---
## Standard Error

```r
se<-function(x){sd(x)/sqrt(length(x))}
se(rnorm(100))
```

```
## [1] 0.09161
```

```r
se(rnorm(100, sd=10))
```

```
## [1] 1.1
```

---
## Plots as functions
![plot of chunk unnamed-chunk-3](assets/fig/unnamed-chunk-3.png) 
  
There is a really good example of writing plot functions here: http://nicercode.github.io/

---
## Saving functions
### As you start to write functions you'll probably want to save them for future use.  

There are two ways of doing this:  

1.  `source` a *.R file with saved functions  
2.  Compile everything in to a local R package  

We'll focus on #1.

---
## Loading saved functions
Done using `source`

```r
FUN1(2)
```

```
## Error: could not find function "FUN1"
```

```r
source('~/Tufts/StatsClass/customFUN1.R')
FUN1(2)
```

```
## [1] 5 8
```

---
## Setting default values
Sometimes you want to build a generic function but set a common default value.

```r
myfun<-function(x, y=5) {x*y}
myfun(5)
```

```
## [1] 25
```

```r
myfun(5,2)
```

```
## [1] 10
```

---
## Anonymous variables in functions
Something created in a function only exists within a function unless you tell it to live outside the function in the **Global Environment**  
`<<-` assigns a variable to the **Global Environment**

```r
myfun<-function(){invis<-rnorm(100); print(mean(invis))}
myfun()
invis
myfun2<-function(){invis2<<-rnorm(100); print(mean(invis2))}
myfun()
invis2
```

---
## for
### What's a loop?
A `for` loop repeats some instructions over a **fixed** length of time

```r
for (placeholder in 1:5) {print (placeholder)}
```

```
## [1] 1
## [1] 2
## [1] 3
## [1] 4
## [1] 5
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
The placeholder can cylcle through elements of a vector

```r
a<-letters[1:10]
for (i in a) {cat(i)}
```

```
## abcdefghij
```
Or be used as a counter; or both:

```r
for (i in 1:10) {cat(paste(i, a[i], " ", sep=""))}
```

```
## 1a 2b 3c 4d 5e 6f 7g 8h 9i 10j
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
## ifelse & if/else

ifelse(condition, 'if true do this', 'otherwise do this')

```r
x<-1:10
ifelse(x>5, x+1, x^2)
```
`if` & `else` can work in tandem in loops or functions, similar to above allows multiple commands within the `if` or `else`

```r
for (i in x){
  if (i%%2==0) {print(i^2)}
  else {print(i/10)}
}
```

---
## Breaking or skipping within a loop
`break` and `next` can be used in a loop/function to stop or skip an iteration

```r
for (i in x){
  if (i%%2==0) {next}
  else(cat(i))
}
for (i in x){
  if (i^2>25) {break}
  else(cat(i))
}
```

---
## Apply family
Apply family is a vectorized loop function.  Generally it runs faster since loop is preformed in C.


```r
mydf<-data.frame(x=rep(a, 1000), y=(rnorm(10000)))
system.time(for (i in a) {cat(mean(mydf$y[mydf$x==i]))})
system.time(cat(tapply(mydf$y, mydf$x, mean)))
```

---
## Apply family
* `lapply`: Loop through items in a list, a function on each element, return a list
* `sapply`: Same as lapply but will return a vector or dataframe if possible
* `tapply`: applies a function to subsets within a vector
* See also `apply` and `mapply`

---
## lapply vs sapply

```r
mylist<-list(a=1:10, b=100:200, c=sample(100, 1:100), d=rnorm(100))
lapply(mylist, mean)
sapply(mylist, mean)
```

---
## Questions?

Time permitting: a quick look at what a custom package looks like

### Next week
a.  base plotting/ggplot/lattice  
b.  interactive plots (googleVis)/animation  
c.  reproducible documents (markdown, knitr, slidify)  
d.  suggestions?  

---
## Assignment
Build a function that determines if or where a thermocline occurs within a temperature profile.  The output of the function should include a statement indicating that either a thermocline does not exist or give the depth of the thermocline.


```r
mytcline(temp1)
```

```
## No thermocline detected
```

```r
mytcline(temp2)
```

```
## The thermocline is at 6m
```

### GOOD LUCK!
