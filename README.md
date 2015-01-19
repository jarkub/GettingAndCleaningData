# GettingAndCleaningData
Final project for Getting and Cleaning Data course from JHU and Coursera

The script run.analysis.R will download the "Human Activity Recognition Using Smartphones Dataset Version 1.0" [1]. It joins the training and testing sets of data into a single dataset, selects only mean (mean()) and standard devation (std()) transformation variables. The results dataset tidy.txt includes the mean for each variable with the data grouped by subject id and activity.

Variable names were found in "features.txt"

Activity labels were found in "activity_labels.txt" and were joined to the data set based on the activity code column found in "y_train.txt" and "y_test.txt".

The "features" or measurements were found in "X_train.txt" and "X_test.txt"

The subject id column was found in "subject_train.txt"


[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012