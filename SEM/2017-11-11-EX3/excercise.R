### Random Data

## I. Uniform distribution (Равномерно разпределение)



## Uniform discrete distribution (Дискретно равномерно разпределение)
# https://en.wikipedia.org/wiki/Discrete_uniform_distribution

?sample
# sample(x, size, replace = FALSE)

## Examples:
## Dice
sample(1:6, size = 10, replace = TRUE)

## Toss a coin
sample(c("H","T"), size = 10, replace = TRUE)

## Pick 6 of 49 (a lottery)
sample(1:49, size = 6)

## Pick a card
cards = paste(rep(c("A",2:10,"J","Q","K"), 4),
              c("H","D","S","C"))
sample(x = cards, size = 5)
?rep
# rep - replicates the values in x

## Roll 2 die
dice = as.vector(outer(1:6,1:6,paste))
dice
sample(x = dice, size = 5, replace = TRUE)
?outer
# outer - The product of the arrays X and Y is the array A with dimension c(dim(X), dim(Y))





## Uniform continuous distribution (Непрекъснато равномерно разпределение)
# https://en.wikipedia.org/wiki/Uniform_distribution_(continuous)
?runif
runif(1,min = 0,max = 2)
runif(5,min = 0,max = 2)

# You can see that every time it generates a new numbers
runif(5,min = 0,max = 2)
runif(5,min = 0,max = 2)
runif(5,min = 0,max = 2)
# But if you want to save your work and continue later or send it to a friend
# or you need someone to check it. It is usefull to always generate same random numbers.
## set.seed() - state for random number generation in R
?set.seed
set.seed(10)
runif(5,min = 0,max = 2)
set.seed(10)
runif(5,min = 0,max = 2)
set.seed(10)
runif(5,min = 0,max = 2)

x=runif(100)
x
hist(x,
     probability = TRUE,
     col = gray(.9),
     main = "Uniform on [0,1]")
## draw the density line
dunif(x, min = 0, max = 1) # Calculated by the formula 1/(max - min) inside the interval
curve(dunif(x, 0, 1),
      add = TRUE,
      col = 2)
?curve
# Draws a curve corresponding to a function over the interval [from, to].
?dunif
# density (плътност)
# dunif - gives the density
# dunif(x, min = 0, max = 1)
# distribution function (Функция на разпределение)
# punif - gives the distribution function
# punif(q, min = 0, max = 1, lower.tail = TRUE)
# Example
# X ~ Uniform(0,1)
# P(X < 0.2)
punif(0.2, 0, 1)
# P(X > 0.2)
punif(0.2, 0, 1, lower.tail = FALSE)
# quantile (Квантил)
# qunif - gives the quantile function 
# qunif(p, min = 0, max = 1, lower.tail = TRUE)
qunif(0.6, 0, 1)
# runif - generates random with uniform continuous distribution
# runif(n, min = 0, max = 1)

# Other example
x=runif(100, min = 0, max = 2)
hist(x,
     probability = TRUE,
     col = gray(.9),
     main = "Uniform on [0,1]")
## draw the density line
dunif(x, min = 0, max = 2) # Calculated by the formula 1/(max - min) inside the interval
# 1/(2 - 0) = 1/2 = 0.5
curve(dunif(x, 0, 2),
      add = TRUE,
      col = 2)





## Bernoulli distribution (Бернулиево разпределение)
# https://en.wikipedia.org/wiki/Bernoulli_distribution
# Bernoulli distribution, named after Swiss mathematician Jacob Bernoulli
# is the probability distribution of a random variable which takes 
# the value 1 with probability p
# and the value 0 with probability q=1-p
# Частен случай на Биномно разпределената случайна величина
## Binomial distribution (Биномно разпределение)
# https://en.wikipedia.org/wiki/Binomial_distribution
# The binomial distribution with parameters n and p is the discrete probability distribution
# of the number of successes in a sequence of n independent experiments.
# Нека имаме n независими опити, с вероятност за "Успех" при всеки от тях p.
# тогава X - боря на "Успехите" при тези n опита е биномно разпределена случайна величина
# X ~ Bi(n, p)
n=1 # Брой опити
p=0.5 # Вероятност за "Успех" при всеки опит
# Генерира едно число, което представлява
# Един опит с вероятност за "Успех" 0.5
rbinom(1, n, p) # Бернулиево разпределена сл. в.
# Генерира ни 10 числа, които са
# Биномно разпределени и всяка от тях представлява
# 1 опит с вероятност за "Успех" 0.5
rbinom(10, n, p) # Биномно разпределена сл.в.

