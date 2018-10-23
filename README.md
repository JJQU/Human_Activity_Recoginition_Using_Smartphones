# Human_Activity_Recoginition_Using_Smartphones
This project is using the data set provided by UCI. The data was collected for an experiment in which 30 volunteers conducted 6 different activities and the acceletometers on Samsung Galaxy S smartphone that attached on each volunteer's waist collected all the data. 
First, zip file for this data set was loaded from the website and then unzipped to local file in the working directory. 
Also, in this step, features.txt is read in R by read.table function and then feature names are standadized using gsub function.
Second, training and test data sets are loaded into R using read.table function. Measurement assigned to each variables during this stage.
Thirdly, training and test sets are merged to create one data set, using rbind function
Feature_Mean_Std vector is created to contain the position of columns that contain only the mean and std for each meansurment using grep("(mean|std)\\(\\)", Features[, "FeatureName"])
Extract mean (mean()) and standard deviation (std()) columns from the merged data set, Extracted <- Merged[,c(Feature_Mean_Std)]
Read activity_labels.txt into Rstudio, and created a factor with 6 levels and activity names. levels = ActivityLabel[["Index"]], labels = ActivityLabel[["ActivityName"]]. And then assign ActivityName to the merged data set.
Finally, a new independent tidy data set is created by using write.csv function. The step requires reshape2 package. The merged data set is reshaped to get the average of each variable. melt(Merged, id = c("subject", "label")); dcast(Melted, subject + label~variable, mean)
