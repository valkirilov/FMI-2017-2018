library(UsingR)
## Content:
# Точкови оценки
# Доверителни интервали
# confidence level (Ниво на доверие) = 0.95 или 0.99
# two-side conf interval
# one-side conf interval
# Proportion test - prop.test
# Mean
# z-test - simple.z.test
# t-test - t.test
# Median
# wilcox test - wilcox.test


## Confidence Interval Estimation (Доверителни интервали)

# Еstimate unknown parameters for a known distribution.

# Example:
# Your parent population is normal, but the mean is unknown, 
# or both the mean and standard deviation are unknown.
# From a data set you can't hope to know the exact values of the parameters,
# but the data should give you a good idea what they are.

# Statistical theory is based on knowing the sampling distribution of some statistic such as the mean.
# This allows us to make probability statements about the value of the parameters.
# Such as we are 95 percent certain the parameter is in some range of values.


## Population proportion theory

## Example:
# 100 people were surveyed and 42 of them liked brand X.

# p - population proportion
# p = number of successes / size of the population

# * random sample
# p_hat - sample proportion
# p_hat = number of successes in sample / size of the sample


# Example:
# I1, I2, ..., In - i.i.d.
# X = I1 + I2 + ... + In
# p_hat = X / n = (I1 + I2 + ... + In) / n 
# if n is large enough
# z = (p - p_hat)/sqrt(p(1-p)/n) = (x_bar - mu) / s/sqrt(n) = (x_bar - mu) / SE
# SE = sqrt(p(1-p)/n)

# z is in (-1, 1) with probability approximately 0.68
# z is in (-2, 2) with probability approximately 0.95
# z is in (-3, 3) with probability approximately 0.998

# This means
# On average 95% of the time the interval (p_hat-2SE, p_hat+2SE) contains the true value of p.
# 95% confidence level
# (1-alpha)100% confidence level.

alpha = c(0.2, 0.1, 0.05, 0.001)
zstar = qnorm(1 - alpha/2)
zstar
# Notice the value z* = 1.96 corresponds to alpha = 0.05 or a 95% confidence interval.

2*(1-pnorm(zstar))

# As n gets bigger we have more confidence.
# Because SE gets smaller

# If we want more confidence in our answer, we will need to have a bigger interval.
# smaller alpha leads to a bigger z*.

# Confidence interval isn't always right
m = 50; n = 20; p = 0.5; # toss 20 coins 50 times
phat = rbinom(m, n, p)/n # divide by n for proportions
SE = sqrt(phat*(1-phat)/n) # compute SE
alpha = 0.10
zstar = qnorm(1-alpha/2)
matplot(rbind(phat - zstar*SE, phat + zstar*SE),
        rbind(1:m, 1:m),
        type="l",
        lty=1)
abline(v=p) # draw line for p=0.5


## Proportion test
prop.test(42, 100, conf.level = 0.99)
# 42 out of 100
# 99% confidence level
# 99% confidence interval (0.297, 0.553)
prop.test(42, 100)
# 42 out of 100
# 95% confidence level
# 95% confidence interval (0.323, 0.522)
prop.test(42, 100, conf.level = 0.90)
# 42 out of 100
# 90% confidence level
# 90% confidence interval (0.337, 0.507)
prop.test(42, 100, conf.level = 0.85)
# 42 out of 100
# 85% confidence level
# 85% confidence interval (0.346, 0.496)

m = 4
x = c(0.297, 0.323, 0.337, 0.346)
y = c(0.553, 0.522, 0.507, 0.496)
matplot(rbind(x, y),
        rbind(1:m, 1:m),
        type="l",
        lty=1,
        lwd = 2,
        col = "darkblue")


## The z-test
# (x_bar - mu) / sigma/sqrt(n)
# sigma is known, and the Xi are normally distributed
# sigma is known, and n is large enough to apply the CLT.

# Example:
# Weights
x = c(175, 176, 173, 175, 174, 173, 173, 176, 173, 179)
sigma = 1.5
simple.z.test(x, 1.5)
# The same
simple.z.test = function(x,sigma,conf.level=0.95) {
  n = length(x);xbar=mean(x)
  alpha = 1 - conf.level
  zstar = qnorm(1-alpha/2)
  SE = sigma/sqrt(n)
  xbar + c(-zstar*SE,zstar*SE)
}
# 95% confidence interval that the mean of our wight is between 
# (173.7703, 175.6297)


## The t-test
# (x_bar - mu)/ s/sqrt(n)
# standard deviation is unknown
# sigma - population standard deviation
# s     - sample standard deviation

t.test(x)
x
# 95% confidence interval that the mean of our wight is between 
# (173.3076, 176.0924)


## Comparing p-values from t and z
x.norm = rnorm(100)
x.t = rt(100, 9)
boxplot(x.norm, x.t)
qqnorm(x.norm)
qqline(x.norm)
qqnorm(x.t)
qqline(x.t)
# larger variance of the t distribution
xvals=seq(-4, 4, 0.01)
plot(xvals, dnorm(xvals), type="l", lwd = 2, col = "red")
for(i in c(2, 5, 10, 20, 50)) 
  points(xvals, dt(xvals, df=i), type="l", lty=i)


## Confidence interval for the median - wilcox.test 

# Example
# Pay of CEO's in America in 2001 dollars
x = c(110, 12, 2.5, 98, 1017, 540, 54, 4.3, 150, 432)
wilcox.test(x, conf.int=TRUE)
# Confidence interval is enormous as the size of the sample is small and the range is huge.

# We needed to specify that we wanted a confidence interval computed.
# We couldn't have used a t-test as the data isn't normal.



#9.1
x = rnorm(150, 10, 5)
x
simple.z.test(x, 5, 0.95)
mean(x)
hist(x)
qqnorm(x)
qqline(x)

f=function () mean(rnorm(15, mean=10, sd=5))
xbar = simple.sim(100,f)
xbar
SE = 5/sqrt(15)
alpha = 0.05
zstar = qnorm(1- alpha/2)
sum(abs(xbar-10) < zstar*SE)
persentage = sum(abs(xbar-10) < zstar*SE) / 100; persentage

# 9.3

x = rnorm(150, 10, 5)
t.test(x)
mean(x)

# 9.4
exec.pay
boxplot(exec.pay)
mean(exec.pay)
median(exec.pay)
qqnorm(exec.pay)
qqline(exec.pay)
simple.z.test(exec.pay, var(exec.pay), 0.8)
simple.z.test(exec.pay, var(exec.pay), 0.95)
wilcox.test(exec.pay, conf.level = 0.8, conf.int = TRUE)
wilcox.test(exec.pay, conf.level = 0.95, conf.int = TRUE)

# 9.5
rat
?rat
hist(rat)
t.test(rat)
mean(rat)
median(rat)
var(rat)
sd(rat)
summary(rat)

# 9.6
puerto
summary(puerto)
t.test(puerto)
?t.test

# 9.7
malpract
summary(malpract)
boxplot(malpract)
hist(malpract)
simple.z.test(malpract, var(malpract), 0.9)
t.test(malpract)
wilcox.test(malpract, conf.level = 0.9, conf.int = TRUE)