n=10 
p=0.5
# Генерира едно число, което представлява
# 10 опита с вероятност за "Успех" 0.5
rbinom(1,n,p)
# Генерира пет числа, което представляват
# 10 опита с вероятност за "Успех" 0.5
rbinom(5,n,p)

# Example
# Генерира 100 числа, които представляват
# 5 опита с вероятност за "Успех" 0.25
n=5
p=0.25
x=rbinom(100, n, p) 
x
table(x)
hist(x)
hist(x, probability = TRUE)
# density (плътност)
# dbinom - gives the density
xvals=0:n
dbinom(xvals,n,p)
points(xvals, dbinom(xvals,n,p), type="h", lwd=3)
points(xvals, dbinom(xvals,n,p), type="p", lwd=3)
?points
# "h" for histogram-like vertical lines
# "p" for points
# "l" for lines
# "b" for both points and lines
# "c" for empty points joined by lines
# "o" for overplotted points and lines
# "s" and "S" for stair steps
points(xvals, dbinom(xvals,n,p), type="s", lwd=3)
# "n" does not produce any points or lines.

# Example
# Генерира 100 числа, които представляват
# 15 опита с вероятност за "Успех" 0.25
n=15
p=0.25
x=rbinom(100, n, p) 
table(x)
hist(x, probability = TRUE)
xvals=0:n
points(xvals, dbinom(xvals,n,p), type="h", lwd=3)
points(xvals, dbinom(xvals,n,p), type="p", lwd=3)
# Example
# Генерира 100 числа, които представляват
# 50 опита с вероятност за "Успех" 0.25
n=50
p=0.25
x=rbinom(100, n, p) 
table(x)
hist(x, probability = TRUE)
xvals=0:n
points(xvals, dbinom(xvals,n,p), type="h", lwd=3)
points(xvals, dbinom(xvals,n,p), type="p", lwd=3)

# density (плътност)
# dbinom - gives the density
n = 5
p = 0.25
xvals=0:n # seq(from = 0, to = n, by = 1)
y = dbinom(xvals, n, p)
plot(0:n, y, type = "s", col = "darkblue")
points(xvals, dbinom(xvals,n,p), type="h", lwd=3)
points(xvals, dbinom(xvals,n,p), type="p", lwd=3)

# density (плътност)
# dbinom - gives the density
# dbinom(x, size, prob)
# distribution function (Функция на разпределение)
# pbinom - gives the distribution function
# pbinom(q, size, prob, lower.tail = TRUE)
# Example
# X ~ Bi(5, 0.25)
# P(X < 0.75)
pbinom(2, 5, 0.3)
# P(X > 0.75)
pbinom(2, 5, 0.3, lower.tail = FALSE)
# quantile (Квантил)
# qbinom - gives the quantile function 
# qbinom(p, size, prob, lower.tail = TRUE)
# Example
qbinom(0.83, 5, 0.3)
qbinom(0.83, 5, 0.3, lower.tail = FALSE)
# rinom - generates random with uniform continuous distribution
# rbinom(n, size, prob)





## Geometric distribution (Геометрично разпределение)
# https://en.wikipedia.org/wiki/Geometric_distribution
# The probability distribution of the number Y = X − 1 of failures before the first success.
# Нека имаме независими повторения на един и същи опити, с вероятност за "Успех" при всеки от тях p.
# тогава X - броя на опитите до първия "Успех" е геометрично разпределена случайна величина
# X ~ Ge(p)
# https://stat.ethz.ch/R-manual/R-devel/library/stats/html/Geometric.html
# Частен случай на Отрицателно биномното разпределение
# dgeom(x, prob)
# pgeom(q, prob, lower.tail = TRUE)
# qgeom(p, prob, lower.tail = TRUE)
# rgeom(n, prob)
# Example
# Едно число, което представлява
# броя на опитите до първия "Успех",
# ако вероятността ни за успех при един опит е 0.2
rgeom (1, 0.2)
# Десет числа, които представляват
# броя на опитите до първия "Успех",
# ако вероятността ни за успех при един опит е 0.2
rgeom(10, 0.2)





