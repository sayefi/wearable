# Getting and Cleaning Data Course Project
### Prepared by: Sayef Ishaque

## The assignment ask to process accelerometer data collected from wearable device (Samsung Galaxy S smartphone) for number of subjects (wearer) and activities. 

## Prerequisite
### The data files has to be downloaded in R Project folder and unzipped. A folder name ? is created within the project folder
### The working directory is set to the project folder (at the begining of the analysis script)

## Important Input files
### List of activities -
### Descriptive name of measurements - 
### Accelerometer data organized in two folders Test & Train - 
### * Each of them has a associated subject file - 


## Data Processing script - run_analysis.R

### Step 1 - Merges the training and the test sets to create one data set.
### * Read the dataset from file
### * Merge the dataset using rbind() 

### Step 2 - Extracts only the measurements on the mean and standard deviation for each measurement.
### * Read name of measurements from file
### * Apply the name of measurement as column names on merged dataset
### * Extract a vector of mesurement names which has mean or std using grep function
### * subset the merged dataset with measurement names

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
### * Set appropriate column names using measurement names (step 2)
### * Apply activity names (Step 3)
### * Write output to file - output2.txt

## Output files
### output1.txt - Mean and Standard deviation (only) for all observations (?x observations)
### output2.txt - Mean of all veriables grouped by subject and activity (?x rows)

## End


