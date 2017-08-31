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


