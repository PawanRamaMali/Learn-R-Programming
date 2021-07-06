Chicago <-  read.csv("Weather Data/Chicago-C.csv",row.names = 1)
Chicago

NewYork <-  read.csv("Weather Data/NewYork-C.csv",row.names = 1)
Houston <-  read.csv("Weather Data/Houston-C.csv",row.names = 1)
SanFrancisco <-  read.csv("Weather Data/SanFrancisco-C.csv",row.names = 1)

# Check

is.data.frame(NewYork)

# Convert to matrices 

Chicago <- as.matrix(Chicago)
NewYork <- as.matrix(NewYork)
Houston <- as.matrix(Houston)
SanFrancisco <- as.matrix(SanFrancisco)

#Check 
is.matrix(Chicago)

# Convert to a list 
Weather <-  list(Chicago=Chicago,NewYork=NewYork,Houston=Houston,SanFrancisco=SanFrancisco)
Weather

Weather[3]
Weather[[3]]
Weather$Houston


Chicago

apply(Chicago, 1, mean)
apply(Chicago, 1, max)

# Compare cities 

apply(Chicago, 1, mean)
apply(NewYork, 1, mean)
apply(Houston, 1, mean)
apply(SanFrancisco, 1, mean)


# Recreating apply function with loops
Chicago

Output <- NULL

for (i in 1:5) {
  Output[i] <- mean(Chicago[i,])
}

Output
names(Output) <- rownames(Chicago)
Output

# Via apply function
apply(Chicago, 1, mean)

t(Chicago)
Weather

mynewlist <- lapply(Weather, t)
mynewlist

rbind(Chicago,NewRow=1:12)
lapply(Weather,rbind,NewRow=1:12)

lapply(Weather,"[",1,1)

lapply(Weather,"[",1,)
