# Getting and Cleaning Data Course Project
### Prepared by: Sayef Ishaque



## Data Processing script - run_analysis.R

## Instructions
### * Download the script run_analysis.R from GitHub
### * Set the working directory and put the script in the working direcotry
### * The script will download the input dataset from the link provided 
### * The script assumes that "dplyr" package is installed
### * The output is generated in output.txt


library(dplyr)

if(!dir.exists("UCI HAR Dataset")){
     fileUrl<-
          "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
     download.file(fileUrl,"input.zip","curl")
     
     unzip("input.zip")
}

## Important Input files
### List of activities - "UCI HAR Dataset/activity_labels.txt"
### Descriptive name of measurements - "UCI HAR Dataset/features.txt" 
### Accelerometer data organized in two folders Test & Train -
### * "UCI HAR Dataset/test/X_test.txt"
### * "UCI HAR Dataset/train/X_train.txt"
### Both data files have associated subject and activity file
### * Subjects in Test -"UCI HAR Dataset/test/subject_test.txt" 
### * Activity in Test -"UCI HAR Dataset/test/Y_test.txt" 
### * Subjects in Train -"UCI HAR Dataset/train/subject_train.txt" 
### * Activity in Train -"UCI HAR Dataset/train/y_train.txt" 



### Step 1 - Merges the training and the test sets to create one data set.
### * Read the dataset from file
### * Merge the dataset using cbind() and rbind()

x_train<-read.table("UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("UCI HAR Dataset/train/y_train.txt")
subjects_train<-read.table("UCI HAR Dataset/train/subject_train.txt")

trainData<-cbind(subjects_train,y_train,x_train)

x_test<-read.table("UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("UCI HAR Dataset/test/Y_test.txt")
subjects_test<-read.table("UCI HAR Dataset/test/subject_test.txt")

testData<-cbind(subjects_test,y_test,x_test)

mergedData<-rbind(trainData,testData)

### Step 2 - Extracts only the measurements on the mean and standard deviation for each measurement.
### * Read name of measurements from file
### * Apply the name of measurement as column names on merged dataset
### * Extract a vector of mesurement names which has mean or std using grep function
### * select appropriate variables with measurement names

measurements<-read.table("UCI HAR Dataset/features.txt", 
                         stringsAsFactors = FALSE)

colnames(mergedData)<-c("subjectId","activityId",measurements$V2)

impCols<-grep("Id$|mean|std",colnames(mergedData),value = TRUE)

mergedData<-mergedData[,impCols]


### Step 3 - Uses descriptive activity names to name the activities in the data set
### * Read name of activities from file
### * Convert the activity column to factor and apply lebels of the factor from activity file

activities<-read.table("UCI HAR Dataset/activity_labels.txt",
                       stringsAsFactors = FALSE)
mergedData$activityId<-as.factor(mergedData$activityId)
levels(mergedData$activityId)<-activities$V2

### Step 4 - Appropriately labels the data set with descriptive variable names
### * Tidy up column names assinged in step 2

impCols<-gsub("-","",impCols)
impCols<-gsub("\\(","",impCols)
impCols<-gsub("\\)","",impCols)
impCols<-gsub("mean","Mean",impCols)
impCols<-gsub("std","Std",impCols)
colnames(mergedData)<-impCols


### Step 5 - Creates an independent tidy data set with the average of each variable for each activity and each subject
### * using dplyr group_by function, group the data by subjectId and activityId
### * summerize with mean
### * write output to output.txt

mergedData$subjectId<-as.factor(mergedData$subjectId)
output<-mergedData%>%group_by(subjectId,activityId)%>%summarise_all(mean)

write.table(output,"output.txt")

## End