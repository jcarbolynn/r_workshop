setwd("~/joelle/r_workshop_2024")

# ------------------------------------------------------------------------
# CLASS ONE:
# this is a string
name <- "Joelle"
age <- 26

# what is the difference between my_vector and my_list?
my_vector <- c(1,4,"hello", TRUE)
str(my_vector)
my_list <- list(1,4,"hello", TRUE)
str(my_list)

my_bool <- TRUE
my_bool

5+5
my_int <- 5
my_int + my_int
my_int + your_int
# was there an issue running the code above?

# try more examples of using R as a calculator: + - * /
# what does sqrt() do?
sqrt(9)
# can you figure out how to square a number? (hint: don't just do 3*3)

# is this a whole number?
2374267/4
# you can round numbers
round(2374267/4)

# modulo operator (%) shows the remainder after division
5 %% 2
# can you find 3 other operations to do using R? google it!
# hint: think of ways you combine or adjust numbers

# you can do math on vectors too
# R will apply the same calculation to the entire vector
ages <- c(18, 17, 17, 21, 20, 23, 20)
ages_next_yr <- ages + 1
ages_next_yr

# does the same thing work on dataframes?
super_sleepers + 2
# use $ to choose just one column
super_sleepers$rating + 2

# do you remember the difference between dataframes and matrices?
sleeper_nums <- data.frame(rating=1:4,
                           avg_sleep_hours=c(21, 18, 17, 10))
sleeper_nums + 2
sleeper_nums
# I didn't use the assignment operator so everything I did is gone
# now let's create a new dataframe
plus2_sleeper_nums <- sleeper_nums + 2
plus2_sleeper_nums
# now I have saved my changes

super_sleepers <- data.frame(rating=1:4,
                             animal=c('koala', 'hedgehog', 'sloth', 'panda'),
                             country=c('Australia', 'Italy', 'Peru', 'China'),
                             avg_sleep_hours=c(21, 18, 17, 10))
str(super_sleepers)
print(super_sleepers)

# R has some built in data including the iris dataframe
# can you find other built in dataframes?
tail(iris, 10)

# practice running lines of code
# add comments wherever you need clarification
# bonus: can you find the keyboard shortcut to turn a line into a comment?
# practice investigating variables! use str() or TWO other ways to look at a data type
# practice printing variables out to see what is represented

# run this code and preview our lesson on graphs
speciesID <- as.numeric(iris$Species)
plot(iris$Petal.Length, iris$Petal.Width, pch = speciesID, col = speciesID)
legend("topleft", # specify the location of the legend
       levels(iris$Species), # specify the levels of species
       pch = 1:3, # specify three symbols used for the three species
       col = 1:3 # specify three colors for the three species
) 

# ------------------------------------------------------------------------
# CLASS TWO: making graphs (boxplots, histograms, barplots, linegraphs)

# install ggplot2
install.packages("ggplot2")
# load the package
library(ggplot2)

setwd("~/joelle/r_workshop_2024")
# load the example data, if you have set the working directory to the same location as your data you can just use the file name
ric_weather <- read.csv("richmond 2020-01-01 to 2021-12-31.csv")
# look at your data
View(ric_weather)
# lets look at the structure of the data
str(ric_weather)

# BASE R GRAPHS:
# make a histogram of max temps using base R
hist(ric_weather$tempmax)

# make boxplot of max temps
boxplot(ric_weather$tempmax)

# make barplot of max temps, only first 10 rows
barplot(ric_weather[1:10, "tempmax"])
# look at the data the barplot is using
ric_weather[1:10, "tempmax"]
head(ric_weather, 10)

# make line graph
library(lubridate)
plot(lubridate::day(ric_weather[1:10, "datetime"]), ric_weather[1:10, "tempmax"])
# now add some titles and change appearance of line:
plot(lubridate::day(ric_weather[1:10, "datetime"]), ric_weather[1:10, "tempmax"],
     xlab = "Day", ylab = "Temperature (F)", main = "Temperature by Day",
     type = "b", pch = 18, col = "blue", lty = 5)
# to understand what options you have you can
# run ? with the function you are using to see more information 
?plot
?points
# try changing various parts of the plot to see what changes and how:
plot(lubridate::day(ric_weather[1:10, "datetime"]), ric_weather[1:10, "tempmax"],
     xlab = "Day", ylab = "Temperature (F)", main = "Temperature by Day",
     type = "", pch = , col = "", lty = )

