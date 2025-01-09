### Mtcars: Motor Trend Cars - Descriptive Analysis ###
##################  Oct 31  ###################
iris # print df on console
dim(iris) # dimensions
names(iris) # same as colnames
str(iris) # colnames, data types, unique values
head(iris, 2)
tail(iris, 5)
iris[1:3,] # get specific rows
iris$Sepal.Length[1:10] # get first 10 values of column
iris[1:10, "Sepal.Length"] # same as above
attributes(iris) # colnames, variable class (dataframe), rownames
summary(iris) # stats of columns: min, mean, max, 1st q, median, 3rd q
iris[,c(1,5)] # get specific columns
install.packages("Hmisc")
library(Hmisc) # Harell Miscellaneous library for stats
describe(iris) # more stats per col, with missing values & distincts
describe(iris[, c(1,5)]) # on specific cols
range(iris$Sepal.Length) # min & max of col
min(iris$Sepal.Length)
max(iris$Sepal.Length)
quantile(iris$Sepal.Length, c(0.1, 0.3, 0.65)) # specific q's on col

hist(iris$Sepal.Length) # plot histogram
var(iris$Sepal.Length) # variance of col
table(iris$Species) # count rows per value on specific col
pie(table(iris$Species)) # pieplot of unique values of col
barplot(table(iris$Species)) # barplot unique values of col
boxplot(iris$Sepal.Length) # boxplot of specific col
boxplot(iris$Petal.Length)
plot(iris$Sepal.Length) # scatterplot, 1 var vs index
plot(iris$Sepal.Length, iris$Petal.Length) # scatterplot 2 vars
plot(iris$Sepal.Length, iris$Petal.Length, col = iris$Species)  # scatterplot 2 vars and colors
pairs(iris) # scatterplot of every 2 cols combination

with(iris, # using 'with' to shorten declarations
     plot(Sepal.Length, Petal.Length, col=iris$Species))

with(iris, # pch = symbols
     plot(Sepal.Length, Petal.Length, col=iris$Species, pch=as.numeric(Species)))

data(presidential) # load predefined datasets
data(Titanic)
View(mtcars) # view dataset
attributes(mtcars)
dim(mtcars)
?mtcars # display help/documentation 

##################  Nov 7  ####################
str(mtcars)
head(mtcars)
tail(mtcars)
names(mtcars)
data() # list predefined datasets in R
View(mtcars)
install.packages('dplyr') # library for pipe operator and filtering
library('dplyr')

# pipeline operator %>%, filter dataset depending on col value
mtcars %>% 
  filter(mpg > 25)
mtcars %>% 
  filter(cyl >= 8)


# create new col based on rownames
rownames(mtcars)
mtcars2 <- mtcars # to modify the dataset copy
mtcars2$car_name <- rownames(mtcars2)
View(mtcars2)

# filter rows that match certain pattern on a column
mtcars2 %>% 
  filter(grepl('merc', ignore.case = TURE, car_name)) # grepl returns a T/F col when matching pattern

# add new column using mutate function 
mtcars_kmpl <- mtcars %>% 
 mutate(mpg_kmpl <- mpg * 0.425)
View(mtcars_kmpl)


# Group by # convert numeric to categorical
str(mtcars_kmpl)
mtcars_kmpl$am <- as.factor(mtcars_kmpl$am)
str(mtcars_kmpl)

# Find average weight of the cars ('wt' col), per value of transmission ('am' col)
mtcars_kmpl %>%
  group_by(am) %>% 
  summarise((mean(wt)))

install.packages("ggplot2")
library("ggplot2") # visualization library
?ggplot2

# plot a histogram of numeric col
ggplot(mtcars, aes(x=mpg)) +  # dataset, and x-y values (aes)
  geom_histogram(bins=10) + # type of plot with its params
  labs(x="Mileage") # axis labels, "count" when not specified

