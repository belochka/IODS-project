# Bella Zhukova, 26 Oct 2020. Exercise 2. Data wrangling. 
# Reading the full learning2014 dataset from: http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt

# 2. Read the full learning2014 data
# the separator is a tab ("\t") and the file includes a header
# output: 
#   183 rows ('objects') x 60 columns ('variables'), all cells are filled. 
#   Columns: [1..56] has values in [1,5]. 
#   Column 57: age. Youngest respondent: 17 years old, oldest: 55. Mean = 25.58.
#   Column 58: attitude (Global attitude toward statistics). Values in [14,50]
#   Column 59: Exam points. Values in [0,33]
#   Column 60: Gender: M (Male), F (Female). The only one that is not "int", but "chr". 122 females,61 males.
#   summary(data) will give more information. I don't see a point to copy its output here.
data <- read.delim('http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt')
#summary(data)

# 3. Create an analysis dataset with the variables:
#         gender, age, attitude, deep, stra, surf and points. 
#         Where:
# Deep      d_sm + d_ri + d_ue (min = 12, max = 60)   # Deep approach
# d_sm      D03 + D11 + D19 + D27                     # Seeking Meaning
# d_ri      D07 + D14 + D22 + D30                     # Relating Ideas
# d_ue      D06 + D15 + D23 + D31                     # Use of Evidence
#
# Strategic   st_os + st_tm (min = 8, max = 40)       # Srategic approach
# st_os     ST01 + ST09 + ST17 + ST25                 # Organized Studying
# st_tm     ST04 + ST12 + ST20 + ST28                 # Time management
#
# Surface   su_lp + su_um + su_sb (min =12, max = 60) # Surface approach
# su_lp     SU02 + SU10 + SU18 + SU26                 # Lack of purpose
# su_um     SU05 + SU13 + SU21 + SU29                 # Unralated memorising
# su_sb     SU08 + SU16 + SU24 + SU32                 # Syllabus-boundness
#
# Attitude  Da + Db + Dc + Dd + De + Df + Dg + Dh + Di + Dj   # Global attitude toward statistics
library(tidyverse)
data <- as_tibble(data)
data %>% select(c(D03, D11, D19, D27, D07, D14, D22, D30, D06, D15, D23, D31)) %>% rowMeans() -> data$deep
data %>% select(c(ST01, ST09, ST17, ST25, ST04, ST12, ST20, ST28)) %>% rowMeans() -> data$stra
data %>% select(c(SU02, SU10, SU18, SU26, SU05, SU13, SU21, SU29, SU08, SU16, SU24, SU32)) %>% rowMeans() -> data$surf
data %>% select(c(Da, Db, Dc, Dd, De, Df, Dg, Dh, Di, Dj)) %>% rowMeans() -> data$attitude
analysis <- as.data.frame(as_tibble(data) %>% select(gender, Age, attitude, deep, stra, surf, Points)) %>% filter(Points != 0)
analysis <- rename(analysis, age = Age, points = Points)

# 4. Save the analysis dataset to the ‘data’ folder
setwd('./../')
write.table(analysis, file = 'data/learning2014.txt', sep=",")
readBack <- read.table(file = 'data/learning2014.txt', sep=",")
# all.equal(analysis, readBack)

# Use `str()` and `head()` to make sure that the structure of the data is correct
str(analysis)
str(readBack)
head(analysis)
head(readBack)

# answer <- as_tibble(read.csv2('http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/learning2014.txt', sep=','))

