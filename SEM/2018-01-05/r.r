## Chi Square Tests
# test of categorical data

## Chi Square Distribution
# Distribution of the sum of squared normal random variables.
# Zi ~ N(0,1) i.i.d.
# X^2 = Z1^2 + Z2^2 + ... + Zn^2
# X^2 ~ X^2(n) #n - degrees of freedom

# The shape of the distribution depends upon the degrees of freedom
library(UsingR)
x = rchisq(100, 5)
simple.eda(x)
y = rchisq(100, 50)
simple.eda(y)
# For a small number of degrees of freedom it is very skewed.
# As the number gets large the distribution begins to  look normal.

## Chi Squared Goodness of Fit Tests
# http://stattrek.com/chi-square-test/goodness-of-fit.aspx?Tutorial=AP
# Checks to see if the data came from some specified population.
# Test if categorical data corresponds to a model 
# where the data is chosen from the categories according to some
# specified set of probabilities.

## Example: Dice rolling
# Is the die fair?
# Toss a die 150 times
# We expect each face to have about 25 appearances.
# We look at how far off the data is from the expected.
# fi - frequency of category i
# ei - expected count of category i
# X^2 =sum((fi - ei)^2/ei)
# X^2 is large if there is a big discrepancy between the actual frequencies and the expected frequencies
# For X^2 test
# - data must be independent
# - expected counts isn,t smaller than 1
# - expected counts are bigger than 5
# X^2 ~ X^2(n - 1)
# H0: each category i has probability pi = 1/6
# H1: at least one category doesn't have this specified probability.
X.freq = c(22, 21, 22, 27, 22, 36)
probs = c(1, 1, 1, 1, 1, 1)/6
chisq.test(X.freq, p = probs)
# p-value = 0.2423 > alpha = 0.05 => accept H0 (hypothesis that the die is fair)
Y = sample(1:6, 150, replace = TRUE)
Y.freq = table(Y);Y.freq
probs = c(1, 1, 1, 1, 1, 1)/6
chisq.test(Y.freq, p = probs)
# p-value = 0.48 > alpha = 0.05 => accept H0 (hypothesis that the die is fair)
Z = sample(1:6, 150, replace = TRUE, prob = c(0.5, 0.5, 1, 1, 1, 2)/6)
Z.freq = table(Z); Z.freq
probs = c(1, 1, 1, 1, 1, 1)/6
chisq.test(Z.freq, p = probs)
# p-value = 0.00000003627 < alpha = 0.05 => reject H0 (hypothesis that the die is fair)

## Example: Letter distribution
# 5 most popular letters in the English language are:
#    freq.
# E - 29
# T - 21
# N - 17
# R - 17
# O - 16
# On average 29 times out of 100 it is an E and not the other 4.
# A text is analyzed and the number of E,T,N,R and O's are counted.
#    freq.
# E - 100
# T - 110
# N - 80
# R - 55
# O - 14
# Is this text from the English language?
# H0: pE = 0.29, pT = 0.21, pN = 0.17, pR = 0.17, pO = 0.16
# H1: at least one category doesn't have this specified probability.
#! chi-squared test require independence of each letter, so this is not quite appropriate, but lets suppose the letters are independent.
text.freq = c(100, 110, 80, 55, 14)
probs = c(29, 21, 17, 17, 16)/100
chisq.test(text.freq, p = probs)
# p-value = 0.00000000002685 < alpha = 0.05 => reject H0 (hypothesis that this text is from the English language)

# ex
text.freq = c(124, 90, 55, 59, 70)
probs = c(29, 21, 17, 17, 16)/100
chisq.test(text.freq, p = probs)

text.freq = c(20, 11, 12, 6, 8)/145
probs = c(29, 21, 17, 17, 16)/100
chisq.test(text.freq, p = probs)

# Take some part from Verzani and calculate the number of appearances of E, T, N, R, O and the number of characters
# You can use this site http://www.countcalculate.com/everyday-life/count-characters-and-words-in-text
# characters - 302
# E - 38
# T - 42
# N - 15
# R - 20
# O - 20
text.Verzani.freq = c(38, 42, 15, 20, 20)/302
probs = c(29, 21, 17, 17, 16)/100
chisq.test(text.Verzani.freq, p = probs)
# p-value = 0.99 > alpha = 0.05 => accept H0 (hypothesis that this text is from the English language)

