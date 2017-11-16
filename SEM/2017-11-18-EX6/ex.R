# Law of large numbers (Закона за големите числа)

# Example: Throwing a dice
# Probability
# P(X=1) = P(X=2) = P(x=3) = P(X=4) = P(x=5) = P(x=6) = 1/6
1/6
#Throwing a dice 10 times
x = sample(1:6, 10, replace = TRUE)
table(x)
table(x)/length(x)
barplot(table(x))
#Throwing a dice 100 times
x = sample(1:6, 10^2, replace = TRUE)
table(x)
table(x)/length(x)
barplot(table(x))
#Throwing a dice 1000 times
x = sample(1:6, 10^3, replace = TRUE)
table(x)
table(x)/length(x)
barplot(table(x))
#Throwing a dice 10000 times
x = sample(1:6, 10^4, replace = TRUE)
table(x)
table(x)/length(x)
barplot(table(x))
#Throwing a dice 10^7 times
x = sample(1:6, 10^7, replace = TRUE)
table(x)
table(x)/length(x)
barplot(table(x))
#Throwing a dice 10^8 times
x = sample(1:6, 10^8, replace = TRUE)
table(x)/length(x)

# Flip a coin 50000 times
n = 50000
x = sample(0:1, n, replace = TRUE);x # Coin flip
s = cumsum(x);s # Sum of successes on every step
r = s/(1:n);r   # Probability of success on every step
plot(r, ylim=c(0.0, 1), type="l") # Plot the probability of success on every step
lines(c(0,n), c(.5,.5), col = "red")
cbind(x,s,r)[1:10,]

# Just to see the dots clearly
# Flip a coin 500 times
n = 100
x = sample(0:1, n, replace = TRUE);x # Coin flip
s = cumsum(x);s # Sum of successes on every step
r = s/(1:n);r   # Probability of success on every step
plot(r, ylim=c(0, 1), type="l") # Plot the probability of success on every step
lines(c(0,n), c(.5,.5), col = "red")
cbind(x,s,r)[1:20,]








# The central limit theorem (Централна гранична теорема)
# https://en.wikipedia.org/wiki/Central_limit_theorem
# https://en.wikipedia.org/wiki/Illustration_of_the_central_limit_theorem

# Централна гранична теорема за суми
# x1, x2, ... , xn - независими наблюдения над сл.в. X
# EX = mu
# DX = sigma^2
# При голям обем на извадката
# x1+x2+...+xn ~ N(n*mu, n*sigma^2)
# (Sn - n*mu)/sigma*sqrt(n)

# Example: Dice
# https://upload.wikimedia.org/wikipedia/commons/8/8c/Dice_sum_central_limit_theorem.svg
# Explaning some code: Simulating rolling two dice 10^6 times
replicate(2, sample(1:6, 1000000, replace = TRUE))
# Calculating the sum of two dice
rowSums(replicate(2, sample(1:6, 1000000, replace = TRUE)))
?rowSums
# colSums (x)
# rowSums (x)
# colMeans(x)
# rowMeans(x)
# Other way to write the same example, but I don't prefer you to use it in this class
sample(2:12, size = 100, replace = TRUE, prob = table(outer(1:6,1:6,"+")) / 36)

# Throw two dice
replicate(2, sample(1:6, 1000000, replace = TRUE))
dice.two = rowSums(replicate(2, sample(1:6, 1000000, replace = TRUE)));dice.two
table(dice.two)
hist(dice.two, col = "Grey")
# Throw three dice
replicate(3, sample(1:6, 1000000, replace = TRUE))
dice.three = rowSums(replicate(3, sample(1:6, 1000000, replace = TRUE)));dice.three
table(dice.three)
hist(dice.three, col = "Grey")
# Throw four dice
replicate(4, sample(1:6, 1000000, replace = TRUE))
dice.four = rowSums(replicate(4, sample(1:6, 1000000, replace = TRUE)));dice.four
table(dice.four)
hist(dice.four, col = "Grey")
# Throw five dice
replicate(5, sample(1:6, 1000000, replace = TRUE))
dice.five = rowSums(replicate(5, sample(1:6, 1000000, replace = TRUE)));dice.five
table(dice.five)
hist(dice.five, col = "Grey")