# Negative binomial distribution (Отрицателно биномно разпределение)
# https://en.wikipedia.org/wiki/Negative_binomial_distribution
# Discrete probability distribution of the number of successes in a sequence of independent and identically distributed Bernoulli trials before a specified number of successes occurs
# Нека имаме независими повторения на един и същи опити, с вероятност за "Успех" при всеки от тях p.
# тогава X - броя на опитите до n-тия "Успех" е отрицателно биномно разпределена случайна величина
# X ~ NBi(n, p)
# https://stat.ethz.ch/R-manual/R-devel/library/stats/html/NegBinomial.html
# dnbinom(x, size, prob)
# pnbinom(q, size, prob, lower.tail = TRUE)
# qnbinom(p, size, prob, lower.tail = TRUE)
# rnbinom(n, size, prob)
# Example
# Едно число, което представлява
# броя на опитите до 5тия "Успех",
# ако вероятността ни за успех при един опит е 0.2
rnbinom(1, 5, 0.2)
# Десет числа, които представляват
# броя на опитите до 5тия "Успех",
# ако вероятността ни за успех при един опит е 0.2
rnbinom(10, 5, 0.2)




# Hypergeometric distribution (Хипергеометрично разпределение)
# https://en.wikipedia.org/wiki/Hypergeometric_distribution
# https://stat.ethz.ch/R-manual/R-devel/library/stats/html/Hypergeometric.html
# Зависими опити
# X ~ HG(m, n, k) 
# m - the number of white balls in the urn
# n - the number of black balls in the urn
# k - the number of balls drawn from the urn.
# dhyper(x, m, n, k)
# phyper(q, m, n, k, lower.tail = TRUE)
# qhyper(p, m, n, k, lower.tail = TRUE)
# rhyper(nn, m, n, k)
# Example
# Едно число, което представлява
# броя на извадените бели топки от урната,
# при условие, че в урната е имало
# 10 бели
# 12 черни
# и сме изтеглили 15 топки
rhyper(1, 10, 12, 15)
# Десет число, което представлява
# броя на извадените бели топки от урната,
# при условие, че в урната е имало
# 10 бели
# 12 черни
# и сме изтеглили 15 топки
rhyper(10, 10, 12, 15)






# Poisson distribution (Поасоново разпределение)
# https://en.wikipedia.org/wiki/Poisson_distribution
# named after French mathematician Siméon Denis Poisson,
# is a discrete probability distribution that expresses 
# the probability of a given number of events occurring in a fixed interval of time or space
# if these events occur with a known constant rate and independently of the time since the last event.
# X ~ Po(lambda)
# https://stat.ethz.ch/R-manual/R-devel/library/stats/html/Poisson.html
# dpois(x, lambda)
# ppois(q, lambda, lower.tail = TRUE)
# qpois(p, lambda, lower.tail = TRUE)
# rpois(n, lambda)





## Normal distribution (Нормално разпределение)
# https://en.wikipedia.org/wiki/Normal_distribution
# https://stat.ethz.ch/R-manual/R-devel/library/stats/html/Normal.html
rnorm(1, mean = 100, sd = 16)
rnorm(1, mean = 280, sd = 10)

x=rnorm(100)
hist(x,probability=TRUE,col=gray(.9),main="normal mu=0,sigma=1")
curve(dnorm(x),add=T)




# z scores
x = rnorm(5,100,16);x
z = (x-100)/16;z




## Student's t-distribution (t разпределение)
# https://en.wikipedia.org/wiki/Student%27s_t-distribution
# https://stat.ethz.ch/R-manual/R-devel/library/stats/html/TDist.html







## Chi-squared distribution (Хи квадрат разпределение)
# https://en.wikipedia.org/wiki/Chi-squared_distribution
# https://stat.ethz.ch/R-manual/R-devel/library/stats/html/Chisquare.html
# Ако X1 ,X2, …X, n са независими, еднакво стандартно нормално разпределени
# случайни величини, то сумата от квадратите им 
# X1^2+X2^2+..+Xn^2 ~ X^2(n)





## Exponential distribution (Експоненциално разпределение)
# https://en.wikipedia.org/wiki/Exponential_distribution
# https://stat.ethz.ch/R-manual/R-devel/library/stats/html/Exponential.html
x=rexp(100,1/2500)
hist(x,probability=TRUE,col=gray(.9),main="exponential mean=2500")
curve(dexp(x,1/2500),add=T)







# A bootstrap sample
faithful
names(faithful)
sample(faithful$eruptions,10,replace=TRUE)
hist(faithful$eruptions,breaks=25) # the dataset
hist(sample(faithful$eruptions,100,replace=TRUE),breaks=25)

# r,p,q and d functions
pnorm(0.7)
pnorm(0.7,1,1)
pnorm(0.7,lower.tail=FALSE)
qnorm(0.75)

# 6.1
x = runif(10, min=0, max=10); x
min(x)
max(x)

# 6.2
x = rnorm(10, 5, 5); x
sum(x < 0)

# 6.3
x = rnorm(100, 100, 10); x
#sum(x > )

# 6.4

# 6.7
qnorm(0.05, 0, 1)
