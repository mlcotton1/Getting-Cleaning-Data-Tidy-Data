## Getting and Cleaning Data - Project
## Load library and set correct working folder

library(plyr)
setwd("C:/Users/Michelle/Documents/Coursera/UCI HAR Dataset")

## Merge the training and test sets into one data set

x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/Y_train.txt")
train_data <- read.table("train/subject_train.txt")

x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
test_data <- read.table("test/subject_test.txt")

x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
data <- rbind(train_data, test_data)

## Extract only the measurements on the mean and standard deviation for each measurement

features <- read.table("features.txt")
desired_features <- grep("-(mean|std)\\(\\)", features[,2])
x_data <- x_data[, desired_features]
names(x_data) <- features[desired_features, 2]

## Uses descriptive activity names to name the activities in the data set

activities <- read.table("activity_labels.txt")
y_data[, 1] <- activities[y_data[, 1], 2]
names(y_data) <- "activity"

## Appropriately labels the data set with descriptive variable names

names(subject_data) <- "subject"
full_data <- cbind(x_data, y_data, data)

## Create a second, independent tidy data set with the average of each variable for each activity and each subject
averages_data <- ddply(full_data, .(subject, activity), function(x) colMeans(x[, 1:66]))
write.table(averages_data, "averages_data.txt", row.name=FALSE)

## reset working director
setwd("C:/Users/Michelle/Documents/Coursera")