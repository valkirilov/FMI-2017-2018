# W A S D
# 1 1 1 1

# Ex2

# а) P(W + 5 > X ≥ min{2, A}) за сл. в. X ∼ Ge((S + D + 9)/90);
# P(6 > X > min{2, 1}); X~Ge(11/90)
# P(1<=x<6); [1; 6) =? 0]
# P(1<=x<=5)
# P(x<=5) - P(X<=0
# В дискретни разпределения равенството има значение

x1 = pgeom(5, 11/90); x1 # lower.tail=TRUE (<=); FALSE: > (за интервала надясно от квантила)
x2 = pgeom(0, 11/90); x2
x = x1 - x2; x


# Exp X~Exp(y)
# P(6>x>=1) - равенството няма значение, при непрекъснати 
#P(x<6) - P(X<1)

# б) P(min{3, A} < Y ≤ W + 4) за сл. в. Y ∼ P o(D + 1.5);
# P(min{3, 1}) < Y <= 5 за Y~Po(2.5)
# P(1 < Y <= 5) (2,5] => 0]
# P(Y<=2) - P(x<=2)

y1 = ppois(5, 2.5); y1
y2 = ppois(2, 2.5); y2
y = y1 - y2; y

# P - Probability ppois, pnorm, pgeom, pbinom, pchisq, pt, unif, exp, rhiper
# D - Density
# R - random
# Q - Quntile 

#в) стойността z∗, така че P(−z∗ < Z ≤ z∗) = (W + A + S + D + 11)/111 за
#сл. в. Z ∼ N(0, 1). Съвет: Изчислете кой квантил на Z е z∗
# P(-z* < Z <= z*) = 15/111; Z~Norm(0,1)

# (1 - 15/111)/2 или 0.5 + 15/222
q = qnorm((1 - 15/111)/2, 0, 1); q

#г) стойността x, така чe P(−1.5 < T ≤ x) = (55 + W + A)/100 за T ∼ t(33).
#Изчислете кой квантил на T е x.
#P(-1.5 < T < x) = 57/100; T~t(33)

p = pt(-1.5, 33); p
pall = p + 57/100; pall
q = qt(pall, 33); q

p1 = pnorm(-1.5, 0, 34); p1
pall1 = p + 57/100; pall1
q1 = qnorm(pall1, 0, 34)

a = c(1,2,3)
a[1]

?t.test
runif(10, 1, 5)

?dnorm
plot(function(x) dnorm(x, 0, 1), -10, 10)
?plot
?qqplot
