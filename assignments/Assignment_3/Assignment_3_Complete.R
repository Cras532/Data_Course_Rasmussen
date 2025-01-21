###########################
#                         #
#    Assignment Week 3    #
#                         # 
###########################

# Instructions ####
# Fill in this script with stuff that we do in class.
# It might be a good idea to include comments/notes as well so you remember things we talk about
# At the end of this script are some comments with blank space after them
# They are plain-text instructions for what you need to accomplish.
# Your task is to write the code that accomplished those tasks.

# Then, make sure to upload this to both Canvas and your GitHub repository




# Vector operations! ####

# Vectors are 1-dimensional series of values in some order
1:10 # ':' only works for integers
letters # built-in pre-made vector of a - z
#> 1:10
[1]  1  2  3  4  5  6  7  8  9 10
#  letters
[1] "a" "b" "c" "d" "e" "f" "g" "h"
[9] "i" "j" "k" "l" "m" "n" "o" "p"
[17] "q" "r" "s" "t" "u" "v" "w" "x"
[25] "y" "z"

vector1 <- c(1,2,3,4,5,6,7,8,9,10)
vector2 <- c(5,6,7,8,4,3,2,1,3,10)
vector3 <- letters # letters and LETTERS are built-in vectors
#> vector1 <- c(1,2,3,4,5,6,7,8,9,10)
> vector2 <- c(5,6,7,8,4,3,2,1,3,10)
> vector3 <- letters

vector1 + 5
#> vector1 + 5
[1]  6  7  8  9 10 11 12 13 14 15
vector2 / 2
#> vector2 / 2
[1] 2.5 3.0 3.5 4.0 2.0 1.5 1.0 0.5
[9] 1.5 5.0
vector1*vector2
#> vector1 * vector2
[1]   5  12  21  32  20  18  14   8
[9]  27 100

vector3 + 1 # can't add 1 to "a"


# Logical expressions (pay attention to these...they are used ALL THE TIME)
vector1 > 3
#vector1 > 3
[1] FALSE FALSE FALSE  TRUE  TRUE
[6]  TRUE  TRUE  TRUE  TRUE  TRUE

vector1 >= 3
#> vector1 >= 3
[1] FALSE FALSE  TRUE  TRUE  TRUE
[6]  TRUE  TRUE  TRUE  TRUE  TRUE

vector1 < 5
#> vector1 < 5
[1]  TRUE  TRUE  TRUE  TRUE FALSE
[6] FALSE FALSE FALSE FALSE FALSE

vector1 <= 5
#> vector1 <= 5
[1]  TRUE  TRUE  TRUE  TRUE  TRUE
[6] FALSE FALSE FALSE FALSE FALSE

vector1 == 7
#vector1 == 7
[1] FALSE FALSE FALSE FALSE FALSE
[6] FALSE  TRUE FALSE FALSE FALSE

letters == "a"
#> letters == "a"
[1]  TRUE FALSE FALSE FALSE FALSE
[6] FALSE FALSE FALSE FALSE FALSE
[11] FALSE FALSE FALSE FALSE FALSE
[16] FALSE FALSE FALSE FALSE FALSE
[21] FALSE FALSE FALSE FALSE FALSE
[26] FALSE

letters != "c"
#> letters != "c"
[1]  TRUE  TRUE FALSE  TRUE  TRUE
[6]  TRUE  TRUE  TRUE  TRUE  TRUE
[11]  TRUE  TRUE  TRUE  TRUE  TRUE
[16]  TRUE  TRUE  TRUE  TRUE  TRUE
[21]  TRUE  TRUE  TRUE  TRUE  TRUE
[26]  TRUE

letters %in% c("a","b","c","z")
#> letters %in% c("a","b","c","z")
[1]  TRUE  TRUE  TRUE FALSE FALSE
[6] FALSE FALSE FALSE FALSE FALSE
[11] FALSE FALSE FALSE FALSE FALSE
[16] FALSE FALSE FALSE FALSE FALSE
[21] FALSE FALSE FALSE FALSE FALSE
[26]  TRUE

vector1 %in% 1:6
#> vector1 %in% 1:6
[1]  TRUE  TRUE  TRUE  TRUE  TRUE
[6]  TRUE FALSE FALSE FALSE FALSE



