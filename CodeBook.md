title: Codebook for run_analysis.R
date: 2019-07-23 

# Data report overview
The run_analysis script collects, organizes, labels, and manipulates the UCI HAR Dataset. The goal is to prepare tidy data that can be used for later analysis.

# The dataset examined has the following dimensions:
---------------------------------
Feature                    Result
------------------------ --------
Number of observations      10299

Number of variables           563
---------------------------------


# Used 8 datasets from the UCI HAR Dataset information, their variable setup is as follows:       

Table Name            Dataset Name                   Dimensions                 Contains
features              features.txt               561 rows, 2 columns      The accelerometer and gyroscope 3-axial                                                                            raw signals tAcc-XYZ and tGyro-XYZ.
activities            activity_labels.txt        6 rows, 2 columns        Activities being performed.  

testSubjects          test/subject_test.txt      2947 rows, 1 column      Data of 9/30 test volunteer subjects.

testData              test/X_test.txt            2947 rows, 561 columns   Recorded features of test data.

testActivity          test/y_test.txt            2947 rows, 1 columns     Activities code labels for test data.

trainingSubjects      train/subject_train.txt    7352 rows, 1 column      Data of 21/30 train volunteer subjects. 

trainingData          train/X_train.txt          7352 rows, 561 columns   Recorded features of train data.

trainingActivity      train/y_train.txt          7352 rows, 1 columns     Activities code labels for train data.
 
# Merges the training and the test sets to create one data set

Data             10299 rows, 561 columns        Merging X_train and X_test using rbind() function
Activity         10299 rows, 1 column           Merging y_train and y_test using rbind() function
Subject          10299 rows, 1 column           Merging subject_train and subject_test using rbind() function
mergedData       10299 rows, 563 column         Merging Subject, Activity, and Data using cbind() function

# Extracts only the measurements on the mean and standard deviation for each measurement

meanStandardData      10299 rows, 88 column 
Subsetting mergedData, selecting columns: subject, activityID, and the measurements on the mean and standard deviation (std) for each measurement.

# Appropriately labels the data set with descriptive variable names

Numbers in activityID column of the meanStandardData replaced with corresponding activity taken from second column of the  activities variable, and named the column activity
All Acc in column names replaced by Accelerometer
All Gyro in column names replaced by Gyroscope
All BodyBody in column names replaced by Body
All Mag in column names replaced by Magnitude
All column names starting with f replaced by Frequency
All column names starting with t replaced by Time

# Created a second, independent tidy data set with the average of each variable for each activity and each subject.

tidyData       180 rows, 88 columns 
Grouped by subject and activity from meanStandardData and summarising by taking the means of each variable.  then wrote that to a TidyData.txt file.


