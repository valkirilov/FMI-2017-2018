
# Прочетете данните и ги запишете в data frame в R;
data = read.csv('train.csv', header=TRUE)
?data
View(data)

# Генерирайте си подизвадка от 500 наблюдения. За целта нека f_nr е
# вашият факултетен номер. Задайте състояние на генератора на слу-
#  чайни числа в R чрез set.seed(f_nr). С помощта на подходяща фун-
#  кция генерирайте извадка без връщане на числата от 1 до 891 като
# не забравяте да я запишете във вектор. Използвайте вектора, за да
# зашишете само редовете със съответните индекси в нов дейтафрейм и
# работете с него оттук нататък;

set.seed(61701)
?sample
rn = sample(1:891, size=500, replace=FALSE)
rn
filtered_data = data[rn,]
filtered_data
nrow(filtered_data)

#Изчистете данните: за нашите цели ще ни трябват само наблюдения,
#при които имаме информация за всяка от променливите, но не всеки
#пътник е споделил каква е възрастта му. Проверете в R какво пра-
#  ви функцията is.na и я използвайте върху променливата Age, за да
#извикате само редовете, където имаме наблюдения със записана въз-
#  раст. Запишете резултата в нов дейтафрейм и работете с него оттук
#нататък;
filtered_data = na.omit(filtered_data)

# Изкарайте на екрана първите няколко (5-6) наблюдения;
head(filtered_data)
?head
head(filtered_data, n=8)
tail(filtered_data)
filtered_data[1:6,]

#Какъв вид данни (качествени/количествени, непрекъснати/дискретни)
# са записани във всяка от променливите?
names(filtered_data)
factor(filtered_data$Name)
factor(filtered_data$Embarked)

#Survided -качествени
#Pclas -качествена
#Sex -качествена
#Age - количествена, непрекъсната
#SibSp -количествена, дискретна
#Parch - количествена, дискретна
#Fare - количествени, непрекъснати
#Cabin - качествени
#Embarked - качествени

# Изведете дескриптивни статистики за всяка една от променливите;
summary(filtered_data[1])
?fivenum
fivenum(filtered_data[1], na.rm=True)

# Изведете редовете на най-младия и най-стария пътник;
?is.na
data[min(filtered_data$Age, na.rm=TRUE),]
data[max(filtered_data$Age, na.rm=TRUE),]
maxAge = max(filtered_data$Age, na.rm=TRUE)
filtered_data[which(filtered_data$Age == maxAge),]
attach(filtered_data)
filtered_data[Age == maxAge,]

min(filtered_data$Age)
max(filtered_data$Age)

pokemon = read.csv('pokemon.csv', header=TRUE)
pokemon

filtered_pokemons_indexes = sample(1:705, 600, replace = FALSE)
filtered_pokemons = pokemon[filtered_pokemons_indexes, ]
filtered_pokemons
nrow(filtered_pokemons)

# Изведете редовете на покемоните с общ брой точки за атака и защита над 220;
attach(filtered_pokemons)
filtered_pokemons[Attack + Defense > 220,]

#Колко на брой покемони имат първичен или вторичен тип "Dragon"или
#"lying"и са високи над един метър?
nrow(filtered_pokemons[(Type1 == 'Dragon' | Type1 == 'Flying' | Type1 == 'Flying' | Type1 == 'Dragon') & Height > 1, ])

# Направете хистограма на теглото само на покемоните с вторичен тип
#и нанесете графика на плътността върху нея. Симетрично ли са раз-
#  положени данните?
fpst = filtered_pokemons[Type2 != "",]; fpst
hist(fpst$Height, probability = TRUE)
lines(density(fpst$Height, bw=5))
lines(density(fpst$Height, bw=3))
lines(density(fpst$Height, bw=1))
?density
?lines

# За покемоните с първичен тип "Normal"или "Fighting"изследвайте
# съвместно променливите Type1 и Height с подходящ графичен метод.
# Забелязвате ли outlier-и? Сравнете извадковите средни и медианите в
# двете групи и направете извод;

# boxplot/hist

fp = filtered_pokemons[Type1 == "Normal" | Type1 == "Flying",]
fp
hist(fp$Height ~ fp$Type1)
fp$Type1 = factor(fp$Type1)
boxplot(fp$Height ~ fp$Type1)

# Изследвайте съвместно променливите Height и Weight с подходящ
#графичен метод. Бихте ли казали, че съществува линейна връзка меж-
#  ду тях? Намерете корелацията между величините и коментирайте
#стойността `и. Начертайте регресионна права (линейната функция, ко-
#ято най-добре приближава функционалната зависимост). Ако е наб-
#  людаван нов вид покемон с височина 2.1 метра, какво се очаква да е
#теглото му на базата на линейния модел?

plot(fp$Weight ~ fp$Height)
abline(lm(fp$Weight ~ fp$Height))
cor(fp$Height, fp$Weight)

?lm
coef = lm(fp$Weight ~ fp$Height)
#interectp + fp$heihjt*2.1
w = coef$coefficients[1] + coef$coefficients[2] * 2.1
w
coef$coefficients[1]


#####
x = c(4, 14, 2, 9, 1, 10, 11, 7, 3, 13, 4, 14, 2, 9, 1, 10, 11, 7, 3, 12)
mean(x)
median(x)

# conf level (1-a)
#грешка от първи род - a
#грешка от втори род - b

#отвърляме h0 ако е в критичната област
#неотхвърляме h0 ако не е в критимната област

#p_value < a => reject H0
# p_value > a => accept H0

## qqnorm/qqline - п,оверкса за нормално разпределение, StatDA

# с,авнение на медиани от две извадки зависими помежду си - wilcox test(x, y, paired = TRUE)

# равни популации - var.equal

# ворамлно разпределени извади, зависими помужд си- сравнение на средно - t-test, paired=TRUE
# t-test - не знаем дисперсията на популацията
# z-test - известна дисперсия на популацията

# доверителен интервал за средно за извазка с рзавцмер над 30 - z-test/t-test

# генериране на 10 случайн числаq - runif/dunif

# генериране на 10 случайни биномни числа - rbinom
# намиране на 1-ти квантил - qbinom
# ве,оятност X < 10 = ? pbinom()
# P(X=x) dbinom()
# P(X < ?) = 10 qbinom