# Binomial distribution - sum of Bernulli
# Sn ~ Bi(n,p)
# ESn = np
# DSn = npq
n = 10
p = 1/6
Sn = rbinom(500, n, p)
X = (Sn - n*p)/sqrt(n*p*(1-p));X
hist(X, probability = TRUE)
y = dnorm(seq(from = -3, to = 3, by = 0.1), mean = 0, sd = 1)
lines(seq(from = -3, to = 3, by = 0.1), y, col = "red", type = "l")
# As n gets bigger
n = 1000
p = 1/6
Sn = rbinom(500, n, p)
X = (Sn - n*p)/sqrt(n*p*(1-p))
hist(X, probability = TRUE)
y = dnorm(seq(from = -3, to = 3, by = 0.1), mean = 0, sd = 1)
lines(seq(from =-3, to = 3, by = 0.1), y, col = "red", type = "l")

# Централна гранична теорема за средното аритметично
# x1, x2, ... , xn - независими наблюдения над сл.в. X
# EX = mu
# DX = sigma^2
# xbar = (x1+x2+...+xn)/n ~ N(mu, sigma^2/n)
# (xbar - mu)/(sigma/sqrt(n))

# Example:
# for loops
# When X~N(mu, sigma^2) we don't need big n
res = mat.or.vec(5000, 1);
n = 10
mu = 2
sigma = 5
for(i in 1:5000){
  X = rnorm(n, mu, sigma)
  res[i] = (mean(X) - mu)/(sigma/sqrt(n))
}
hist(res, probability = TRUE)
y = dnorm(seq(from = -3, to = 3, by = 0.1), mean = 0, sd = 1)
lines(seq(from = -3, to = 3, by = 0.1), y, col = "red", type = "l")

# The same example
# with functoins
f = function (m, n, mu = 0, sigma = 1){
  res = numeric(0)
  for(i in 1:m){
    X = rnorm(n, mu, sigma)
    res[i] = (mean(X) - mu)/(sigma/sqrt(n))
  }
  return(res)
}
r = f(5000, 10, 2, 5)
hist(r, prob = T)
y = dnorm(seq(from = -3, to = 3, by = 0.1), mean = 0, sd = 1)
lines(seq(from = -3, to = 3, by = 0.1), y, col = "red", type = "l")

# The same example
# with the function simple.sim from UsingR package
library("UsingR")
f = function(n, mu, sigma){
  X = rnorm(n, mu, sigma)
  (mean(X) - mu)/(sigma/sqrt(n))
}
r = simple.sim(5000, f, 10, 2, 5)
?simple.sim
hist(r, prob = T)
y = dnorm(seq(from = -3, to = 3, by = 0.1), mean = 0, sd = 1)
lines(seq(from = -3, to = 3, by = 0.1), y, col = "red", type = "l")




