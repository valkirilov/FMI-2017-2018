## Two-sample tests
# match one sample against another


## Two-sample tests of proportion
# Example: A survey is taken two times over the course of two weeks.
# The pollsters wish to see if there is a diference in
# the results as there has been a new advertising campaign run.
#             Week1 Week2
# Favorable  : 45    56
# Unfavorable: 35    47
# Ho: p1  = p2
# H1: p1 != p2
prop.test(c(45, 56), c(45+35, 56+47))
# p-value = 0.9172 > alpha = 0.05
# accept Ho that p1 = p2

# Example: 
# https://onlinecourses.science.psu.edu/stat414/node/268
# "Should the federal tax on cigarettes be raised to pay for health care reform?"
#      Non-Smokers Smokers
# Yes :     351       41
# No  :     254      154
# p1 - the proportion of the non-smoker population who reply "yes"
# p2 - the proportion of the smoker population who reply "yes,"
# H0: p1  = p2
# H1: p1 != p2
n1 = 351 + 254
p1_hat = 351/n1; p1_hat
n2 = 41 + 154
p2_hat = 41/n2; p2_hat
p_hat = (41 + 351)/(n1 + n2);p_hat
z = ((p1_hat - p2_hat) - 0)/sqrt(p_hat*(1 - p_hat)*(1/n1 + 1/n2));z
# z = 8.99
# rejection region approach
alpha = 0.05
alpha/2
qnorm(0.025, 0, 1)
# -1.96
qnorm(1-0.025, 0, 1)
# 1.96
# We reject H0 if Z ≥ 1.96 or if Z ≤ −1.96
# z = 8.99 is much greater than 1.96
# reject Ho
# p-value approach
pnorm(z, 0, 1, lower.tail = FALSE)
# p-value = 0.0000000000000000001283
# alpha = 0.05
# p-value < alpha => reject Ho
prop.test(c(351, 41), c(351+254, 41+154))
# p-value = 0.0000000000000001 < alpha = 0.05
# reject Ho

########################################################################
# Xi ~ N(m1, sigma1^2)
# Yi ~ N(m2, sigma2^2)
# =>
# Xn1_bar ~ N(m1, sigma1^2/n1)
# Yn2_bar ~ N(m2, sigma2^2/n2)
# more info:
# E((x1+x2+...+xn)/n) = 1/n*(Ex1+...+Exn) = 1/n*n*Ex1 = Ex1
# D((x1+x2+...+xn)/n) = 1/(n^2)*(Dx1+...+Dxn) = 1/(n^2)*n*Dx1 = Dx1/n
# =>
# Xn1_bar - Yn1_bar ~ N(m1-m2, (sigma1^2)/n1+(sigma2^2)/n2)
# independent:
# I case  : sigma1, sigma2 known 
# II case : sigma1, sigma2 unknown, but equal
# III case: sigma1, sigma2 unknown
# dependent:
# IV case :

# Icase: sigma1, sigma2 known
# (Xn1_bar - Yn2_bar - (mu1 - mu2))/sqrt((sigma1^2)/n1+(sigma2^2)/n2) ~ N(0, 1)
# II case : sigma1, sigma2 unknown, but equal
# (Xn1_bar - Yn2_bar - (mu1 - mu2))/sqrt(((n1-1)*(sigman1^2)+(n2-1)(sigman2^2))/(n1+n2-2)*(1/n1+1/n2)) ~ t(n1+n2-2)
# III case: sigma1, sigma2 unknown
# (Xn1_bar - Yn2_bar - (mu1 - mu2))/sqrt((sigma1^2)/n1+(sigma2^2)/n2) ~ t((((Sn1^2)/n1+(Sn2^2)/n2)^2)/((((Sn1^2)/n1)^2)/(n1-1)+(((Sn2^2)/n2)^2)/(n2-1)))
########################################################################################################################################################

## Two-sample t-test (for the mean)
# When data was appoximately normal
# sigma was unknown
# H0: mu1  = mu2
# H1: mu1 != mu2


