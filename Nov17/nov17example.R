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