# Data Frames ####
# R has quite a few built-in data sets
data("iris") # load it like this
data("iris")

# For built-in data, there's often a 'help file'
?iris
?iris

#iris# "Iris" is a 'data frame.' 
# Data frames are 2-dimensional (think Excel spreadsheet)
# Rows and columns
# Each row or column is a vector


dat <- iris # can rename the object to be easier to type if you want
dat <- iris

# ways to get a peek at our data set
names(dat) # returns the names of the columns in the data frame.
# > names(dat)
[1] "Sepal.Length" "Sepal.Width" 
[3] "Petal.Length" "Petal.Width" 
[5] "Species"  

dim(dat) # returns the dimensions of the data frame, i.e., rows and columns.
#> dim(dat)
[1] 150   5

head(dat) # returns the fist six rows of the data fram, quick look at the data.
#> head(dat)
Sepal.Length Sepal.Width
1          5.1         3.5
2          4.9         3.0
3          4.7         3.2
4          4.6         3.1
5          5.0         3.6
6          5.4         3.9
Petal.Length Petal.Width Species
1          1.4         0.2  setosa
2          1.4         0.2  setosa
3          1.3         0.2  setosa
4          1.5         0.2  setosa
5          1.4         0.2  setosa
6          1.7         0.4  setosa


# You can access specific columns of a "data frame" by name using '$'
dat$Species
#> dat$Species
[1] setosa     setosa     setosa    
[4] setosa     setosa     setosa    
[7] setosa     setosa     setosa    
[10] setosa     setosa     setosa    
[13] setosa     setosa     setosa    
[16] setosa     setosa     setosa    
[19] setosa     setosa     setosa    
[22] setosa     setosa     setosa    
[25] setosa     setosa     setosa    
[28] setosa     setosa     setosa    
[31] setosa     setosa     setosa    
[34] setosa     setosa     setosa    
[37] setosa     setosa     setosa    
[40] setosa     setosa     setosa    
[43] setosa     setosa     setosa    
[46] setosa     setosa     setosa    
[49] setosa     setosa     versicolor
[52] versicolor versicolor versicolor
[55] versicolor versicolor versicolor
[58] versicolor versicolor versicolor
[61] versicolor versicolor versicolor
[64] versicolor versicolor versicolor
[67] versicolor versicolor versicolor
[70] versicolor versicolor versicolor
[73] versicolor versicolor versicolor
[76] versicolor versicolor versicolor
[79] versicolor versicolor versicolor
[82] versicolor versicolor versicolor
[85] versicolor versicolor versicolor
[88] versicolor versicolor versicolor
[91] versicolor versicolor versicolor
[94] versicolor versicolor versicolor
[97] versicolor versicolor versicolor
[100] versicolor virginica  virginica 
[103] virginica  virginica  virginica 
[106] virginica  virginica  virginica 
[109] virginica  virginica  virginica 
[112] virginica  virginica  virginica 
[115] virginica  virginica  virginica 
[118] virginica  virginica  virginica 
[121] virginica  virginica  virginica 
[124] virginica  virginica  virginica 
[127] virginica  virginica  virginica 
[130] virginica  virginica  virginica 
[133] virginica  virginica  virginica 
[136] virginica  virginica  virginica 
[139] virginica  virginica  virginica 
[142] virginica  virginica  virginica 
[145] virginica  virginica  virginica 
[148] virginica  virginica  virginica 
3 Levels: setosa ... virginica

