# 2017SIHW3

# Task 1
library(UsingR)
View(blood)
summary(blood)
boxplot(blood)
library(StatDA)
qqplot.das(blood$Machine, distribution = "norm", col = "green")
qqplot.das(blood$Machine, distribution = "exp", col = "green")
qqplot.das(blood$Machine, distribution = "binom", col = "green")
?qqplot.das
qqplot.das(blood$Expert, distribution = "norm", col = "green")
qqplot.das(blood$Expert, distribution = "exp", col = "green")

qqplot(blood$Machine)
qqnorm(blood$Machine)
qqline(blood$Machine)

# a) mu_diff = mu_Machine - mu_Expert
#    H0: mu_diff = 0
#    H1: mu_diff != 0
# б)
alpha = 0.1
qt(0.1, df=14)
qt(0.9, df=14)
# доверителен интервал (-1.76131, 1.76131)
# => K.O. е (-∞, -1.76131)∪(1.76131, +∞)

alpha = 0.05 # 0.025 / 0.975
# n-1
nrow(blood)
qt(0.025, df=14)
qt(0.975, df=14)
# в)
t.test(blood$Machine, blood$Expert, paired=TRUE, conf.level=0.9)
t.test(blood$Expert, blood$Machine, paired=TRUE, conf.level=0.9)
# p-value = 0.5066 > alpha = 0.1 => accept H0
# с доверителен интервал

# доверителен интервал за средно на разликите
mean(blood$Machine - blood$Expert) + qt(0.95, df = 14) * sd(blood$Machine - blood$Expert)/sqrt(15)
mean(blood$Machine - blood$Expert) - qt(0.95, df = 14) * sd(blood$Machine - blood$Expert)/sqrt(15)
# 0 се покрива от доверителния интервал за средното (-1.584017, 3.584017)
# приемаме H0

# тестовата статистика t = 0.68162 е в доверителния интервал (-1.76131, 1.76131)
# приемаме H0

# Task 2
head(brightness)
summary(brightness)
boxplot(brightness)
qqplot.das(brightness, distribution = "norm")

qqnorm(brightness)
qqline(brightness)
# а) Данните не са нормално разпределени, но тъй като те са много
#    можем да използваме централна гранична теорема.

# Можем да проверим графично, дали наблюдаваната величина е с крайна дисперсия.
# Тъй като кривата се стреми към успоредна на абсцисната ос, то наблюдаваната величина е с крайна дисперсия.
# Тогава можем да приложим Централната Гранична Теорема
s = 0
for (i in 1:length(brightness))
  s[i] = var(brightness[1:i])
plot(s)

# Тук нямаме зададена стойност с която да сравнявамe,за това
# да сравняваме с mu = 9
t.test(brightness, mu = 9)
# p-value < 2.2e-16 < alpha = 0.05 => reject H0
# Тук тъй като имаме много наблюдения, доверителния ни интервал е много тесен
# и всяка тестова стойност извън него ще бъде отхвърлена.

simple.z.test(brightness, sigma = sd(brightness))
# Ни дава доверителен интервал, много близък до този получен от t-test, защото
# имаме много наблюдения и следователно степените ни на свобода са много.

# б)
t.test(brightness, conf.level = 0.93)
# 8.342209 8.493277
simple.z.test(brightness, sigma = sd(brightness), conf.level = 0.93)
# 8.342293 8.493193

# Task 3
people = 1337
internet.every.day = 1000
internet.not.every.day = 337

prop.test(1000, 1337, p = 0.7, conf.level = 0.95, alternative = "greater")
?prop.test
# p-value = 7.364e-05 < alpha = 0.05 => reject H0

#  p = 0.7 не принадлежи на доверителния интервал (0.727541, 1.000000)

#t1

arrivals = rexp(500, 1/12) # Ex = 12

rand  = sample(1:500, 100, replace = FALSE); rand
a = arrivals[rand]; a

head(a)
a[1:5]

summary(a)
fivenum(a)

hist(a)

a[a > 10]
length(a[a > 10])
sum(a > 10)

?pexp
pexp(12, rate=1/12)
pexp(8, rate=1/12, lower.tail = FALSE)
1 - pexp(8, rate=1/12)
pexp(12, 1/12) - pexp(8, 1/12)

p = pexp(4, 1/12)
qexp(p + 0.18, 1/12)

#t2
people = 25
people.low = 5
people.high = 20

# H0: p >= 21%
# H1: p < 21

prop.test(5, 25, p=0.21, alternative = 'less')
# p-value=0.5 > a => Приемаме H0 следователно броят на хората е е повече от 21%. Също така принадлежи на доверителният интервал

# t3

# 46, 58, 94, 89, 64, 45, 92, 96, 100, 98, 82, 73, 78, 33, 58, 88, 86
# 58, 69, 60, 58, 69, 74, 34, 98, 78, 99, 99, 76, 69, 79, 56, 67, 78, 88, 91, 84, 87, 91

m = c(46, 58, 94, 89, 64, 45, 92, 96, 100, 98, 82, 73, 78, 33, 58, 88, 86)
f = c(58, 69, 60, 58, 69, 74, 34, 98, 78, 99, 99, 76, 69, 79, 56, 67, 78, 88, 91, 84, 87, 91)

qqplot(m, f)
t.test(m, f, var.equal = TRUE, conf.level = 0.95, alternative = "two.sided")

# 2016ISTestG2
III = 3
IV = 4
V = 5
# X ~ Exp(1/12)
# Task1
arrivals = rexp(500, 1/12)
# а) 
n = sample(1:500, 100, replace = FALSE)
A = arrivals[n]
# б) 
head(A)
# в)
summary(A)
# Min.    1st Qu.   Median   Mean     3rd Qu.   Max. 
# 0.1159  3.7740    7.2910   12.2900  14.5400   145.2000 
# г)
hist(A)
# д)
sum(A > 10)
length(A[A>10])
# е) P(X < 12)
pexp(12, rate = 1/12)
# 0.6321206
# P(X > 8)
pexp(8, rate = 1/12, lower.tail = FALSE)
# 0.5134171
# P(8 <= X <= 12)
pexp(12, rate = 1/12) - pexp(8, rate = 1/12)
# 0.1455377
# ж) P(4 < X < z) = 0, 18
p = pexp(4, rate = 1/12)
qexp(p + 0.18, rate = 1/12)
# 7.471564

# Task 2
people = 25
lower = 5
# H0: p = 0.21
# H1: p < 0.21
prop.test(5, 25, p = 0.21, alternative = "less" ,conf.level = 0.95)
# p-value = 0.5 > alpha = 0.05 => accept H0
# 0.21 принадлежи на доверителния интервал (0.000000, 0.368714)

# Task 3
man = c(46, 58, 94, 89, 64, 45, 92, 96, 100, 98, 82, 73, 78, 33, 58, 88, 86)
women = c(58, 69, 60, 58, 69, 74, 34, 98, 78, 99, 99, 76, 69, 79, 56, 67, 78, 88, 91, 84, 87, 91)
# a) var.equal = TRUE
#   H0: mu.man = mu.women
#   H1: mu. man != mu. women
t.test(man, women, var.equal = TRUE, conf.level = 0.95, alternative = "two.sided")
# p-value = 0.9666 > alpha = 0.05 => accept H0






