This file contains information about the data and code sections, includeing variables and any transformations performed to clean up the data)


I. Data:
- Information about the data can be obtained from: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
- Data can be downloaded here:https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

II. Code
The code consists of a number of different sections:
- Section A: #download and unzip Data
- Section B: #load files
- Section #1. join data: Merges the training and the test sets to create one data set
- Section #2. Extracts only the measurements on the mean and standard deviation for each measurement
- Section #3. Uses descriptive activity names to name the activities in the data set
- Section #4. Appropriately labels the data set with descriptive variable names
-Section #5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

Section A: #download and unzip Data
- Downloads data from provided Url 
- Unzips data using the downloader package and stores data in the subfolder "UCI HAR Dataset"

Section B: #load files
- Loads all files and saves it in variables "XY"
- "X" stands for either train (data from training dataset) or test (data from test dataset)
- "Y" stands for subject, label or data
- Examples "trainlable" contains information of "y_train.txt"; "trainsubject" contains information of "subject_train.txt"; "testdata" contains information about "X_test.txt"

Section #1. join data: Merges the training and the test sets to create one data set
- joins data by rows to create three variables that represent "Y" from example above
- "Y" stands for subject, label or data
- Thus this step creates variables "joindata", "joinlabel", joinsubject"
- Performed sanity check to make sure dimensions of new variables are correct (not part of the code anymore)

Section #2. Extracts only the measurements on the mean and standard deviation for each measurement
- reads feature variables using read.table
- selects variables that contains "mean" or "std" with grep
- edits the variable names to remove parentesis

Section #3. Uses descriptive activity names to name the activities in the data set
- load the file activity_labels.txt with read.table command
- edit the variables (lower case and remove "_"
- create activity label that replaces activity-numbers with activity names 
- name column "activity

Section #4. Appropriately labels the data set with descriptive variable names.
- finish labeling of data: Label the subject column
- Create one dataset by binding variables column wise
- Optional: write complete dataset to "alldata.txt"

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
- Transform data using dplyr package (contained in tidyverse)
- used group_by command to group by subjects and activity (although data should already be in that order
- Calculate means with summarize command: select columns to be summarized with summarize_at command and calculate the mean of each column
- The tidy dataset contains the average of each variable for each activity and each subject 30subjects x 6 activities = 180 rows
- Save tidy data set as "tidydata.txt"
