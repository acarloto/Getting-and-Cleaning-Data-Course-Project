README FILE

Contains the codebook and a description of how the run_analysis.R script works.

CODEBOOK

This getting and cleaning data project was based in work done by the Smartlab - Non Linear Complex Systems Laboratory
(www.smartlab.ws) in Genova.The experiments which generated the data sets (Human Activity Recognition Using Smartphones Dataset 
Version 1.0)  were carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each subject performed six 
activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) 
on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity were 
captured at a constant rate of 50Hz. The experiments were video-recorded to label the data manually. The obtained data set was 
randomly partitioned into two sets, where 70% of the volunteers (21) was selected for generating the training data and 30% (9) 
the test data.

The data set provided to us (UCI HAR Dataset), contained the files regarding the 9 volunteers providing the test data 
(test folder) and the 21 volunteers providing the training data (train folder). In the test folder we found three files 
"subject_test_x", "X_test.txt" and "y_text.txt" wich contained, respectivily, the numbers coding the subjects of the experiment, 
a data set of the 561 variables measured for each subject-activity and the numbers coding the type of activity performed.
In the train folder we found similar files for the train group. We also had to use the files "activity_labels.txt" and the 
"features.txt" wich contained, respectivily, the labels for the activity and variables codes. Basically, we had to join all of 
this data in a unique data set, striped from the variables which were not related to mean values or standard deviation values. 
This first data set contained 10299 observations for 2 categorical variables (factors) named "subject" (30 levels - 1:30) 
and "activity" (6 levels - WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING ) and 79 numeric variables
of measured and processed data. The interpretation of each of this 79 variables can be done using the following abbreviations:

    - t - time
    - f - frequency obtained from Fourier Transforms - FFT
    - Body - signals from the body of the subject
    - Gravity - signals from the gravity field
    - Acc - aceleration data
    - Gyro -angular velocity data
    - Jerk - Acc or Gyro data derived in time
    - Mag - magnitude values calculated using the Euclidean norm
    - X, Y or Z - spatial axial orientations
    - mean() - mean value
    - std() - standard deviation
    
As such, for example, tBodyAccJerk-mean()-X is the mean of the jerk of the accelaration of the body in time, along the X axis, 
and tGravityAccMag-std() is the standard deviation of the calculated magnitude of the gravity accelaration in time.

Based in this first data set we build, we created a second, independent tidy data set with the average of each variable 
for each subject and each activity (the name of the variables remained the same, but this time represent average values). 
This final data set named "tidy" included 180 observations from 81 variables. All the R code necessary for obtaining this 
final "tidy" data set is presented in a script called "run_analysis.R" also uploaded to this repository.

HOW THE SCRIPT WORKS

Note: during the all process I often used the head(), tail()
and str() commands to check the data but those steps for the sake of legibility are not
printed here. Sequently:

- create directory for the files
- call "downloader" package
- download and unzip the files
- attach in each data set (train and test) the files of interest to their paths
- read the files of interest
- bind the two sets of data frames by column
- bind the test data frame on the top of the train data frame
- call the "dplyr" package
- select the columns of subject, activity and means and standard deviations of the measures
- read the features file and make a vector with the names
- name the columns in the merged data frame with the selected labels
- read the activity file and make a vector with the names
- categorize the "activity" variable by the five types of activity
- reorder the data frame, first by subject, second by activity
- categorize the "subject" variable
- call the "reshape2" package
- melt the previous data set into a long-format data set
- cast the previous data set
- export the tidy data set to a text format

