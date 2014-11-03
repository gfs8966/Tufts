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
  - Packages 
  - Data types 
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
### - Lists*
* Lists are useful, we'll see them in different places but won't spend much time on them right now.  

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
### Just like `read.csv` is used to read a csv file, 
### `write.csv` is used to write a new csv


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
### Use & or | to match multiple conditions

---
## Understanding 'AND' vs 'OR'
Consider two variables that can be `TRUE` or `FALSE`  
`AND (&)` means both must be `TRUE`  
`OR (|)` means either can be `TRUE`  

<!-- html table generated in R 3.1.1 by xtable 1.7-4 package -->
<!-- Sat Nov  1 20:26:51 2014 -->
<table border=1>
<tr> <th>  </th> <th> A </th> <th> B </th> <th> AND </th> <th> OR </th>  </tr>
  <tr> <td align="right"> 1 </td> <td> TRUE </td> <td> TRUE </td> <td> TRUE </td> <td> TRUE </td> </tr>
  <tr> <td align="right"> 2 </td> <td> TRUE </td> <td> FALSE </td> <td> FALSE </td> <td> TRUE </td> </tr>
  <tr> <td align="right"> 3 </td> <td> FALSE </td> <td> TRUE </td> <td> FALSE </td> <td> TRUE </td> </tr>
  <tr> <td align="right"> 4 </td> <td> FALSE </td> <td> FALSE </td> <td> FALSE </td> <td> FALSE </td> </tr>
   </table>

---
## Merge
Merge is a powerful function.  It can be used to make 'all combination' tables; replace multiple nested `if` statements and reconstruct relational databases.

### All Combinations

```r
x<-letters[1:3]
y<-letters[4:6]
merge(x,y)
```

---
## Merging tables based on a lookup table
Let's change the numerical coding from 1/2/9 to 'male'/'female'/'unk'  
We could use multiple `ifelse` or `if/else` conditions:

```r
len.dat$SEX2<-with(len.dat, ifelse(SEX==1, 'male', ifelse(SEX==2,'female','unk')))
```
What happens though if you have 10 factors?
Easier to use `merge`

```r
key.table<-data.frame(SEX=c(1,2,3), SEX2=c('male','female','unk'))
merge(len.dat, key.table, by='SEX')
```

---
## Multiple key fields
Let's give a special name to male smelt

```r
malesmelt<-data.frame(SPC=121, SEX=1, NAME='smelt male')
merge(len.dat, malesmelt, by=c('SPC', 'SEX'))
```
What happens if we want to keep all the data?

```r
merge(len.dat, malesmelt, by=c('SPC', 'SEX'), all.x=T)
```

---
## Some other useful stuff
- `?function` gives the help file 
- `args(function)` gives the functions arguments 
- `function` gives the function's formula 

---
## Questions?


---
## Homework
1. Report mean FLEN for each species
2. Incorporate the following data in to the dataset  
<!-- html table generated in R 3.1.1 by xtable 1.7-4 package -->
<!-- Sun Nov  2 19:43:31 2014 -->
<table border=1>
<tr> <th>  </th> <th> SAM </th> <th> Date </th> <th> Gear </th>  </tr>
  <tr> <td align="right"> 1 </td> <td align="right">   1 </td> <td> Jul 2 </td> <td> Efish </td> </tr>
  <tr> <td align="right"> 2 </td> <td align="right">   2 </td> <td> Aug 5 </td> <td> GNet </td> </tr>
  <tr> <td align="right"> 3 </td> <td align="right">   3 </td> <td> Aug 9 </td> <td> Efish </td> </tr>
   </table>

3. Determine the mean alewife (spc=61) FLEN from Efish'ing
4. Make a plot that shows the distribution of smelt (spc=121) size based on gear type
5. Based on your plot, do you expect that gear is size selective for smelt?