# make scatterplot of max temps and min temps
plot(ric_weather$tempmax, ric_weather$tempmin)
# try making changes to the scatterplot, hint: start by adding labels
plot(ric_weather$tempmax, ric_weather$tempmin)


# GGPLOT:
# make a histogram of max temps using base R
hist(ric_weather$tempmax)
# make the same histogram using ggplot
ggplot(data = ric_weather, aes(x = tempmax)) +
  geom_histogram()
# notice how these do not look exactly the same
# lets set the bins to be the same
# bins determine the values that will be in each count
# a histogram can be 0-10, 11-20... OR 0-5, 6-10... etc
hist(ric_weather$tempmax, breaks = seq(min(ric_weather$tempmax), max(ric_weather$tempmax), length.out = 10))
# make the same histogram using ggplot
ggplot(data = ric_weather, aes(x = tempmax)) +
  geom_histogram(bins = 11)
# now these two histograms look the same

# setting titles (main, x, y)
boxplot(ric_weather$temp, main = "Temperature in Richmond",
        xlab = "Richmond, VA",
        ylab = "Temp in F")
# doing it in ggplot
ggplot(ric_weather, aes(x = temp)) +
  geom_boxplot() +
  xlab("Temp in F") +
  ylab("Richmond, VA") +
  ggtitle("Temperature in Richmond") +
  theme(axis.text.y = element_blank(),
        axis.ticks.y = element_blank())
# can you determine what the last two lines do?
# hint: try creating the plot without the theme(...) part
# challenge: can you find another way to add x, y, and main titles in ggplot?

# scatterplots show relationships between two continuous variables
plot(ric_weather$humidity, ric_weather$temp)
plot(ric_weather$tempmax, ric_weather$feelslikemax)
# try playing around with the weather columns until you find an interesting relationship
# think about things that may change together
# remember: you can use head() to see the first few rows and column names or show the dataframe in another window in the editor (by clicking on it in the environment or using View(dataframe))
# challenge: can you find another way to show column names?
plot(ric_weather$tempmax, ric_weather$tempmin)


# I will only be using ggplot from here on out, but know you can do most of these things in base R as well
# I will also be doing some minor data manipulations
# don't worry if you don't fully understand it now, we will go over it in more detail in a later class

library(dplyr) # if you haven't already downloaded the package you may need to do that first!
library(lubridate)

weather_dates <- ric_weather %>%
  dplyr::mutate(datetime = lubridate::ymd(datetime),
                sunrise = substr(sunrise, 12, 19),
                sunset = substr(sunset, 12, 19))
# can you tell what has changed?
# hint: use str() to compare ric_weather (the original data) to the new dataframe just created (weather_dates)

# average temperature by day of week
temp_days <- weather_dates %>%
  dplyr::mutate(day = lubridate::wday(datetime, label = T)) %>%
  dplyr::group_by(day) %>%
  dplyr::summarize(ave_temp = mean(temp))
# notice how I set the plot created with ggplot TO "temp_days"
# how do I make the plot show up in the plots window?
temp_day <- ggplot2::ggplot(temp_days, aes(x = day, y = ave_temp)) +
  geom_col()
# once a plot is saved as a variable you can then remember it and make changes to it later
temp_day +
  ggtitle("Average Temperature by Day") +
  xlab("Day") + ylab("Temperature")


# average rainfall by precip probability
#    reshape the data
precipitation <- ric_weather %>%
  dplyr::group_by(as.factor(precipprob)) %>%
  dplyr::summarize(ave_precip = mean(precip)) %>%
  dplyr::rename(precip_prob = `as.factor(precipprob)`)
#    make the graph
precip_bar <- ggplot2::ggplot(precipitation, aes(x = precip_prob, y = ave_precip)) +
  geom_bar(stat = "identity") +
  ggtitle("Average Precipitation by Precipitation Probability") +
  xlab("Probability") + ylab("Precipitation (inches)")
precip_bar

# line graph: good way to show trends over time
temp_months <- weather_dates %>%
  dplyr::mutate(month = lubridate::month(datetime, label = T)) %>%
  dplyr::group_by(month) %>%
  dplyr::summarize(ave_temp = mean(temp))
