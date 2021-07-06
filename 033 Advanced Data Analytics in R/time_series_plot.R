getwd()

util <- read.csv("Machine-Utilization.csv")
head(util,12)
str(util)
summary(util)

# Derive utilization column
# 
util$Utilization = 1 -  util$Percent.Idle
head(util,12)

# Handling Dta-Time in R

?POSIXct
util$PosixTime <- as.POSIXct(util$Timestamp,format="%d/%m/%Y %H:%M")

head(util,12)

# Re-arrange columns
# 
 util$Timestamp <-  NULL
util <- util[,c(4,1,2,3)]
head(util)
summary(util)
RL1 <-  util[util$Machine=="RL1",]
summary(RL1)

RL1$Machine <- factor(RL1$Machine)
summary(RL1)

# Construct List

util_stats_rl1 <-  c(min(RL1$Utilization,na.rm = T),
                     mean(RL1$Utilization,na.rm = T),
                     max(RL1$Utilization,na.rm = T))

util_stats_rl1

util_under_90_flag <- as.logical(length(which(RL1$Utilization < 0.90)))

util_under_90_flag

list_rl1 <- list("RL1",util_stats_rl1,util_under_90_flag)
list_rl1

names(list_rl1)
names(list_rl1) <- c("Machine","Stats","LowThreshold")
list_rl1


# Extracting List components
# 
list_rl1[1]

list_rl1[[1]]

list_rl1$Machine

list_rl1$Stats

typeof(list_rl1$Machine)
typeof(list_rl1$Stats)

list_rl1$Stats[3]
list_rl1[[2]][3]

# Adding elements to list
# 
list_rl1[4] <- "New Info"
list_rl1

list_rl1$UnknownHours <- RL1[is.na(RL1$Utilization),"PosixTime"]
list_rl1

list_rl1[10] <- "New Info2"
list_rl1

# Remove elements in list
# 

list_rl1[4] <- NULL
list_rl1[4]

list_rl1$Data <-  RL1
list_rl1

summary(list_rl1)
str(list_rl1)

# Subsetting a list
# 
list_rl1[[4]][1]

list_rl1[1:2]

list_rl1[c(1,4)]




# Building a time series plot

library(ggplot2)

p <-ggplot(data = util)
p + geom_line(aes(x=PosixTime,y=Utilization,
                  colour=Machine),size= 1.2) +
  facet_grid(Machine~.)+
  geom_hline(yintercept=0.90,
            colour="Gray",size=1.2,
            linetype=3)


myplot <- p + geom_line(aes(x=PosixTime,y=Utilization,
                            colour=Machine),size= 1.2) +
  facet_grid(Machine~.)+
  geom_hline(yintercept=0.90,
             colour="Gray",size=1.2,
             linetype=3)


list_rl1$Plot <- myplot
list_rl1

list_rl1$Plot


summary(list_rl1)
str(list_rl1)

























