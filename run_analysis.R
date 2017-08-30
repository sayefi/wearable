


x_train<-read.table("UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("UCI HAR Dataset/train/y_train.txt")

x_test<-read.table("UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("UCI HAR Dataset/test/y_test.txt")

train_subjects<-read.table("UCI HAR Dataset/train/subject_train.txt")
test_subjects<-read.table("UCI HAR Dataset/test/subject_test.txt")
activities<-read.table("UCI HAR Dataset/activity_labels.txt")

head(x_train,10)

str(x_train)

rownames(x_train)

str(y_train)

dim(x_train)

dim(y_train)

dim(subjects)

dim(activities)


## ---------------------------------------------------------------
## Load activity labels

activities<-read.table("UCI HAR Dataset/activity_labels.txt",
                       stringsAsFactors = FALSE)

colnames(activities)<-c("id","name")

# fActivities<-factor(levels=activities$id,labels = activities$name)
# fActivities["WALKING"]

# str(fActivities)
# 
# attributes(fActivities)



## -------------------------------------------------------
## Lebel activity lebels in training dataset as factor

y_train<-read.table("UCI HAR Dataset/train/y_train.txt")

y_train$V1<-as.factor(y_train$V1)

levels(y_train$V1)<-activities$name

colnames(y_train)<-c("activityName")

y_train$activityName

## ----------------------------------------------------------
## Load features and x_train data 

features<-read.table("UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)

x_train<-read.table("UCI HAR Dataset/train/X_train.txt")



str(x_train)

## ---------------------------------------------------------
## Merge subject and activity with x_train
## Assign appropriate column names
train_subjects<-read.table("UCI HAR Dataset/train/subject_train.txt")
train_subjects$V1<-as.factor(train_subjects$V1)
colnames(train_subjects)<-c("subjectId")

x_train<-cbind(train_subjects$subjectId,y_train$activityName,x_train)

colnames(x_train)<-c("subjectId","activityName",features$V2)