# what do you think the changes I added in "geom_line" will do to the graph?
temp_month_line <- ggplot2::ggplot(temp_months, aes(x = month, y = ave_temp, group = 1)) +
  geom_line(linetype = "dashed", color = "red") +
  ggtitle("Average Temp by Month") +
  xlab("Month") + ylab("Temp (F)")
temp_month_line

library(tidyr)
temp_minmax <- weather_dates %>%
  dplyr::mutate(month = lubridate::month(datetime, label = T)) %>%
  dplyr::group_by(month) %>%
  dplyr::summarize(min = mean(tempmin),
                   max = mean(tempmax)) %>%
  tidyr::pivot_longer(!c(month),
                      names_to = "minmax",
                      values_to = c("temp"))

minmax_line <- ggplot2::ggplot(temp_minmax, aes(x = month, y = temp, group = minmax, color = minmax)) +
  geom_line() +
  # geom_point() +
  ggtitle("High v Low Temp by Month") +
  xlab("Month") + ylab("Temp (F)")
minmax_line
# what does uncommenting geom_point() do?

# now use weather data you downloaded for your own area and make your own graphs
# remember to call the data something meaningful to distinguish it
# copy some of the same things we did together and look up how to do new things
# ex: change colors
#     find new ways to add titles
#     change tick marks
#     find other ways to customize a graph
# don't worry too much about trying to reformat the data, that part is tricky
# ask for help if you want to do something but have trouble figuring it out

# ------------------------------------------------------------------------
# CLASS THREE: data distributions, simple statistical tests

ric_weather <- read.csv("richmond 2020-01-01 to 2021-12-31.csv")
hist(ric_weather$temp)

# the closer the qqnorm plot is to a straight diagonal line, the closer the data is to normal distribution
# these look pretty good
qqnorm(ric_weather$sealevelpressure)
qqnorm(iris$Sepal.Width)

# we can use the shapiro-wilk test to find a quantitative measure of normality
shapiro.test(ric_weather$sealevelpressure)
shapiro.test(iris$Sepal.Width)

# now lets run a t test (checking for difference in means between two groups)
# the null hypothesis is that there is NO difference in means
# anything less than 5% chance of happening under that assumption (no difference) means the null hypothesis can be "rejected"

# this is data from another built in r dataset
head(CO2)
shapiro.test(CO2$uptake)
nrow(CO2)
# uptake is not normally distributed but it is actually not necessary to run a t test
# with a large enough sample (N>50), the samples will be normally distributed around the true mean in the population
# LINK: t test for non normal when n>50 stats stack exchange
plot(uptake ~ Treatment, data = CO2)
t.test(uptake ~ Treatment, data = CO2)
# since p value is 0.003 (less than 0.05) there is a difference in means between groups

# this is another t test
# what are the two groups being measured this time? (hint: what is Type?)
plot(uptake ~ Type, data = CO2)
t.test(uptake ~ Type, data = CO2)


# now lets compare the mean temperatures between 2020 and 2021
# first create a column to differentiate the years
ric_weather_yrs <- ric_weather %>%
  dplyr::mutate(year = lubridate::year(datetime))

# can you try to understand what is happening by running parts of the code piece by piece?
shapiro.test(ric_weather_yrs %>%
               dplyr::filter(year == 2020) %>%
               dplyr::pull(temp)
)
shapiro.test(ric_weather_yrs %>%
               dplyr::filter(year == 2021) %>%
               dplyr::pull(temp)
)
# low p values so we have to reject the null hypothesis (that the data are normally distributed)
# but the count of observations for each year is over 50 so we can run t tests
ric_weather_yrs %>%
  dplyr::group_by(year) %>%
  dplyr::summarise(count = n())

# now we can look at temperature between years
plot(temp ~ as.factor(year), data = ric_weather_yrs)
t.test(temp ~ as.factor(year), data = ric_weather_yrs)
# what does this p value tell us about the means?

# now try to find another pair in the data you can use to perform a t test
# ex: comparing between two seasons, comparing months, comparing days of the week
# remember the first part will be finding the means of the two groups you choose to look at

################################################################################
# go back if enough time
# paired t test

