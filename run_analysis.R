# Step 1 -- Read in the relevant files
subjectTest<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
XTest<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
YTest<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/Y_test.txt")
subjectTrain<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
XTrain<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
YTrain<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/Y_train.txt")
features<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt")
activityLabels<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")

# Step 2 -- Join Activity labels to both YTrain and YTest and change variable names to
            # descriptive names
library(plyr)  # load plyr library in order to join data frames
YTrain2<-arrange(join(activityLabels,YTrain),V1)
YTest2<-arrange(join(activityLabels,YTest),V1)
names(YTest2)<-c('Act_No','Activity')
names(YTrain2)<-c('Act_No','Activity')

#step 3 -- change variable names of XTrain and XTest to have descriptive names
names(XTrain)<-features[,2]
names(XTest)<-features[,2]

#step 4 -- Join SubjectTrain to XTrain by cbind, as there is no common variables to join on, 
          # also join SubjectTest to XTest by same manner. Also change the new variable [,1] of each
          # to subject
XTrain2<-cbind(subjectTrain,XTrain)
XTest2<-cbind(subjectTest,XTest)
names(XTrain2)[1]="Subject"
names(XTest2)[1]="Subject"

#Step 5 -- Join YTest2 data frame with XTest2 by cbind as there is no common variable to join on,
           # also join YTrain2 to XTrain2 in a similar fashion

XTrain3<-cbind(YTrain2,XTrain2)
XTest3<-cbind(YTest2,XTest2)

#Step 6 -- now merge both XTrain3 with XTEST3 for a complete set
MergedSet<-rbind(XTrain3,XTest3)
MergedSet<-MergedSet[,unique(names(MergedSet))] #There seems to be duplicate names in data set
#This new MergedSet only inculdes unique names. These duplicate column names concern the -bandsEnergy() 
#columns and do not have mean or std() variable names, thus they can be disregarded anyhow.

#Step 7 -- Extract columns from MergedSet that have '-std()' or '-mean()' ending in variable names
MergedSub1<-select(MergedSet,1:3) # select Activity_No, Activity, and Subject variables
MergedSub2<-select(MergedSet,ends_with("-mean()"))  # select variables ending in "-mean()"
MergedSub3<-select(MergedSet,ends_with('-std()'))   # select variables ending in "-std()"
MergedSet2<-cbind(MergedSub1,MergedSub2,MergedSub3)

#Step 8 -- Create a TidyData Set, that shows the mean of the variables from the MergedSet2 data frame by Activity
TidyDataFinal<-group_by(MergedSet2,Subject,Activity) %>% summarise_each(funs(mean)) #Groups MergedSet by the factors Subject and Activity and
                      # determines the means of the varibles based by grouping
write.table(TidyDataFinal,file="./data/TidyData.txt",row.names=FALSE)
