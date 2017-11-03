Codebook
========
The Codebook is a list that describes the variables, the data, and any transformations or work that you performed to clean up the data

Variable list and descriptions
------------------------------

Variable name    | Description
-----------------|------------
subject          | Subject who performed the activity for each window sample
activity         | Name of the Activity
features         | Features of the activity such as Time/Frequency domain signal, instrument used, accelerations signal etc.

The Dataset
-----------------
* The site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The run_analysis.R script performs the following steps to clean the data and can be separate into two parts:

1. Load and combine the activity, subject, and feature test and training data sets respectively.
  i) Load data sets using *read.table* function
  ii) Merge the test and training data sets into one through the *rbind* function
  iii) Additional cleanup/preparation such as changes factor levels to match activity labels and extracting the names of activity, subject and features columns
2. Extracts only the measurements on the mean and standard deviation for each measurement.
  i) Use the *grep* command to separate columns with std/mean data and subsets and *subset* function to choose the separated columns
  ii) Use *cbind* command to combine and create a variable data set for cleaning
  iii) Clarify the time and frequency variables by replacing the labels using *gsub* function
  iv) Summarize the variable data set using *aggregate*, and final data cleanup for non-aggregated subject and activity columns
3. Save the final data set as "Human Activity Recognition Using Smartphones Data Set.txt" using *write.table* 