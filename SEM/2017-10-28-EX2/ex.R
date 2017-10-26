library("UsingR")

#titanic = read.csv("train.csv")
  #simple.hist.and.bloxplot(titanic$fare)
   
  #h = hist(titanic$Fare)
  ##h$breaks
  #h$counts
  #h$density
  #h$mids
  #h$xname
  
#  simple.freqpoly(titanic$Fare)
#  #lines(c(min(h$breaks), h$mids, max(h$breaks))
#  hist(titanic$Fare, bw=10), probability = TRUE)
 # lines(density(titanic$Fare, bw=10),col="blue")
  
smokes = c("Yes", "No", "No", "Yes", "No")
amount = c(1,2,2,3,4)
table(smokes, amount)
options(digits=3)
prop.table(table(smokes, amount), 1)
prop.table(table(smokes, amount), 2)
prop.table(table(smokes, amount))

barplot(table(smokes, amount))
barplot(table(amount, smokes))
barplot(table(smokes, amount), beside=TRUE)

# seeL apply, tapply, mapply, sapply

# Categorical vs Numerical
experimentalGroup = c(5,5,5,13,7,11,11,9,8,9)
controlGruop = c(11,8,4,5,9,5,10,5,5,10)
boxplot(experimentalGroup, controlGruop)

amount = c(5,5,5,13,7)
category = c(1,1,1,2,2)
boxplot(amount ~ category)

home
home$new
names(home)
scale(home$old)
boxplot(home$old)
boxplot(scale(home$old))
boxplot(scale(home$old), scale(home$new))

stripchart(home$old)
stripchart(scale(home$old))

simple.violinplot(scale(home$old), scale(home$new))

plot(home$old, home$new)
cor(home$old, home$new)

# 4.4
homedata
names(homedata)
table(homedata$y1970, homedata$y2000)
table(scale(homedata$y1970), scale(homedata$y2000))
boxplot(scale(homedata$y1970), scale(homedata$y2000))
simple.violinplot(scale(homedata$y1970), scale(homedata$y2000))
plot(homedata$y1970, homedata$y2000)
cor(homedata$y1970, homedata$y2000)

plot(homedata$y2000 ~ homedata$y1970)
plot(homedata$y1970)
plot(homedata$y2000)

  
# 4.5
florida
names(florida)
plot(florida)

emissions
plot(emissions)
names(emissions)
plot(emissions$GDP, emissions$perCapita)

cor(emissions$GDP, emissions$CO2)
plot(emissions$CO2 ~ emissions$GDP)

# mutivariate
weight = c(150, 135, 210, 140)
height = c(65, 61, 70, 65)
gender = c("Fe","Fe","M","Fe")