# Another example:
# X ~ Exp(lambda = 0.1)
# EX = 1/lambda
# DX = 1/lambda^2
# x1 + x2 + .. + x10 ~ ?
lambda = 0.1
n = 10
mu = 1/lambda
sigma = 1/lambda
for(i in 1:5000){
  X = rexp(n, lambda)
  res[i] = (mean(X) - mu)/(sigma/sqrt(n))
}
hist(res, prob = T)
y = dnorm(seq(from = -3, to = 3, by = 0.1), mean = 0, sd = 1)
lines(seq(from = -3, to = 3, by = 0.1), y, col = "red", type = "l")
# The same example with simple.sim
f = function(n, lambda){
  X = rexp(n, lambda)
  mu =1/lambda
  sigma=1/lambda
  (mean(X) - mu)/(sigma/sqrt(n))
}
r = simple.sim(5000, f, 10, 0.1)
hist(r, prob = T)
y = dnorm(seq(from = -3, to = 3, by = 0.1), mean = 0, sd = 1)
lines(seq(from = -3, to = 3, by = 0.1), y, col = "red", type = "l")
# The same exmpale n = 100000
# x1 + x2 + .. + x100000 ~ ?
lambda = 0.1
n = 100000
mu = 1/lambda
sigma = 1/lambda
for(i in 1:5000){
  X = rexp(n, lambda)
  res[i] = (mean(X) - mu)/(sigma/sqrt(n))
}
hist(res, prob = T)
y = dnorm(seq(from = -3, to = 3, by = 0.1), mean = 0, sd = 1)
lines(seq(from = -3, to = 3, by = 0.1), y, col = "red", type = "l")
# The same example with simple.sim
f = function(n, lambda){
  X = rexp(n, lambda)
  mu =1/lambda
  sigma=1/lambda
  (mean(X) - mu)/(sigma/sqrt(n))
}
r = simple.sim(5000, f, 100000, 0.1)
hist(r, prob = T)
y = dnorm(seq(from = -3, to = 3, by = 0.1), mean = 0, sd = 1)
lines(seq(from = -3, to = 3, by = 0.1), y, col = "red", type = "l")




# qq-plot (quantile quantile plot)
# https://en.wikipedia.org/wiki/Normal_probability_plot
# The dots are with coordinates (x(n,i), q((i-1)/n)), i = 1,2,...
# Graph the quantiles of your data against the corresponding quantiles of the normal distribution
# If the tested distribution matches the real distribution, the dots will be on the line

# normal quantile plot - better plot for deciding if random data is approximately normal
?qqnorm
?qqline
library(StatDA)
?qqplot.das

# Example: X~N(2, 10^2)
x = rnorm(300, 2, 10)
qqnorm(x, main = 'normal(2, 10)', col = "green")
qqline(x)
# The same example
library(StatDA)
qqplot.das(x, "norm", col = palette()[3])

# Example: X~Exp(10)
x = rexp(300, 10)
qqnorm(x, col = "red")
qqline(x)
# The same example
qqplot.das(x, "norm", col = palette()[2])
qqplot.das(x, "exp", col = palette()[3])

# Example: X~U(2,7)
x = runif(300, min = 2, max = 7)
qqnorm(x, col = "red")
qqline(x)
# The same example
qqplot.das(x, "norm", col = palette()[2])
qqplot.das(x, "unif", col = palette()[3])

# Example X~t(3)
x = rt(100, df=3)
qqnorm(x, col = "red")
qqline(x)
# The same example
qqplot.das(x, "norm", col = palette()[2])
# The same example with qqplot 
qqplot(rt(1000,df=3), x,
       main="t(3) Q-Q Plot", 
       ylab="Sample Quantiles")
abline(0,1)

# Example
faithful
faithful$eruptions
qqnorm(faithful$eruptions)
qqline(faithful$eruptions)

?simple.eda

# Example - homedata
homedata
hist(homedata$y1970)
hist(homedata$y2000)
simple.eda(homedata$y1970)
simple.eda(homedata$y2000)
simple.eda(log(homedata$y1970[homedata$y1970>0]))
simple.eda(log(homedata$y2000[homedata$y2000>0]))

# Example - exec.pay
exec.pay
simple.eda(exec.pay)
simple.eda(log(exec.pay[exec.pay > 0]))


t1 = rbinom(5, 100, 0.5)
t1 = rbinom(15, 100, 0.5)
t1 = rbinom(50, 100, 0.5)
t1 = rbinom(1000, 100, 0.5)
t1 = rbinom(10000, 100, 0.5)

n = 100
p = 0.5
Sn = rbinom(500, n, p)
X = (Sn - n*p)/sqrt(n*p*(1-p));X
hist(X, probability = TRUE)
y = dnorm(seq(from = 0, to = 100, by = 0.1), mean = mean(X), sd = sd(X))
lines(seq(from = 0, to = 100, by = 0.1), y, col = "red", type = "l")

for(i in 1:5000) {
  t1 = rbinom(i, 100, 0.5)
  hist(t1)
}


