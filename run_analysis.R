# Getting and Cleaning Data Course Project
### Prepared by: Sayef Ishaque

## The assignment ask to process accelerometer data collected from wearable 
##device (Samsung Galaxy S smartphone) for number of subjects (wearer) and activities. 

## Data Processing script - run_analysis.R

## Prerequisite
### * Download the script run_analysis.R from GitHub
### * Set the working directory and put the script in the working direcotry
### * The script will download the input dataset from the link provided (if  
### "UCI HAR Dataset" doesn't exists in working direcotry already)
### The script assumes that "dplyr" package is installed

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
### * subset the merged dataset with measurement names

measurements<-read.table("UCI HAR Dataset/features.txt", 
                         stringsAsFactors = FALSE)

colnames(mergedData)<-c("subjectId","activityId",measurements$V2)

impCols<-grep("Id$|mean|std",colnames(mergedData),value = TRUE)

mergedData<-mergedData[,impCols]


### Step 3 - Uses descriptive activity names to name the activities in the data set
### * Read name of activities from file
### * Convert the activity column to factor and apply lebels of the factor from activity file

### Step 4 - Appropriately labels the data set with descriptive variable names
### * As part of step 2, this is already accomplished (double check?)
### * Create an output file output1.txt 

### Step 5 - Creates an independent tidy data set with the average of each variable for each activity and each subject
### * Prepare raw dataset through Step 1(?)
### * Create a new column in the dataset using manipulate() function by combining subjectId and activityId
### * Split the dataset using the new column
### * Create a function which returns subjectId, activityId and mean of each measurement 
### * run lapply on splitted dataset with the above created function
### * Unlist the dataset using do.call and rbind

iris %>% group_by_("Species") %>%
     summarise_all(.funs = c(Mean="mean", Sd="sd"))
https://www.rdocumentation.org/packages/dplyr/versions/0.5.0/topics/summarise_all

### * Set appropriate column names using measurement names (step 2)
### * Apply activity names (Step 3)
### * Write output to file - output2.txt

## Output files
### output1.txt - Mean and Standard deviation (only) for all observations (?x observations)
### output2.txt - Mean of all veriables grouped by subject and activity (?x rows)

## End