dat$Sepal.Length
# > dat$Sepal.Length
[1] 5.1 4.9 4.7 4.6 5.0 5.4 4.6 5.0
[9] 4.4 4.9 5.4 4.8 4.8 4.3 5.8 5.7
[17] 5.4 5.1 5.7 5.1 5.4 5.1 4.6 5.1
[25] 4.8 5.0 5.0 5.2 5.2 4.7 4.8 5.4
[33] 5.2 5.5 4.9 5.0 5.5 4.9 4.4 5.1
[41] 5.0 4.5 4.4 5.0 5.1 4.8 5.1 4.6
[49] 5.3 5.0 7.0 6.4 6.9 5.5 6.5 5.7
[57] 6.3 4.9 6.6 5.2 5.0 5.9 6.0 6.1
[65] 5.6 6.7 5.6 5.8 6.2 5.6 5.9 6.1
[73] 6.3 6.1 6.4 6.6 6.8 6.7 6.0 5.7
[81] 5.5 5.5 5.8 6.0 5.4 6.0 6.7 6.3
[89] 5.6 5.5 5.5 6.1 5.8 5.0 5.6 5.7
[97] 5.7 6.2 5.1 5.7 6.3 5.8 7.1 6.3
[105] 6.5 7.6 4.9 7.3 6.7 7.2 6.5 6.4
[113] 6.8 5.7 5.8 6.4 6.5 7.7 7.7 6.0
[121] 6.9 5.6 7.7 6.3 6.7 7.2 6.2 6.1
[129] 6.4 7.2 7.4 7.9 6.4 6.3 6.1 7.7
[137] 6.3 6.4 6.0 6.9 6.7 6.9 5.8 6.8
[145] 6.7 6.7 6.3 6.5 6.2 5.9

# You can also use square brackets to get specific 1-D or 2-D subsets of a data frame (rows and/or columns)
dat[1,1] # [Rows, Columns]
# > dat[1,1] # [Rows, Columns]
[1] 5.1

dat[1:3,5] # returns elements in the first 3 rows of the fifth column of the data frame.
# [1] setosa setosa setosa
3 Levels: setosa ... virginica

vector2[1] # returns the first element of vector2
# [1] 5

letters[1:7] # returns first seven letters of the built-in letters vector.
#[1] "a" "b" "c" "d" "e" "f" "g"

letters[c(1,3,5,7)] # returns the letters at positions 1,3,5,and 7 from letters vector.
# [1] "a" "c" "e" "g"


# Plotting ####

# Can make a quick plot....just give vectors for x and y axes
plot(x=dat$Petal.Length, y=dat$Sepal.Length)
# used snipping tool for image. Unable to add to this.

plot(x=dat$Species, y=dat$Sepal.Length)
# used snipping tool for image. Unable to add to this.


# Object "Classes" ####

#check the classes of these vectors
class(dat$Petal.Length)
# [1] "numeric"

class(dat$Species)
#[1] "factor"


# plot() function behaves differently depending on classes of objects given to it!

# Check all classes (for each column in dat)
str(dat)
# > str(dat)
'data.frame':	150 obs. of  5 variables:
  $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
$ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
$ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
$ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
$ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...


# "Classes" of vectors can be changed if needed (you'll need to, for sure, at some point!)

# Let's try
nums <- c(1,1,2,2,2,2,3,3,3,4,4,4,4,4,4,4,5,6,7,8,9)
class(nums) # make sure it's numeric
# [1] "numeric"

# convert to a factor
as.factor(nums) # show in console
# [1] 1 1 2 2 2 2 3 3 3 4 4 4 4 4 4 4 5
[18] 6 7 8 9
Levels: 1 2 3 4 5 6 7 8 9

nums_factor <- as.factor(nums) #assign it to a new object as a factor

class(nums_factor) # check it
# [1] "factor"


# convert numeric to character
as.character(vector1)
# [1] "1"  "2"  "3"  "4"  "5"  "6"  "7" 
[8] "8"  "9"  "10"

as.character(vector1 + 5)
# [1] "6"  "7"  "8"  "9"  "10" "11" "12"
[8] "13" "14" "15"

# convert character to numeric
as.numeric(vector3)
# [1] NA NA NA NA NA NA NA NA NA NA NA
[12] NA NA NA NA NA NA NA NA NA NA NA
[23] NA NA NA NA
Warning message:
  NAs introduced by coercion 



#check it out
plot(nums)
# used snipping tool and placed in assignment 3

plot(nums_factor)
# used snipping tool and placed in assignment 3

# take note of how numeric vectors and factors behave differently in plot()




# Simple numeric functions
# R is a language built for data analysis and statistics so there is a lot of functionality built-in

max(vector1)
# 10
min(vector1)
# 1
median(vector1)
# 5.5
mean(vector1)
# 5.5
range(vector1)
# 1 10
summary(vector1)
# Min. 1st Qu.  Median    Mean 
1.00    3.25    5.50    5.50 
3rd Qu.    Max. 
7.75   10.00 

