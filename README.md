# Getting and Cleaning Data Course Project
### Prepared by: Sayef Ishaque

## Data Processing script - run_analysis.R

## Instructions
* Download the script run_analysis.R from GitHub
* Set the working directory and put the script in the working direcotry
* The script will download the input dataset from the link provided (if "UCI HAR Dataset" doesn't exists in working direcotry already)
* The script assumes that 'dplyr' package is installed
* The output is generated in output.txt




## Important Input files
### List of activities - 'UCI HAR Dataset/activity_labels.txt'
### Descriptive name of measurements - 'UCI HAR Dataset/features.txt' 
### Accelerometer data organized in two folders Test & Train -
* 'UCI HAR Dataset/test/X_test.txt'
* 'UCI HAR Dataset/train/X_train.txt'
* Both data files have associated subject and activity file
* Subjects in Test -'UCI HAR Dataset/test/subject_test.txt' 
* Activity in Test -'UCI HAR Dataset/test/Y_test.txt' 
* Subjects in Train -'UCI HAR Dataset/train/subject_train.txt' 
* Activity in Train -'UCI HAR Dataset/train/y_train.txt' 


## Step 1 - Merges the training and the test sets to create one data set.
* Read the dataset from file
* Merge the dataset using cbind() and rbind()


## Step 2 - Extracts only the measurements on the mean and standard deviation for each measurement.
* Read name of measurements from file
* Apply the name of measurement as column names on merged dataset
* Extract a vector of mesurement names which has mean or std using grep function
* subset the merged dataset with measurement names


## Step 3 - Uses descriptive activity names to name the activities in the data set
* Read name of activities from file
* Convert the activity column to factor and apply lebels of the factor from activity file


## Step 4 - Appropriately labels the data set with descriptive variable names
* Tidy up column names assinged in step 2



## Step 5 - Creates an independent tidy data set with the average of each variable for each activity and each subject
* using dplyr group_by function, group the data by subjectId and activityId
* summerize with mean
* write output to output.txt


## End


