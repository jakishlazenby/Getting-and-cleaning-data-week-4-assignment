library(tidyverse)

# A. Load Data

## A.1. read test data
X_test <- read.table("C:\\Users\\Jake\\Documents\\Jake\\Amnesty International\\Supporter Engagement\\Data Science Course\\datascience_coursera\\UCI HAR Dataset\\test\\X_test.txt")
Y_test <- read.table("C:\\Users\\Jake\\Documents\\Jake\\Amnesty International\\Supporter Engagement\\Data Science Course\\datascience_coursera\\UCI HAR Dataset\\test\\Y_test.txt")
Sub_test <- read.table("C:\\Users\\Jake\\Documents\\Jake\\Amnesty International\\Supporter Engagement\\Data Science Course\\datascience_coursera\\UCI HAR Dataset\\test\\subject_test.txt")

## A.2. read train data
X_train <- read.table("C:\\Users\\Jake\\Documents\\Jake\\Amnesty International\\Supporter Engagement\\Data Science Course\\datascience_coursera\\UCI HAR Dataset\\train\\X_train.txt")
Y_train <- read.table("C:\\Users\\Jake\\Documents\\Jake\\Amnesty International\\Supporter Engagement\\Data Science Course\\datascience_coursera\\UCI HAR Dataset\\train\\Y_train.txt")
Sub_train <- read.table("C:\\Users\\Jake\\Documents\\Jake\\Amnesty International\\Supporter Engagement\\Data Science Course\\datascience_coursera\\UCI HAR Dataset\\train\\subject_train.txt")

## A.3. read activity labels
activity_labels <- read.table("C:\\Users\\Jake\\Documents\\Jake\\Amnesty International\\Supporter Engagement\\Data Science Course\\datascience_coursera\\UCI HAR Dataset\\activity_labels.txt")

## A.4. read data description
features <- read.table("C:\\Users\\Jake\\Documents\\Jake\\Amnesty International\\Supporter Engagement\\Data Science Course\\datascience_coursera\\UCI HAR Dataset\\features.txt")

# B. Merges the training and the test sets to create one data set.
Sub_total <- rbind(Sub_train, Sub_test)
X_total <- rbind(X_train, X_test)
Y_total <- rbind(Y_train, Y_test)

# C. Extracts only the measurements on the mean and standard deviation for each measurement.
selected_var <- features[grep("mean\\(\\)|std\\(\\)",features[,2]),]
X_total <- X_total[,selected_var[,1]]

# D. Creates an independent tidy data set with the average
# of each variable for each activity and each subject.

## D.1. Uses descriptive activity names to name the activities in the data set
colnames(Y_total) <- "activity"
Y_total$activitylabel <- factor(Y_total$activity, labels = as.character(activity_labels[,2]))
activitylabel <- Y_total[,-1]

## D.2. Labels the data set with descriptive variable names extracted from the features set.
colnames(X_total) <- features[selected_var[,1],2]

## D.3. reates a second, independent tidy data set with the average
# of each variable for each activity and each subject.
colnames(Sub_total) <- "subject"
total <- cbind(X_total, activitylabel, Sub_total)
total_mean <- total %>% group_by(activitylabel, subject) %>% summarize_each(funs(mean))
write_csv(total_mean, file = "C:\\Users\\Jake\\Documents\\Jake\\Amnesty International\\Supporter Engagement\\Data Science Course\\datascience_coursera\\tidydata.csv")
          
          #row.names = FALSE, colnames = TRUE)
