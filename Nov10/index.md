---
title       : Data Manipulation
subtitle    : 
author      : Jeremy Holden
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---
## Outline
1. Ordering 
2. Reshaping
  * long to wide and back again
3. Summarizing 
  * `dcast`
  * `aggregate`
4. Dates

---
## Ordering
The function `order` returns a vector of the order, presented as the position in the orginal vector


```r
a<-c(letters[3:5], letters[1:2], letters[6:10])
a
```

```
##  [1] "c" "d" "e" "a" "b" "f" "g" "h" "i" "j"
```

```r
order(a)
```

```
##  [1]  4  5  1  2  3  6  7  8  9 10
```
Read: as lowest value is a[4] and highest is a[10]

---
## Reverse Ordering
Use the agrument `decreasing` to change to decreasing order

```r
order(a, decreasing = T)
```

```
##  [1] 10  9  8  7  6  3  2  1  5  4
```

---
## Showing the ordered values
This is done in two phases:  
1.  Determine the order  
2.  Present the vector *'subsetted'* according to the order  


```r
myord<-order(a)
a[myord]
```

```
##  [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j"
```
This is typically done inline:

```r
a[order(a)]
```

```
##  [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j"
```

---
## Ordering dataframes
Can order based on a single column or several columns...

```r
len.dat<-read.csv('StatsClass/lengthdata.csv')
# by one column
len.dat[order(len.dat$SAM),]
# by two columns
len.dat[order(len.dat$SAM, len.dat$SPC),]
```

---
## Long to Wide
Let's suppose that total length values are TLEN=FLEN+10 but we'll also assume (for some ridiculous reason) we recorded TLEN in cm, not mm

```r
len.dat<-len.dat[len.dat$SPC!=380,] # sculpins don't have a FLEN
len.dat$TLEN<-(len.dat$FLEN+10)/10
head(len.dat)
```
This makes our data very confusing...  
One way to fix this would be to change the column names to `FLEN_mm` and `TLEN_cm` but that's kind of messy for typing in to formulas..

---
## Reshaping data
Handy functions are found in `reshape2`

```r
library(reshape2)
```
We'll focus on `melt` (wide to long) and `cast` (long to wide)


```r
len.dat.long<-melt(len.dat, id=c('SAM', 'SPC', 'FISH', 'SEX'))
```

And now we can merge a table of units to the data...

---
## And then back again
Use `reshape` to go to wide form

```r
len.dat.wide<-reshape(len.dat.long, direction='wide', idvar=c('SAM','SPC','FISH','SEX'), 
                      v.names='value', timevar='variable')
```

---
## Using `dcast` to summarize data
`dcast` will make your data wide while performing a summary calculation but the output is messy when there is missing values

```r
dcast(len.dat.wide, SPC~SEX, mean, value.var='FLEN')
```

---
## `aggregate` provides better flexibility
We'll look at 4 different ways of using `aggregate`  

  1.   1 factor by 1 variable
  2.   1 factor by 2 key fields
  3.   2 factors by multiple key fields
  4.   Multiple functions  


```r
aggregate(x~y, data, FUN)
aggregate(x~y+z, data, FUN)
aggregate(cbind(w,x)~y+z, data, FUN)
aggregate(x~y+z, data, FUN = function (x) {c(mean(x),sd(x))})
```

---
## Primer on dates
### Dates are hard!
Consider an example...  
What is the date 1 year from today?  
What is meant by a year??? 12 months, 365 days, same day next calendar year, what happens if there is a leap year?

`lubridate` makes some of these tasks easier

```r
library(lubridate)
Sys.time()
Sys.time()+years(1)
Sys.time()+days(365)
```

For help, start here:  

http://cran.r-project.org/web/packages/lubridate/vignettes/lubridate.html

---
## Practical Example
Suppose the homework table looked like:

<!-- html table generated in R 3.1.1 by xtable 1.7-4 package -->
<!-- Mon Nov 10 10:14:28 2014 -->
<table border=1>
<tr> <th>  </th> <th> SAM </th> <th> SetDate </th> <th> SetTime </th> <th> LiftDate </th> <th> LiftTime </th> <th> Gear </th>  </tr>
  <tr> <td align="right"> 1 </td> <td align="right">   1 </td> <td> 02/07/14 </td> <td> 09:45 </td> <td> 03/07/14 </td> <td> 11:45 </td> <td> Gnet </td> </tr>
  <tr> <td align="right"> 2 </td> <td align="right">   2 </td> <td> 05/08/14 </td> <td> 10:15 </td> <td> 07/08/14 </td> <td> 9:30 </td> <td> GNet </td> </tr>
  <tr> <td align="right"> 3 </td> <td align="right">   3 </td> <td> 09/08/14 </td> <td> 13:45 </td> <td> 11/08/14 </td> <td> 10:00 </td> <td> GNet </td> </tr>
   </table>
    
We should probably calculate soak time for each net...

---
## Homework
### Calculate mean CUE as fish per 24hr net set for each species.

## Next week...
1.  Control Structures
  * `for`, `if`, `ifelse`, `while`
2.  Apply family
    * `apply`, `tapply`, `lapply`
    

---
## something else

```
## starting httpd help server ... done
```

---
## something else

