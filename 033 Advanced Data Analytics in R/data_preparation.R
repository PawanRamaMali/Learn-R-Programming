# Basic fin <- read.csv('Future-500.csv')

fin <- read.csv("Future-500.csv",na.strings = c(""))
head(fin,3)
tail(fin,3)

# Structure of data
str(fin)
summary(fin)

# sub() and gsub()
fin$Expenses <- gsub("Dollars", "",fin$Expenses)
fin$Expenses <- gsub(",", "",fin$Expenses)
head(fin)

fin$Revenue <- gsub("\\$","",fin$Revenue)
fin$Revenue <- gsub(",","",fin$Revenue)
head(fin)

fin$Growth <- gsub("%","",fin$Growth)
head(fin)

fin$Expenses <- as.numeric(fin$Expenses)
fin$Revenue <- as.numeric(fin$Revenue)
fin$Growth <- as.numeric(fin$Growth)
str(fin)
summary(fin)


fin[!complete.cases(fin),]
str(fin)

fin[fin$Revenue ==9746272,]

fin[which(fin$Revenue == 9746272),]

is.na(fin$Expenses)
fin[is.na(fin$Expenses),]


# Removing records with missing data
# 
fin_backup <-  fin

fin[is.na(fin$Industry),]
fin[!is.na(fin$Industry),]
fin <- fin[!is.na(fin$Industry),]
fin

# Reset the dataframe index
# 
fin
rownames(fin) <- 1:nrow(fin)

rownames(fin) <- NULL # Alternate  method

# Replacing Missing Data : Factual Analysis
fin[is.na(fin$State),]
fin[is.na(fin$State) & fin$City=="New York",]
fin[is.na(fin$State) & fin$City=="New York","State"] <- "NY"

fin[c(11,377),c("State")]

fin[is.na(fin$State),]


fin[is.na(fin$State) & fin$City=="San Francisco",]
fin[is.na(fin$State) & fin$City=="San Francisco","State"] <- "CA"

fin[c(82,265),]


# Replacing missing data : Median imputation method
# 
fin[!complete.cases(fin),]

median(fin[,"Employees"],na.rm = TRUE) 

med_emp_retail <- median(fin[fin$Industry=="Retail","Employees"],na.rm = TRUE) 
mean(fin[fin$Industry=="Retail","Employees"],na.rm = TRUE) 

fin[is.na(fin$Employees)& fin$Industry=="Retail",]

fin[is.na(fin$Employees)& fin$Industry=="Retail","Employees"] <- med_emp_retail

fin[3,]


fin[is.na(fin$Employees)& fin$Industry=="Financial Services",]

med_emp_finserv <- median(fin[fin$Industry=="Financial Services","Employees"],na.rm = TRUE) 
mean(fin[fin$Industry=="Financial Services","Employees"],na.rm = TRUE) 


fin[is.na(fin$Employees) & fin$Industry=="Financial Services","Employees"] <- med_emp_finserv
fin[330,]


fin[!complete.cases(fin),]

med_growth_constr <-  median(fin[fin$Industry=="Construction","Growth",],na.rm = TRUE)
med_growth_constr
fin[is.na(fin$Growth) & fin$Industry =="Construction",]
fin[is.na(fin$Growth) & fin$Industry =="Construction","Growth"] <-  med_growth_constr

fin[8,]

fin[!complete.cases(fin),]


med_rev_constr <-  median(fin[fin$Industry=="Construction","Revenue"],na.rm = TRUE)
med_rev_constr
fin[is.na(fin$Revenue) & fin$Industry=="Construction","Revenue"] <-  med_rev_constr


fin[!complete.cases(fin),]

med_exp_constr <-  median(fin[fin$Industry=="Construction","Expenses"],na.rm = TRUE)
med_exp_constr
fin[is.na(fin$Expenses) & fin$Industry=="Construction","Expenses"] <- med_exp_constr

fin[!complete.cases(fin),]


# Replacing Missing data : deriving values
# 
# Revenue - Expenses = Profit

fin[is.na(fin$Profit),"Profit"] <-  fin[is.na(fin$Profit), "Revenue"] - fin[is.na(fin$Profit),"Expenses"]
fin[c(8,42),]
fin[!complete.cases(fin),]

fin[is.na(fin$Expenses),"Expenses"] <- fin[is.na(fin$Expenses),"Revenue"] - fin[is.na(fin$Expenses),"Profit"]

fin[15,]
fin[!complete.cases(fin),]

# Visualization 
# 
library(ggplot2)

# Scatterplot
p <- ggplot(data=fin)
p  

p + geom_point(aes(x=Revenue,y=Expenses,
                   color=Industry, size=Profit
                   ))

# Scatterplot 
p <- ggplot(data=fin, aes(x=Revenue,y=Expenses, color=Industry))
p  

p + geom_point() +
  geom_smooth(fill=NA,size=1.2)
                   
# Boxplot 

f <-  ggplot(data=fin, aes(x=Industry, y=Growth,
                           color=Industry))
f + geom_boxplot(size=1)

#  Extra:
f + geom_jitter() +
  geom_boxplot(size = 1, alpha=0.5,
               outlier.color = NA)

