# mice2 contains information on mice before and after treatment
install.packages("datarium")
package(datarium)
head(mice2)

head(mice2)

mice_long <- mice2 %>%
  gather(key = "group", value = "weight", before, after)

head(mice_long)

t.test(weight ~ group, data = mice_long, paired = TRUE)

################################################################################


# now lets look at linear regression

# example done by hand but in R:
reaction <- data.frame(
  time = c(5,7,12,16,20),
  mass = c(40,120,180,210,240)
)
reaction_lm <- lm(mass ~ time, data = reaction)
summary(reaction_lm)

# we will be using cars data which is another built in dataset

# look at the data
head(cars, 10)

# check if the response variable is close to normal
hist(cars$speed)
qqnorm(cars$speed)
shapiro.test(cars$speed)


# now check to see if there is a linear relationship between two continuous variables
plot(x = cars$speed, y = cars$dist, main = "dist ~ speed")
scatter.smooth(x = cars$speed, y = cars$dist, main = "dist ~ speed")
# using cor() will provide quantitative value for correlation
# result will be -1 to 1
# 0 means no correlation
# -1 means strong negative correlation (as one goes up other goes down)
# 1 means strong positive correlation (they go up and down together)
cor(cars$speed, cars$dist)

cars_lm <- lm(dist ~ speed, data = cars)
print(cars_lm)
summary(cars_lm)

# residuals tell us about the difference between the model's expected values and the observed results from the data
# for every unit change in distance, the calculated speed is 15.38 units different from observed values
# r squared is goodness of fit; it represents how much of the response variable can be explained by the x variable
# in this case, 65.11% of variation in speed can be explained by distance
# adjusted r squared takes into account the complexity of the model (number of predictors (x variables))
# it tends to be lower than r squared because it penalizes added complexity without increasing the model's function


################################################################################
# go back if enough time
# using linear regression to predict values
# if you use all your data, there is no good way to test how the model performs
# general practice is to split data 80:20 so 80% is used for training, 20% is for testing

# this will make it so results of random sampling can be reproduced
set.seed(100)

training_rows <- sample(1:nrow(cars), 0.8*nrow(cars))
training_data <- cars[training_rows,]
testing_data <- cars[-training_rows,]

# look at how the data has been split
nrow(cars)
nrow(training_data)
nrow(testing_data)

# build the linear model based on the training data
training_lm <- lm(dist ~ speed, data = training_data)
summary(training_lm)
# explains 65% of the variation
# very significant p value

# predict speed based on distance using the linear model created using the training data
predicted_speed <- predict(training_lm, testing_data)
# added predicted values to dataframe so it is easier to look at
testing_data <- testing_data %>%
  dplyr::mutate(predicted = predicted_speed)
testing_data
# based on training data, we have expected distances for each speed

# check how well our model performed


################################################################################


# ------------------------------------------------------------------------
# CLASS FOUR: data manipulations, formal introduction to dplyr

# subsetting data:
ric_weather[1,1]
ric_weather[1,c(1:3)]
ric_weather[c(1:3),]
ric_weather[1,"datetime"]
ric_weather[1,c("name", "datetime", "tempmax")]
ric_weather$datetime[1]
ric_weather$datetime[c(1:3)]
ric_weather$datetime
ric_weather[ric_weather$temp > 85,c(1:5)]

# transforming data:
celsius <- (ric_weather$temp - 32) * 5 / 9
ric_weather$temp_c <- celsius

below_85 <- ric_weather[ric_weather$temp < 85,]

# dplyr example before explanation:
below_85_dplyr <- ric_weather %>%
  dplyr::mutate(celsius = (temp - 32) * 5 / 9) %>%
  dplyr::filter(temp < 85)
head(below_85_dplyr[,c(1:5, 35)])
nrow(below_85_dplyr)

# dplyr is a package with functions to manipulate data
# ex: filtering, selecting specific columns, sorting, adding/deleting columns
library(dplyr)

mydata = read.csv("https://raw.githubusercontent.com/deepanshu88/data/master/sampledata.csv")
head(mydata)

# dplyr::select()
mydata_selection <- mydata %>%
  dplyr::select(State, Y2010, Y2015)
