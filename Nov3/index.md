---
title       : Managing Data in R 
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
1. R Basics
  a. Packages
  b. Data types
2. Work directory/Read & Write Files
3. Working with data
  - Operators
  - Subsetting
  - Merge
4. Some useful stuff


---
## Packages
### Packages are just a collection of custom functions

```r
install.packages('ggplot2')
library(ggplot2) # or require()
```
If the package has already been installed you can call a function without loading the library like this:

```r
devEMF::emf('myfile.emf')
foreign::read.dbf('myfile.dbf')
```

---
## Vectors
- A vector is a collection of 'things'
- A vector has properties

```r
a<-c(1:10)
b<-letters[1:10]

class(a); class(b)
str(a); str(b)
summary(a) 
summary(b)
length(a); length(b)
```

---
## Numeric type vectors
Can preform additional operations on vectors with 'numeric' contents

```r
mean(a)
min(a)
max(a)
quantile(a)
quantile(a, probs=seq(0,1,0.1))
```

---
## Watch out for NAs
### NA are not known, NULL is not there.

```r
c<-c(1:5,NA,6:10)
mean(c)
mean(c, na.rm=T)
anyNA(c)
d<-c(1:5, NULL, 6:10)
mean(d)
```

---
## Other data types
### - Matrix
### - Array
### - Dataframe


We'll focus on data organized as dataframes. Let's look at a couple...

---
## rep
Two common usages depending on how you want the data to be organized.

```r
rep(c('x', 'y'), 3)
```

```
## [1] "x" "y" "x" "y" "x" "y"
```

```r
rep(c('x','y'), each=3)
```

```
## [1] "x" "x" "x" "y" "y" "y"
```

---
## Factors
### Factors are 'groups' that are used for analytical purposes
Convert text or numbers to factors by using `as.factor`
`read.csv` defualt is to convert text to factors, overide by using optional command `stringsAsFactors=F`; `as.is` or `colClasses`

Useful as categorical variable analysis like `table`

Use `levels(mydf$myfactor)` to recall all factor levels

---
## Accessing files
### It's possible to read, create and delete files, folders and figures directly from R
Here's some handy ones

```r
dir()
getwd()
setwd()
read.csv()
file.exists()
```

---
## Saving figures
### Most desirable file type will vary depending on usage 
pdf is useful for general sharing purposes

```r
pdf('MyFileName.pdf')
# some code to make a figure
dev.off() # used to close the file
```

emf look nice in documents and presentations and keep their properties when resized but most default picture viewers won't open them

```r
install.packages('devEMF')
library('devEMF')
emf('file.emf')
# plot a figure
dev.off()
```

---
## Saving text
### Just like `read.csv` is used to read a csv file, `write.csv` is used to write a new csv


```r
write.csv(a, 'StatsClass/a.csv', row.names=F)
```

---
## Operators
### Subsetting and Logicals (T/F) require `Operators`

<!-- html table generated in R 3.1.1 by xtable 1.7-4 package -->
<!-- Sat Nov  1 18:49:40 2014 -->
<table border=1>
<tr> <th>  </th> <th> Symbol </th> <th> English </th>  </tr>
  <tr> <td align="right"> 1 </td> <td> == </td> <td> exactly equal </td> </tr>
  <tr> <td align="right"> 2 </td> <td> &gt;,&lt; </td> <td> greater/less than </td> </tr>
  <tr> <td align="right"> 3 </td> <td> &gt;=,&lt;= </td> <td> greater/less than or equal to </td> </tr>
  <tr> <td align="right"> 4 </td> <td> ! </td> <td> NOT </td> </tr>
  <tr> <td align="right"> 5 </td> <td> != </td> <td> NOT equal </td> </tr>
  <tr> <td align="right"> 6 </td> <td> &amp; </td> <td> AND </td> </tr>
  <tr> <td align="right"> 7 </td> <td> | </td> <td> OR </td> </tr>
   </table>

---
## Subsetting
### Often we are interested in looking at only certain parts of the data based on some conditions
There are two general methods:

```r
subset(a, a>8)
a[a>8]
```
When using `[]` method, be aware of dimensions

```r
len.dat[len.dat$FLEN<500,c(2,3)]
```

---
## Some other useful stuff
- `?function` gives the help file 
- `args(function)` gives the functions arguments 
- `function` gives the function's formula 

