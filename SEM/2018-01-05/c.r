## Chi Squared Goodness of Fit Tests

#This approach consists of four steps: 
# (1) state the hypotheses 
# (2) formulate an analysis plan
# (3) analyze sample data
# (4) interpret results.

## State the Hypotheses
# H0: The data are consistent with a specified distribution.
# H1: The data are not consistent with a specified distribution.

# H0 - specifies the proportion of observations at each level of the categorical variable.
# H1 - is at least one of the specified proportions is not true

## Formulate an Analysis Plan
# Describes how to use sample data to accept or reject the null hypothesis.
# Significance level
# Use to determine whether observed sample frequencies differ significantly from 
# expected frequencies specified in the null hypothesis. 

## Analyze Sample Data
# Using sample data, find the 
# - degrees of freedom = number of levels (k) of the categorical variable - 1.
#     DF = k - 1
# - expected frequency counts at each level of the categorical variable =
#           the sample size (n) * the hypothesized proportion from the null hypothesis (pi)
#     ei = npi
# - test statistic
#     Χ2 = Σ [ (fi - ei)2 / ei ]
#           fi - the observed frequency count for the ith level of the categorical variable
#           ei - the expected frequency count for the ith level of the categorical variable.
# - P-value -  probability of observing a sample statistic as extreme as the test statistic

## Interpret Results
# Compare the P-value and the significance level
# p-value < alpha => reject H0

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

## (1) State the hypotheses
# H0: The proportion of rookies, veterans, and All-Stars is 30%, 60% and 10%, respectively.
# H1: At least one of the proportions in the null hypothesis is false.
## (2) Formulate an analysis plan
# significance level is 0.05.
## (3) Analyze sample data
# degrees of freedom 
#     DF = k - 1 = 3 - 1 = 2
#     k - number of levels of the categorical variable
# expected frequency counts for level i
#     ei = n * pi
#     n - number of observations in the sample
#     e1 = 100 * 0.30 = 30
#     e2 = 100 * 0.60 = 60
#     e3 = 100 * 0.10 = 10
# chi-square test statistic
#     fi - observed frequency count for level i
#     f1 = 50
#     f2 = 45
#     f3 = 5
#  Χ^2 = Σ [ (fi - ei)^2 / ei ] 
#  Χ^2 = [(50 - 30)^2 / 30] + [(45 - 60)^2 / 60] + [(5 - 10)^2 / 10] =
#      = [20^2 / 30] + [(-15)^2 / 60] + [(-5)^2 / 10] = 
#      = 400/30 + 225/60 + 25/10 = 
#      = 13.33 + 3.75 + 2.50 =
#      = 19.58
# p-vale - probability that a chi-square statistic having 2 degrees of freedom
#          is more extreme than 19.58
# X^2~X^2(2)
# P(Χ^2 > 19.58) = 0.0001
## (4) Interpret results
# p-value = 0.0001 < alpha = 0.05 => we cannot accept H0

cards.freq = c(50, 45, 5)/100
probs = c(30, 60, 10)/100
chisq.test(cards.freq, p = probs)
# p-value = 0.9067 > alpha = 0.05 => accept H0











