## Please first read README file

#########################################################################
# data preparation
#########################################################################

#reading column names
kolumny<-read.table("UCI HAR Dataset/features.txt", sep=" ")

#read activity labels
ActLabels<-read.table("UCI HAR Dataset/activity_labels.txt", sep=" ")

#########################################################################
######reading TEST set
#########################################################################

#X_test.txt
TestData<-read.table("UCI HAR Dataset/test/X_test.txt")
  # Ad 4 Appropriately labels the data set with descriptive variable names.
  colnames(TestData) <- kolumny$V2

#y_test.txt
TestActivity<-read.table("UCI HAR Dataset/test/y_test.txt", sep=" ")

  # Ad 3 Uses descriptive activity names to name the activities in the data set
  #merge with labels
  library(dplyr)
  TestActivityL<-left_join(TestActivity, ActLabels)
  #setting names
  colnames(TestActivityL)[1] <- "ActivityID"
  colnames(TestActivityL)[2] <- "ActivityName"
 
  
#merging data & activity
TestDataAct<-cbind(TestActivityL, TestData)  

#subject_test.txt
TestWho<-read.table("UCI HAR Dataset/test/subject_test.txt", sep=" ")
  colnames(TestWho)[1] <- "PersonID"

#merging data, activity & person
TestDataActPers<-cbind(TestWho, TestDataAct)  

#setting the flag of TEST data
TestDataActPers$Scope<-"TEST"


#########################################################################
######reading TRAIN set
#########################################################################

#X_train.txt
TrainData<-read.table("UCI HAR Dataset/train/X_train.txt")
  # Ad 4 Appropriately labels the data set with descriptive variable names.
  colnames(TrainData) <- kolumny$V2
  
#y_train.txt
TrainActivity<-read.table("UCI HAR Dataset/train/y_train.txt", sep=" ")

  # Ad 3 Uses descriptive activity names to name the activities in the data set
  #merge with labels
  TrainActivityL<-left_join(TrainActivity, ActLabels)
  #setting names
  colnames(TrainActivityL)[1] <- "ActivityID"
  colnames(TrainActivityL)[2] <- "ActivityName"
  

#merging data & activity
TrainDataAct<-cbind(TrainActivityL, TrainData)  

#subject_test.txt
TrainWho<-read.table("UCI HAR Dataset/train/subject_train.txt", sep=" ")
colnames(TrainWho)[1] <- "PersonID"

#merging data, activity & person
TrainDataActPers<-cbind(TrainWho, TrainDataAct)  

#setting the flag of TRAIN data
TrainDataActPers$Scope<-"TRAIN"


#################################################################
## building one big dataset
#################################################################
#Ad 1. Merges the training and the test sets to create one data set.
BigData<-rbind(TrainDataActPers, TestDataActPers)

#################################################################
## substracting columns concerning mean & std
#################################################################
# Ad 2. Extracts only the measurements on the mean and standard deviation for each measurement.

# mean() & std() without meanFreq()
ColumnsToPick<-c("Scope", "PersonID", "ActivityID", "ActivityName", 
                 grep("mean\\(\\)|std\\(\\)",kolumny$V2, value = TRUE))

BigDataMStd <-subset(BigData, select=ColumnsToPick)

#################################################################
## building new dataframe with summary
#################################################################
#Ad 5. From the data set in step 4, creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject.

BigDataAggr<-aggregate(BigDataMStd[, 5:50], list(BigDataMStd$ActivityName, 
                                      BigDataMStd$PersonID),mean)
#renaming default columns
colnames(BigDataAggr)[1] <- "ActivityName"
colnames(BigDataAggr)[2] <- "PersonID"