## Example: 
# Company printed baseball cards.
# It claimed that 30% of its cards were rookies;
# 60% were veterans but not All-Stars;
# and 10% were veteran All-Stars.
# Random sample is taken of 100 cards: 
# - 50 rookies
# - 45 veterans
# - 5 All-Stars.
# See whether our sample distribution differed significantly from
# the distribution claimed by the company?
# Use a 0.05 level of significance.
cards.freq = c(50, 45, 5)/100
probs = c(30, 60, 10)/100
chisq.test(cards.freq, p = probs)
# p-value = 0.9067 > alpha = 0.05 => accept H0

## Chi Squared tests of independence
# http://stattrek.com/chi-square-test/independence.aspx?Tutorial=AP
# If two rows are "independent"
# H0: rows are independent
# H1: rows are not independent

# Example: car crush
#                Injury Level
#            None  minimal  minor major
# yes belt  12813      647    359    42
# no belt   65963     4000   2642   303
# Are the two rows independent?
# Does the seat belt make a difference?
yesbelt = c(12813, 647, 359, 42)
nobelt = c(65963, 4000, 2642, 303)
chisq.test(data.frame(yesbelt, nobelt))
# p-value = 0.000000000000861 < alpha = 0.05 => reject H0(rows are independent)

## Example
# Make the example from th link

## Chi Squared tests for homogeneity
# http://stattrek.com/chi-square-test/homogeneity.aspx?Tutorial=AP
# Tests to see if the  rows come from the same distribution.
# H0: Both sets of data come from the same distribution
# H1: don't come from the same distribuion

# Example: Roll a die
# roll fair die 200 times
# roll biased die 100 times
die.fair = sample(1:6, 200, prob = c(1, 1, 1, 1, 1, 1)/6, replace = TRUE)
die.fair
die.bias = sample(1:6, 100, prob = c(0.5, 0.5, 1, 1, 1, 2)/6, replace=TRUE)
fair.freq = table(die.fair);die.fair.freq
bias.freq = table(die.bias); die.bias.freq
freq = rbind(fair.freq, bias.freq)
# we assume that the two rows of numbers are from the same distribution
# Marginal total is (26 + 4)/300 = 30/300 = 1/10.
# So we expect      200(1/10) = 20.
# And we had 26.
# X^2 = sum((fi - ei)^2/ei)
# df = (number of rows - 1)(number of columns - 1)
# df = (2 - 1)(6 - 1) = 5
chisq.test(freq)
# p-value = 0.0008005 < alpha = 0.05 => reject H0 (Both sets of data come from the same distribuion)

## Example: make the example from the link

boys = c(50, 30, 20)
girls = c(50, 80, 70)
chisq.test(data.frame(boys, girls))
# p-value < 0.05 => reject H0

male = c(200, 150, 50)
female = c(250, 300, 50)
chisq.test(data.frame(male, female))
# p-value < 0.05 => reject H0

## Example:
# take two texts and check if they come from the same language

## Problems:

## 12.1
nonblock = c(18, 15, 5, 8, 4)
block = c(10, 5, 7, 18, 10)
chisq.test(data.frame(nonblock, block))
# p-value = 0.007179 < 0.05 => reject H0

nonblock = sample(1:5, 200, prob = c(18, 15, 5, 8, 4)/(18+15+5+8+4), replace = TRUE)
block = sample(1:5, 100, prob = c(10, 5, 7, 18, 10)/(10+5+7+18+10), replace=TRUE)
nonblock = table(nonblock);
block = table(block);
freq = rbind(block.freq, block.freq)

## 12.2
u18 = c(67, 10, 5)
b1825 = c(42, 6, 5)
b2640 = c(75, 8, 4)
b4065 = c(56, 4, 6)
o65 = c(57, 15, 1)
chisq.test(data.frame(u18, b1825, b2640, b4065, o65))
# p-value = 0.12 > 0.05 => accept H0

## 12.3
fish.freq = c(53, 22, 49)/124
probs = c(5/12, 3/12, 4/12)
chisq.test(fish.freq, p = probs)
# p-value = 0.9837 > 0.05 => accept H0

## 12.4

data(UCBAdmissions)
x = ftable(UCBAdmissions)
x
y = x[1:2,]
y
chisq.test(y)
