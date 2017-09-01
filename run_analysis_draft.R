

fileUrl<-
     "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,"input.zip","curl")

unzip("input.zip")

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

head(x_train)

str(x_train)

impMeasures<-grep("mean|std",names(x_train),value = TRUE)

#impMeasures<-c("fBodyGyro-mean()-Y","fBodyBodyGyroJerkMag-kurtosis()")



output<-x_train[,c("subjectId","activityName",impMeasures)]

## step 5 on small data
# output<-head(output, 200)

names(output)

head(output)

str(output)

library(plyr)

dim(output)

output<-mutate(output, key<-paste(output$subjectId,output$activityName,sep=" + "))


colnames(output)[length(output)]<-"Key"
output

splittedSubnAct<-split(output,output$Key )

splittedSubnAct

splittedSubnAct[[1]][c(1,3)]

impMeasures

a<-colMeans(splittedSubnAct[[1]][,impMeasures])
str(a)
b<-as.vector(a)
b
c<-cbind("my row", "text",rbind(b))
c[1,1:5]

dim(splittedSubnAct)
head(splittedSubnAct)
splittedSubnAct[[1]][,3]

colMeans(splittedSubnAct[[1]][,impMeasures])

funMean<-function(x){
     r<-as.vector(colMeans(x[,impMeasures]))
     r<-cbind(x[1,1],x[1,2],rbind(r[1:length(r)]))
}
res<-lapply(splittedSubnAct,funMean)
res

result<-as.data.frame(do.call(rbind,res))

colnames(result)<-c("subjectId","activityName",impMeasures)
result$subjectId<-as.factor(result$subjectId)
result$activityName<-as.factor(result$activityName)
levels(result$activityName)<-activities$name

result

dim(result)

## ------------------------------------------------
output

library(dplyr)

output<-group_by(output,subjectId,activityName)
head(output,20)

output<-summarise_all(output,mean)
head(output,20)

# res
# 
# result<-unlist(res)
# result
# 
# str(result)
# 
# do.call(rbind,res)
# 
# 
# n<-length(result)
# state<-as.vector(names(result[1:n]))
# 
# resultDf<-as.data.frame(cbind(hospital,state))
# 
# unlistedres<-unlist(res)
# unlistedres
# names(res)
# r<-cbind(as.factor(res[1]))
# r
# str(res)
# 
# groupColumns = c("subjectId","activityName")
# #dataColumns = c("hr", "rbi","sb")
# res = ddply(output, groupColumns, function(x) colMeans(x[impMeasures]))
# 
# 
# head(res)
# 
# colMeans()
