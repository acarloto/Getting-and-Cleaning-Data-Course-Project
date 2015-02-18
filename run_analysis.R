# run_analysis.R script. Note: during the all process I often used the head(), tail()
# and str() commands to check my data but those steps for the sake of legibility are not
# printed here.

# create directory for the files

dir.create("./data/SGS")

# call "downloader" package

library(downloader)

# download and unzip the files

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download(fileUrl, dest = "./data/SGS/dataset.zip", mode = "wb")
unzip("./data/SGS/dataset.zip", exdir = "./data/SGS/")

# attach in each data set (train and test) the files of interest to their paths

files_full_train <- list.files("./data/SGS/UCI HAR Dataset/train", full.names = TRUE)
files_full_test <- list.files("./data/SGS/UCI HAR Dataset/test", full.names = TRUE)

# read the files of interest

x_test <- read.table(files_full_test[3], sep = "", header = FALSE)
y_test <- read.table(files_full_test[4], sep = "", header = FALSE)
subject_test <- read.table(files_full_test[2], sep = "", header = FALSE)

x_train <- read.table(files_full_train[3], sep = "", header = FALSE)
y_train <- read.table(files_full_train[4], sep = "", header = FALSE)
subject_train <- read.table(files_full_train[2], sep = "", header = FALSE)

# bind the two sets of data frames by column

test <- data.frame(c(subject_test, y_test, x_test))
train <- data.frame(c(subject_train, y_train, x_train))

# bind the test data frame on the top of the train data frame

test_train <- rbind(test, train)

# call the "dplyr" package

library(dplyr)

# select the columns of subject, activity and means and standard deviations of the measures

test_train_selected <- select(test_train, 1:2, 3:8, 43:48, 83:88, 123:128, 163:168, 203:204, 
                              216:217, 229:230, 242:243, 255:256, 268:263, 296:298, 347:349, 
                              350:352, 375:377, 426:431, 454:456, 505:506, 515, 518:519, 528, 
                              531:532, 541, 544:545, 554)

# read the features file and make a vector with the names

features <- read.table("./data/SGS/UCI HAR Dataset/features.txt", sep = "", header = FALSE)
variable_names <-as.vector(features$V2)

# name the columns in the merged data frame with the selected labels

names(test_train_selected) <- c("subject", "activity", variable_names[c(1:6, 41:46, 81:86, 
                              121:126, 161:166, 201:202, 214:215, 227:228, 240:241, 253:254, 
                              266:271, 294:296, 345:350, 373:375, 424:429, 452:454, 503:504, 
                              513, 516:517, 526, 529:530, 539, 542:543, 552)])

# read the activity file and make a vector with the names

activities <- read.table("./data/SGS/UCI HAR Dataset/activity_labels.txt", sep = "", header = FALSE)
activities_names <-as.vector(activities$V2)

# categorize the "activity" variable by the five types of activity

test_train_selected$activity <- factor(test_train_selected$activity)
levels(test_train_selected$activity) <- activities_names

# reorder the data frame, first by subject, second by activity

almost_tidy <- arrange(test_train_selected, subject, activity)

# categorize the "subject" variable

almost_tidy$subject <- factor(almost_tidy$subject)

# call the "reshape2" package

library(reshape2)

# melt the data set into a long-format data set

tidy_melt <- melt(almost_tidy, id.vars = c("subject", "activity"))

# cast the previous data set

tidy <- dcast(tidy_melt, subject + activity ~ variable, fun.aggregate = mean)

# export the tidy data set to a text format

write.table(tidy, file ="./tidy.txt", sep = " ", row.names = FALSE)

# read and review the text file back to confirm the result

back <- read.table("./tidy.txt", header = TRUE)
View(back)

# the end :-)

