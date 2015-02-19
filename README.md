

HOW THE SCRIPT WORKS

Note1: If you want to run my run_analysis.R script in your computer you should adapt the files location to your own
work directory organization.

Note2: during the all process of coding  I often used the head(), tail()
and str() commands to check the data periodically but those steps for the sake of legibility are not
printed here. 

Sequently runs like this:

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
- reorder the data frame, first by activity, second by subject
- categorize the "subject" variable
- call the "reshape2" package
- melt the previous data set into a long-format data set
- cast the previous data set
- export the tidy data set to a text format
- read and review the text file back to confirm the result