head(mydata_selection)
# remember the difference between creating a new variable and just performing the function
# if you do not set the result as a new variable it is lost
# see some more examples of select()
mydata %>%
  dplyr::select(-c(Index, Y2002, Y2003, Y2004, Y2005))
mydata %>%
  dplyr::select(c(State, Y2002:Y2005)) %>%
  head(., 10)

# dplyr::filter()
# subset data with matching logical conditions (<, >, ==, <=, >=, !=, etc)
# choose only states with 2002 income greater than 1,900,000
mydata %>%
  dplyr::filter(Y2002 > 1900000)
mydata %>%
  dplyr::filter(Y2002 > 1500000 & Y2003 > 1500000) %>%
  dplyr::select(Index, State, Y2002, Y2003)
mydata %>%
  dplyr::filter(Index %in% c("A", "B", "C"))
library(stringr)
# find states that end in "land"
mydata %>%
  dplyr::filter(str_detect(State, "land$"))
# find states that start with "New"
mydata %>%
  dplyr::filter(str_detect(State, "^New"))
# what if you don't capitalize new?
mydata %>%
  dplyr::filter(str_detect(State, "^new"))
# fix by making the capitalization match
# this does not change the state name in your dataframe, just lowercase for matching the string you enter ("new")
mydata %>%
  dplyr::filter(str_detect(tolower(State), "^new"))

# dplyr::arrange()
# sorts data
# lowest to highest Y2002 values
mydata %>%
  dplyr::arrange(Y2002) %>%
  dplyr::select(State, Y2002)
# if you add desc() it sorts the other way highest to lowest
mydata %>%
  dplyr::arrange(desc(Y2002)) %>%
  dplyr::select(State, Y2002) %>%
  head(., 10)


# dplyr::mutate
# creating a new column
mutate_column <- mydata %>%
  dplyr::mutate(new_column_name = Y2015)
head(mutate_column)

# new column with a different value
mutate_ave_1415 <- mydata %>%
  dplyr::mutate(ave_1415 = rowMeans(dplyr::select(mydata, c(Y2014:Y2015))))
head(mutate_ave_1415)

# conversions

# reminder: I did not know how to do any of this off the top of my head
# I looked all of this up using mostly stack overflow
# my goofy searches:
# mm to cm
# mutate_at in pipe r
# r dplyr pipe average of certain columns
# r average of certain columns
# r average of certain columns mutate at
# dplyr mutate
# mutate mean of multiple columns r
# mutate convert all columns to different units r
# multiply certain columns r
# multiply certain columns by 100 r
# multiply certain columns by 100 with mutate r

# pretend these values are in mm and we want to convert to cm
mutate_convert_to_cm <- mydata %>%
  dplyr::mutate(cm15 = Y2015/10)
head(mutate_convert_to_cm)
# if you want to do the same thing on all columns you can do this
# I am using select to choose the columns I want to change
convert_to_cm <- mydata %>% dplyr::select(c(3:16))/10
head(convert_to_cm)
# this works but it doesn't use mutate so come columns are lost
# using across() lets you do a function "across" specific columns
# remember how we use select(), part of across includes choosing columns in a similar way
convert_to_cm <- mydata %>%
  dplyr::mutate(
    dplyr::across(
      .cols = -c(1:2),
      .fns = function(x){x/100}
    )
  )
head(convert_to_cm)

# conditional mutate, creating categories for Y2015 income using case_when()
# use range to find spread of values
range(mydata$Y2015)
# create a new column called "category_15" to make values less than 1300000 = "low", between 1300000-1750000 = "medium", and anything above "high"
mutate_buckets <- mydata %>%
  dplyr::mutate(category_15 = case_when(Y2015 < 1300000 ~ "low",
                                        Y2015 < 1750000 ~ "medium",
                                        .default = "high"))
head(mutate_buckets[,c(2, 16:17)], 10)
# instead of using head, I am displaying only the columns I am interested in: the state name, Y2015, and category_15
mutate_buckets %>%
  dplyr::select(State, Y2015, category_15) %>%
  head(., 10)
# check what these do:
# mutate_buckets[c(1:20), c(2, 16:17)]
# mutate_buckets[c(1:20), c("State", "Y2015", "category_15")]
# head(mutate_buckets[,c(2, 16:17)], 20)