# cumulative functions
cumsum(vector1) # computes cumulative sum of the elements
# [1]  1  3  6 10 15 21 28 36 45 55
cumprod(vector1) # computes cumulative product of the elements
# [1]       1       2       6      24
[5]     120     720    5040   40320
[9]  362880 3628800
cummin(vector1) # computes the cumulative minimum of the elements
# [1] 1 1 1 1 1 1 1 1 1 1
cummax(vector1) # computes cumulative maximum of the elements
#[1]  1  2  3  4  5  6  7  8  9 10


# even has built-in statistical distributions (we will see more of these later)
dbinom(50,100,.5) # probability of getting exactly 50 heads out of 100 coin flips
# [1] 0.07958924



# YOUR REMAINING HOMEWORK ASSIGNMENT (Fill in with code) ####

# 1.  Get a subset of the "iris" data frame where it's just even-numbered rows

seq(2,150,2) # here's the code to get a list of the even numbers between 2 and 150
# [1]   2   4   6   8  10  12  14  16
[9]  18  20  22  24  26  28  30  32
[17]  34  36  38  40  42  44  46  48
[25]  50  52  54  56  58  60  62  64
[33]  66  68  70  72  74  76  78  80
[41]  82  84  86  88  90  92  94  96
[49]  98 100 102 104 106 108 110 112
[57] 114 116 118 120 122 124 126 128
[65] 130 132 134 136 138 140 142 144
[73] 146 148 150

even_rows <- seq(2, 150, 2)

#subset the iris data fram
iris_even_rows <- iris[even_rows,]


# 2.  Create a new object called iris_chr which is a copy of iris, except where every column is a character class

iris_chr <- as.data.frame(lapply(iris, as.character))


# 3.  Create a new numeric vector object named "Sepal.Area" which is the product of Sepal.Length and Sepal.Width

Sepal.Area <- iris$Sepal.Length * iris$Sepal.Width
#print(Sepal.Area)
#[1] 17.85 14.70 15.04 14.26 18.00
#[6] 21.06 15.64 17.00 12.76 15.19
#[11] 19.98 16.32 14.40 12.90 23.20
#[16] 25.08 21.06 17.85 21.66 19.38
#[21] 18.36 18.87 16.56 16.83 16.32
#[26] 15.00 17.00 18.20 17.68 15.04
#[31] 14.88 18.36 21.32 23.10 15.19
#[36] 16.00 19.25 17.64 13.20 17.34
#[41] 17.50 10.35 14.08 17.50 19.38
#[46] 14.40 19.38 14.72 19.61 16.50
#[51] 22.40 20.48 21.39 12.65 18.20
#[56] 15.96 20.79 11.76 19.14 14.04
#[61] 10.00 17.70 13.20 17.69 16.24
#[66] 20.77 16.80 15.66 13.64 14.00
#[71] 18.88 17.08 15.75 17.08 18.56
#[76] 19.80 19.04 20.10 17.40 14.82
#[81] 13.20 13.20 15.66 16.20 16.20
#[86] 20.40 20.77 14.49 16.80 13.75
#[91] 14.30 18.30 15.08 11.50 15.12
#[96] 17.10 16.53 17.98 12.75 15.96
#[101] 20.79 15.66 21.30 18.27 19.50
#[106] 22.80 12.25 21.17 16.75 25.92
#[111] 20.80 17.28 20.40 14.25 16.24
#[116] 20.48 19.50 29.26 20.02 13.20
#[121] 22.08 15.68 21.56 17.01 22.11
#[126] 23.04 17.36 18.30 17.92 21.60
#[131] 20.72 30.02 17.92 17.64 15.86
#[136] 23.10 21.42 19.84 18.00 21.39
#[141] 20.77 21.39 15.66 21.76 22.11
#[146] 20.10 15.75 19.50 21.08 17.70

# 4.  Add Sepal.Area to the iris data frame as a new column

iris$Sepal.Area <- Sepal.Area


# 5.  Create a new dataframe that is a subset of iris using only rows where Sepal.Area is greater than 20 
      # (name it big_area_iris)

big_area_iris <- subset(iris, Sepal.Area > 20)


# 6.  Upload the last numbered section of this R script (with all answers filled in and tasks completed) 
      # to canvas
      # I should be able to run your R script and get all the right objects generated

