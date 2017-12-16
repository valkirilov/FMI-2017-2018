
# From the last time
data()
?rivers

rivers
mean(rivers)
median(rivers)

var(rivers)
sd(rivers)

min(rivers)
max(rivers)
sum(rivers)
cummin(rivers)
cummax(rivers)
?cummin
length(rivers)

rivers[rivers == 3710] = 2500
rivers[rivers == 2500]
rivers[68]
rivers[1:10]

# New excercise
# Dataframes


mtcars
?mtcars

head(mtcars)
head(mtcars, 2)
?head # see man

tail(mtcars)
tail(mtcars, 3)

nrow(mtcars)
ncol(mtcars)

# get cols
mtcars[1, 2]
mtcars["Mazda RX4", "cyl"]
mtcars[, "cyl"]
mtcars[, 2]
mtcars$cyl
mtcars[, c("mpg", "cyl")]
mtcars[, c(1,2)]

# same for rows

# read csv
# dataset for homework: Pokemon with yellow label of Picahku
titanic = read.csv("train.csv")
titanic
?read.csv
View(titanic)
attach(titanic)

titanic$Pclass
# attach(titanic) to have vectors for every col
Pclass
Pclass = c(1)
Pclass
titanic$Pclass

names(titanic)
ls(titanic)

head(titanic)
tail(titanic)

nrow(mtcars)
ncol(mtcars)

# analyze the table
head(titanic, 6)
titanic$Survived
table(titanic$Survived)
table(titanic$Age)
barplot(titanic$Survived)
barplot(table(titanic$Survived))
prop.table(table(titanic$Survived))
barplot(prop.table(table(titanic$Survived)))
barplot(table(titanic$Survived)/length(titanic$Survived), col=c("blue", "red"))
factor(titanic$Survived)
?factor

?table
?barplot

pie(table(titanic$Survived))
pie(table(titanic$Survived)/length(titanic$Survived), col=c("blue", "red"))

factor(titanic$Pclass)
table(titanic$Pclass)
table(titanic$Sex)
table(titanic$Embarked)
barplot(table(titanic$Pclass))

table(titanic$Sex)
barplot(table(titanic$Sex))

table(titanic$Embarked)
barplot(table(titanic$Embarked))
prop.table(table(titanic$Embarked))
barplot(prop.table(table(titanic$Embarked)))

# second part
titanic$SibSp
min(titanic$SibSp)
max(titanic$SibSp)
mean(titanic$SibSp)
median(titanic$SibSp)
var(titanic$SibSp)
sd(titanic$SibSp)

?quantile
quantile((titanic$SibSp), 0.25)
quantile((titanic$SibSp), 0.50)
q3 = quantile((titanic$SibSp), 0.75)

summary(titanic$SibSp)
boxplot(titanic$SibSp, horizontal = TRUE)

q3 + 1.5*IQR(titanic$SibSp)

fivenum(titanic$SibSp)
summary(titanic$SibSp)

sort(titanic$SibSp)

?stem
stem(titanic$SibSp)
hist(titanic$SibSp)
boxplot(titanic$SibSp)

x = c(1, 2, 3, 4, 5, 6, 10, 11, 15, 21, 25, 100, 13)
stem(x)

# alone
titanic$Age
head(titanic$Age)
min(titanic$Age)
max(titanic$Age)
mean(titanic$Age)
median(titanic$Age)
var(titanic$Age)
quantile((titanic$Age), 0.25)


fivenum(titanic$Age)
summary(titanic$Age)
stem(titanic$Age)
hist(titanic$Age)
boxplot(titanic$Age, horizontal = TRUE)

# other excercices
data()
?south

install.packages("MASS")
install.packages("UsingR")
library(UsingR)

south
?south
View(south)
hist(south)
summary(south)
boxplot(south, horizontal = TRUE)

crime
?crime
hist(crime$y1983)
hist(crime$y1993)
boxplot(crime$y1983, horizontal = TRUE)
boxplot(crime$y1993, horizontal = TRUE)

aid
?aid
hist(aid)
boxplot(aid, horizontal = TRUE)

# Homework - POkemon analyze