# dplyr::summarise()
# creates summary stats about your dataframe
mydata %>%
  dplyr::summarise(all_states_2002 = mean(Y2002))

# add group_by() to find mean based on a category
# this is the average of all states that start with the same letter
mydata %>%
  dplyr::group_by(Index) %>%
  dplyr::summarise(by_index_2002 = mean(Y2002))

# we can go back and use the groupings we created earlier with mutate (mutate_buckets)
head(mutate_buckets)
mutate_buckets %>%
  dplyr::group_by(category_15) %>%
  dplyr::summarise(mean_15 = mean(Y2015))
# we can find multiple summary stats about our data too
# if we want to add standard deviation, we can use sd()
mutate_buckets %>%
  dplyr::group_by(category_15) %>%
  dplyr::summarise(mean_15 = mean(Y2015),
                   sd_15 = sd(Y2015))
# we can also add min() and max() for each group
mutate_buckets %>%
  dplyr::group_by(category_15) %>%
  dplyr::summarise(mean_15 = mean(Y2015),
                   sd_15 = sd(Y2015),
                   min_15 = min(Y2015),
                   max_15 = max(Y2015))




# examples to go through together:

# take a sample
# set seed so this random sample is reproducible
# try it with a different seeded value
set.seed(123)
# sample size 3
sample_n(mydata, 3)[,c(1:3)]
# sample proportion 10%
sample_frac(mydata, 0.1)[,c(1:3)]


# find non repeating values
# summarise n will show the count, number of unique values
# run code without the last line and see what happens
mydata %>%
  dplyr::distinct() %>%
  dplyr::summarise(n = n())

# this shows only distinct values of the index
# since there are multiple states that start with the same letter, it is less than 50
mydata %>%
  dplyr::distinct(Index, .keep_all = TRUE) %>%
  dplyr::summarise(n = n())

# sort column by values
mydata %>%
  dplyr::arrange(Y2002) %>%
  head(4)
# sort descending
mydata %>%
  dplyr::arrange(desc(Y2002)) %>%
  head(4)

# you can sort by multiple columns too
# if one column has repeating values, it will then sort by the second column
mtcars %>%
  dplyr::arrange(desc(gear), desc(hp)) %>%
  head(8)

# selecting certain columns
mtcars %>%
  dplyr::select(cyl, disp, hp) %>%
  head(2)
# example doing the same thing in base R (not dplyr)
head(mtcars[,c("cyl", "disp", "hp")], 2)
# can you break down what is happening here?
# try running certain pieces of it at a time
# note: things are nested within each other
# it is a bit easier to understand what is happening by using dplyr!

# you can choose columns to not show too
mtcars %>%
  dplyr::select(-cyl, -disp, -hp) %>%
  head(2)


# creating columns
mtcars %>%
  dplyr::mutate(hp_wt = hp/wt,
                mpg_wt = mpg/wt)
# remember we havent actually saved any of this work
# to do that we need to create a new variable
mtcars2 <- mtcars %>%
  dplyr::mutate(hp_wt = hp/wt,
                mpg_wt = mpg/wt)
# now we can compare the two dataframes
ncol(mtcars)
ncol(mtcars2)
# we can see the extra columns that we just added to mtcars2

# example of adding the columns in base R
mtcars3 <- mtcars
mtcars3$hp_wt <- mtcars3$hp/mtcars3$wt
mtcars3$mpg_wt <- mtcars3$mpg/mtcars3$wt
head(mtcars2)
head(mtcars3)

# tidyr
# pivot longer/wider
# an important part of data manipulation will be changing it into a format needed for your analysis
mydata_long <- mydata %>%
  tidyr::pivot_longer(names_to = "year",
                      values_to = "income",
                      cols = 3:16) %>%
  print(n = 20)

mydata_wide <- mydata_long %>%
  tidyr::pivot_wider(names_from = "year",
                     values_from = "income") %>%
  print(n = 5)


# challenges to do on your own: (use your weather data)
# create a new column with rainfall in cm (instead of in)
# sort from highest to lowest temperature (try all temperature columns)
# find dates of 10 lowest temperatures
# are there any days with the same high and low temperatures? (hint: compare rows with unique values to total rows)
# bonus: remove any rows with temperature below a threshold (you can choose a number based on your data, maybe try 32 F)

