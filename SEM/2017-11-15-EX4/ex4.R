
# Прочетете данните и ги запишете в data frame в R;
library("UsingR")
pokemon = read.csv("pokemon.csv", header=TRUE)
pokemon
View(pokemon)

# Генерирайте си подизвадка от 600 наблюдения. За целта нека f_nr е
# вашият факултетен номер. Задайте състояние на генератора на слу-
# чайни числа в R чрез set.seed(f_nr). С помощта на подходяща фун-
# кция генерирайте извадка без връщане на числата от 1 до 705 като
# не забравяте да я запишете във вектор. Използвайте вектора, за да
# зашишете само редовете със съответните индекси в нов дейтафрейм и
# работете с него оттук нататък;
set.seed(61701)
?sample
length(pokemon)
dim(pokemon)
pokemon
random_numbers = sample(1:705, size = 600, replace=FALSE)
random_numbers = sample(1:nrow(pokemon), size = 600, replace=FALSE)
random_numbers
length(random_numbers)

filtered_pokemons = pokemon[random_numbers, ]
filtered_pokemons = pokemon[pokemon$Number %in% random_numbers, ]
filtered_pokemons
dim(filtered_pokemons)

# Изкарайте на екрана първите няколко (5-6) наблюдения;
random_numbers[1:6]
filtered_pokemons[1:6,]
head(filtered_pokemons, 6)

# Изведете дескриптивни статистики за всяка една от променливите;
names(filtered_pokemons)
summary(filtered_pokemons)
summary(filtered_pokemons$Name)

# Изведете редовете на най-високия и на най-лекия покемон;
filtered_pokemons$Weight
lightest_pokemon = min(filtered_pokemons$Weight)
lightest_pokemon
which(filtered_pokemons$Weight == lightest_pokemon)

filtered_pokemons$Height
highest_pokemon = max(filtered_pokemons$Height)
highest_pokemon
which(filtered_pokemons$Height == highest_pokemon)

which(filtered_pokemons$Height == highest_pokemon)

#Изведете редовете на покемоните с общ брой точки за атака и защита над 220;
filtered_pokemons[filtered_pokemons$Attack + filtered_pokemons$Defense > 220,]
nrow(filtered_pokemons[filtered_pokemons$Attack + filtered_pokemons$Defense > 220,])

# Колко на брой покемони имат първичен или вторичен тип "Dragon"или
# "Flying"и са високи над един метър?
nrow(filtered_pokemons[(filtered_pokemons$Type1 == "Dragon"
                        | filtered_pokemons$Type1 == "Flying"
                        | filtered_pokemons$Type2 == "Dragon"
                        | filtered_pokemons$Type2 == "Flying") 
                       & filtered_pokemons$Height > 1, ])

# Направете хистограма на теглото само на покемоните с вторичен тип
# и нанесете графика на плътността върху нея. Симетрично ли са раз-
# положени данните?
nrow(filtered_pokemons[filtered_pokemons$Type2 == "", ])
pokemons_for_histogram = filtered_pokemons[filtered_pokemons$Type2 != "", ]
pokemons_for_histogram
hist(pokemons_for_histogram$Weight)
hist(pokemons_for_histogram$Weight, probability=TRUE)
hist(scale(pokemons_for_histogram$Weight), probability=TRUE)
rug(jitter(pokemons_for_histogram$Weight))
?density
density(scale(pokemons_for_histogram$Weight))
lines(density(pokemons_for_histogram$Weight))
lines(density(pokemons_for_histogram$Weight, bw=1))
curve(density(scale(pokemons_for_histogram$Weight)))

# За покемоните с първичен тип "Normal"или "Fighting"изследвайте
# съвместно променливите Type1 и Height с подходящ графичен метод.
# Забелязвате ли outlier-и? Сравнете извадковите средни и медианите в
# двете групи и направете извод;
filtered_pokemons_nf = filtered_pokemons[(filtered_pokemons$Type1 == "Normal" | filtered_pokemons$Type1 == "Fighting"),]
#boxplot(filtered_pokemons$Height ~ filtered_pokemons$Type1)
boxplot(formula = filtered_pokemons_nf$Height ~ filtered_pokemons_nf$Type1, data=filtered_pokemons_nf)
#boxplot(formula = filtered_pokemons$Height ~ filtered_pokemons$Type1, data = filtered_pokemons)
#boxplot(filtered_pokemons_nf$Type1, filtered_pokemons_nf$Height)

# Изследвайте съвместно променливите Height и Weight с подходящ
# графичен метод. Бихте ли казали, че съществува линейна връзка меж-
# ду тях? Намерете корелацията между величините и коментирайте
# стойността `и. Начертайте регресионна права (линейната функция, ко-
# ято най-добре приближава функционалната зависимост). Ако е наб-
# людаван нов вид покемон с височина 2.1 метра, какво се очаква да е
# теглото му на базата на линейния модел?

plot(filtered_pokemons$Weight, filtered_pokemons$Height)
abline(lm(filtered_pokemons$Height ~ filtered_pokemons$Weight))
cor(filtered_pokemons$Height, filtered_pokemons$Weight)

plot(filtered_pokemons$Height, filtered_pokemons$Weight)
abline(lm(filtered_pokemons$Weight ~ filtered_pokemons$Height))
cor( filtered_pokemons$Weight, filtered_pokemons$Height)

simple.lm(filtered_pokemons$Height, filtered_pokemons$Weight)
simple.lm(filtered_pokemons$Weight, filtered_pokemons$Height)
?simple.lm

?xyplot
summary(lm(filtered_pokemons$Weight ~ filtered_pokemons$Height))

mpp4@abv.bg
