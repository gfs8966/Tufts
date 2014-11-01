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
  a. Data types
  b. Packages
2. Work directory/Read & Write Files
3. Working with data
  - Merge
  - Subsetting
  - Operators
4. Some useful stuff


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

new slide


---
## Some other useful stuff
`?function` gives the help file
`args(function)` gives the functions arguments
`function` gives the function's formula