

library(dplyr)
library(reshape2)


#1. Merges the training and the test sets to create one data set
##set working directory
##download file from the url for the project
##unzip the file

getwd()
setwd("C:/Users/JJQ/Desktop")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "UCI HAR Dataset.zip", method = "curl")
unzip(zipfile = "UCI HAR Dataset.zip")

##load features file. Fix feature names for explicity. 
Features <- read.table("C:/Users/JJQ/Desktop/UCI HAR Dataset/features.txt", col.names = c("id", "FeatureName"))
measurements <- gsub('[()]', '', Features[,"FeatrueName"])
measurements

#load train datasets
##a.load X_train and assign feature name to each column
##b.load y_train
##c.load subject_train
##d.combine a.b.c to create a train dataset

Xtrain <- read.table("C:/Users/JJQ/Desktop/UCI HAR Dataset/train/X_train.txt")
colnames(Xtrain) <- measurements
ytrain <- read.table("C:/Users/JJQ/Desktop/UCI HAR Dataset/train/y_train.txt", col.names = "label")
subject_train <- read.table("C:/Users/JJQ/Desktop/UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
train <- cbind(Xtrain, ytrain, subject_train)


#load test datasets
##a.load X_test and assign feature name to each column
##b.load y_test
##c.load subject_test
##d. combine a.b.c to create a test dataset
Xtest <- read.table("C:/Users/JJQ/Desktop/UCI HAR Dataset/test/X_test.txt")
colnames(Xtest) <- measurements
ytest <- read.table("C:/Users/JJQ/Desktop/UCI HAR Dataset/test/y_test.txt", col.names = "label")
subject_test <- read.table("C:/Users/JJQ/Desktop/UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
test <- cbind(Xtest, ytest, subject_test)


##merge two data sets together to create one data set
Merged <- rbind(train, test)


#2.Extracted only the measurements on the mean and standard deviation for each measurement
Feature_Mean_Std <- grep("(mean|std)\\(\\)", Features[, "FeatureName"])
Feature_Mean_Std


Extracted <- Merged[,c(Feature_Mean_Std)]



#3. Uses descriptive activity names to name the activities in the data set

ActivityLabel <- read.table("C:/Users/JJQ/Desktop/UCI HAR Dataset/activity_labels.txt", col.names = c("Index", "ActivityName")) 
Merged[["label"]] <- factor(Merged[, "label"], levels = ActivityLabel[["Index"]], labels = ActivityLabel[["ActivityName"]])

#4. Appropriately labels the data set with descriptive variable names
#proper variable names assigned to train data set and test data set seperately while loading these two data sets
colnames(Merged) <- measurements

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
Merged$subject <- rownames(Merged)
Melted <- melt(Merged, id = c("subject", "label"))
Melted <- dcast(Melted, subject + label~variable, mean)

write.csv(Melted, file = "tidy_data.csv", quote = FALES)