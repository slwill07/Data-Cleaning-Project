library(dplyr)

## Create a directory for the project, download, and unzip the data files.

if (!file.exists("DCProject")) {dir.create("./DCProject")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "C:\\Users\\Shanon\\Documents\\DCProject\\ProjectWK4.zip")
setwd("C:\\Users\\Shanon\\Documents\\DCProject")
filename <- "C:\\Users\\Shanon\\Documents\\DCProject\\ProjectWK4.zip"
unzip(filename, exdir = "C:\\Users\\Shanon\\Documents\\DCProject\\SmartPhoneFiles")

## Reading the data from the UCI HAR Dataset files.

features <- read.table("SmartPhoneFiles/UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("SmartPhoneFiles/UCI HAR Dataset/activity_labels.txt", col.names = c("activityID", "activity"))
trainingData <- read.table("SmartPhoneFiles/UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
trainingActivity <- read.table("SmartPhoneFiles/UCI HAR Dataset/train/y_train.txt", col.names = "activityID")
trainingSubjects <- read.table("SmartPhoneFiles/UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
testData <- read.table("SmartPhoneFiles/UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
testActivity <- read.table("SmartPhoneFiles/UCI HAR Dataset/test/y_test.txt", col.names = "activityID")
testSubjects <- read.table("SmartPhoneFiles/UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

## Merges the training and test sets to create one data set. 

Data <- rbind(trainingData, testData)
Activity <- rbind(trainingActivity, testActivity)
Subject <- rbind(trainingSubjects, testSubjects)
mergedData <- cbind(Subject, Activity, Data)

## Extracts only the measurements of the mean and standard deviation for each measurement.

meanStandardData <- mergedData %>% select(subject, activityID, contains("mean"), contains("std"))

## Use descriptive activity names to name the activities in the data set.

meanStandardData$activityID <- activities[meanStandardData$activityID, 2]

## Appropriately label the data set with descriptive variable names.

names(meanStandardData)[2] = "activity"
names(meanStandardData)<-gsub("Acc", "Accelerometer", names(meanStandardData))
names(meanStandardData)<-gsub("Gyro", "Gyroscope", names(meanStandardData))
names(meanStandardData)<-gsub("BodyBody", "Body", names(meanStandardData))
names(meanStandardData)<-gsub("Mag", "Magnitude", names(meanStandardData))
names(meanStandardData)<-gsub("^t", "Time", names(meanStandardData))
names(meanStandardData)<-gsub("^f", "Frequency", names(meanStandardData))
names(meanStandardData)<-gsub("tBody", "TimeBody", names(meanStandardData))
names(meanStandardData)<-gsub("-mean()", "Mean", names(meanStandardData), ignore.case = TRUE)
names(meanStandardData)<-gsub("-std()", "STD", names(meanStandardData), ignore.case = TRUE)
names(meanStandardData)<-gsub("-freq()", "Frequency", names(meanStandardData), ignore.case = TRUE)
names(meanStandardData)<-gsub("angle", "Angle", names(meanStandardData))
names(meanStandardData)<-gsub("gravity", "Gravity", names(meanStandardData))

## Create a second, independent tidy data set with the average of each variable for each activity and each subject.

tidyData <- meanStandardData %>%
    group_by(subject, activity) %>%
    summarise_all(funs(mean))
write.table(tidyData, "TidyData.txt", row.name = FALSE)



