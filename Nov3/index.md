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

```
## [1] "integer"
```

```
## [1] "character"
```

```
##  int [1:10] 1 2 3 4 5 6 7 8 9 10
```

```
##  chr [1:10] "a" "b" "c" "d" "e" "f" "g" "h" "i" ...
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    1.00    3.25    5.50    5.50    7.75   10.00
```

```
##    Length     Class      Mode 
##        10 character character
```

```
## [1] 10
```

```
## [1] 10
```

---
## Numeric type vectors
Can preform additional operations on vectors with 'numeric' contents

```
## [1] 5.5
```

```
## [1] 1
```

```
## [1] 10
```

```
##    0%   25%   50%   75%  100% 
##  1.00  3.25  5.50  7.75 10.00
```

```
##   0%  10%  20%  30%  40%  50%  60%  70%  80%  90% 100% 
##  1.0  1.9  2.8  3.7  4.6  5.5  6.4  7.3  8.2  9.1 10.0
```

---
## Watch out for NAs
### NA are not known, NULL is not there.

```
## [1] NA
```

```
## [1] 5.5
```

```
## [1] TRUE
```

```
## [1] 5.5
```

---
## Other data types
# Matrix
# Array
# Dataframe