## Equal variances (case II)
# Example: recovery time for patients taking a new drug
with_drug = c(15, 10, 13, 7, 9,  8, 21, 9,  14,  8)
placebo   = c(15, 14, 12, 8, 14, 7, 16, 10, 15, 12)
# equal variances
# Ho: mu1 = mu2
# H1: mu1 < mu2
t.test(with_drug, placebo, alternative = "less", var.equal = TRUE)
# p-value = 0.3002 > alpha = 0.05 => accept H0 that mu1 = mu2


## Unequal variance (case III)
t.test(with_drug, placebo, alt="less")
# The result are slightly dfferent
# p-value = 0.3006 > alpha = 0.05 => accept H0 that mu1 = mu2


## Matched samples (case IV)
# Matched or paired t-test
# Yi = Xi + ei
# subtracts the X's from the Y 's and then performs a regular one-sample t-test.

# Example: each application was graded twice by diferent graders.
# Grader 1: 3 0 5 2 5 5 5 4 4 5
# Grader 2: 2 1 4 1 4 3 3 2 3 5
# data are not independent of each other as grader1 and grader2 each grade the same papers.
grader1 = c(3, 0, 5, 2, 5, 5, 5, 4, 4, 5)
grader2 = c(2, 1, 4, 1, 4, 3, 3, 2, 3, 5)
# check the assumption of normality
qqnorm(grader1)
qqline(grader1)
qqnorm(grader2)
qqline(grader2)
install.packages(StatDA)
library(StatDA)
qqplot.das(grader1, "norm", col = 3)
qqplot.das(grader2, "norm", col = 3)
# => normaly distributed
# perform the test
# Ho: mu1 - mu2  = 0
# H1: mu1 - mu2 != 0
t.test(grader1, grader2, paired = TRUE)
# p-value = 0.008468 < alpha = 0.05 => reject H0

# Ho: mu1 - mu2 = 0
# H1: mu1 - mu2 < 0
t.test(grader1, grader2, paired = TRUE, alternative = "less")
# p-value = 0.9958 > alpha = 0.05 => accept H0

# Ho: mu1 - mu2 = 0
# H1: mu1 - mu2 > 0
t.test(grader1, grader2, paired = TRUE, alternative = "greater")
# p-value = 0.004234 < alpha = 0.05 => reject H0


# Resistant two-sample tests (for the median)
# wilcox.test
# Example: compare taxi out times at Newark airport for American and Northwest Airlines.
library(UsingR)
head(ewr)
ewr_out = subset(ewr, inorout == "out", select = c("AA","NW"))
head(ewr_out)
ewr_AA  = ewr_out$AA; ewr_AA
ewr_NW  = ewr_out$NW; ewr_NW
boxplot(ewr_AA, ewr_NW)
# perform the test
# HO: Me(ewr_AA)  = Me(ewr_NW)
# H1: Me(ewr_AA) != Me(ewr_NW)
wilcox.test(ewr_AA, ewr_NW)
# p-value = 0.00001736 < alpha = 0.05 => reject H0

#1
homework
?homework
View(homework)
head(homework)
summary(homework)

qqnorm(homework$Private)
qqline(homework$Private)
qqnorm(homework$Public)
qqline(homework$Public)

library(StatDA)
qqplot.das(homework$Private, "norm")
qqplot.das(homework$Public, "norm")

boxplot(homework, horizontal = TRUE)

t.test(homework$Private, homework$Public, paired = FALSE, var.equal = FALSE)


#2 

corn
?corn
summary(corn)
qqplot.das(corn$New)
qqplot.das(corn$Standard)
t.test(corn$New, corn$Standard)
t.test(corn$New, corn$Standard, paired = TRUE)
t.test(corn$New, corn$Standard, paired = TRUE, alternative = "greater")
t.test(corn$New, corn$Standard, paired = TRUE, alternative = "less")

#3

blood