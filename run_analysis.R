run_analysis<-function()
{
        library(tidyverse)
        library(downloader)
        setwd("/Users/Andreas/Desktop/R-Files/DataScienceSpec_Course3-GettingandCleaningData/Course Project/Getting-and-Cleaing-Data-Project")
        
        #download and unzip data
        fileurl="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileurl,destfile="./UCI HAR Dataset.zip")
        unzip ("./UCI HAR Dataset.zip", exdir = "./")
        
        #load files
        trainlabel <- read.table("./UCI HAR Dataset/train/y_train.txt")
        traindata <- read.table("./UCI HAR Dataset/train/X_train.txt")
        trainsubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
        testlabel <- read.table("./UCI HAR Dataset/test/y_test.txt")
        testdata <- read.table("./UCI HAR Dataset/test/X_test.txt")
        testsubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
        
        #1. join data: Merges the training and the test sets to create one data set.
        joindata <- rbind(traindata, testdata)
        joinlabel <- rbind(trainlabel, testlabel)
        joinsubject <- rbind(trainsubject, testsubject)
        
        
        #2. Extracts only the measurements on the mean and standard deviation for each measurement
        features <- read.table("./UCI HAR Dataset/features.txt")
        indices <- grep("mean|std", features[, 2]) #using varible "features" alone does not work;important to look at variable before using it! 
        extractdata<-joindata[,indices]
        names(extractdata) <- features[indices,2]
        names(extractdata) <- gsub("\\(\\)","",names(extractdata)) #remove parentesis use "\\(" to regocnise a parentesis and reapeat to close parentesis
        
        #3.Uses descriptive activity names to name the activities in the data set
        activity <- read.table("./UCI HAR Dataset/activity_labels.txt")
        activity[,2] <- tolower(activity[,2]) #Make variable names lower case
        activity[,2] <- gsub("_","",activity[,2]) #remove "_" in variable names
        activitylabel <- activity[joinlabel[, 1], 2] #create activity label that replaces activity-numbers with activity names
        joinlabel[, 1] <- activitylabel #replace number labels with activity names
        names(joinlabel) <- "activity" #Name Column
        
        #4. Appropriately labels the data set with descriptive variable names. 
        names(joinsubject) <- "subject" #Name Column
        cleandata<- cbind(joinsubject,joinlabel,extractdata) #Create cleaned dataset that contains all data
        #View(cleandata)
        write.table(cleandata, "alldata.txt")
        
        #5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
        ##Without Piping
        #grouped<-group_by(cleandata,subject,activity)
        #tidydata<-summarize_at(grouped,names(extractdata),mean,na.rm=TRUE)
        ##With Piping
        tidydata<- cleandata %>%
                group_by(subject,activity) %>% #make sure data is grouped correctly
                summarize_at(names(extractdata),mean,na.rm=TRUE) #select columns to be summarized with summarize_at command and calculate the mean of each column
        #View(tidydata) #contains average of each variable for each activity and each subject: 30subjects x 6 activities = 180 rows
        write.table(cleandata, "tidydata.txt")
}
