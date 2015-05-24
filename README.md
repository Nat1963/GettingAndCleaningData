# GettingAndCleaningData
Project for Creating Tidy Data

A. Explanation of procedures and workings of 'run_analysis.R'

  I. Source of Data (From Samsung)
  
    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

 II. Files Read into the 'run-analysis.R' program from the unzipped files above:
    - subject_test.txt -> SubjectTest represents a data set of the subjects involved in the Test Group (1 - 30)
        with 2947 records
    - subject_train.txt -> SubjectTrain represents a data set of the subjects involved in the Training Group (1 - 30)
        with 7352 records
    - activity_labels.txt -> activityLabels represents a data set with a numeric code (1 - 6) representing the 
        particular activity being performed by each subject - ( 1 - Walking, 2 - Walking Upstairs, 3 - Walking downstairs,
        4 - Sitting, 5 - Standing, 6 - Laying)
    - Y_test.txt -> YTest represents the activity code for each of the 2947 records of the test group
    - Y_train.txt -> YTrain represents the activity code for each of the 7352 records of the training group
    - X_test.txt -> XTest represents a data frame that gives 561 variables showing relevant measures for the 2947 observations
                    of the test group
    - X_train.txt -> XTrain represents a data frame that gives 561 variables shoing relevant measures for the 7352 observations
                    of the training group
    - Features.txt -> features represents the features labels for each of the variables for XTest and XTrain data sets
    
III. Procedures and Goals of the 'run_analysis.R program'

    -- The main goal of the program is to merge the XTest and XTrain datasets with appropriate variable labels, and then
       subsequently extract (by select function) those variables ending in '-std() and '-mean(). From this extracted
       data set, we can finally derive a summary dataframe giving averages of each extracted variable by Subject and by 
       Activity
       
    -- Procedures
        1. Read in the relevant files (See II above).
        2. YTest and YTrain only consist of Activity code numbers, so each of these were joined with the activityLabels
           file to form YTest2 and XTest2 showing descriptive Activity Lables.
        3. XTest and XTrain files had their standard 'v1' .. 'v561' column headings replaced with the features labels to
           give a greater descriptive quality for these measures
        4. A cbind was performed (subjectTrain with XTrain and SubjectTest with XTest) so that subjects could be 
           associated with the particular observation in the measurement set. The new sets resulting are XTrain2 and XTest2
        5. A cbind was performed (YTest2 with XTest2 and YTrain2 with XTrain2) so that activities from the Y files could
           be associated with both the observations from the Training and Test sets. The resulting sets are XTrain3 and XTest3
        6.  An rbind was performed (between XTrain3 and XTest3) forming MergedSet to give a completed set of observations with
           10299 (7352 + 2947) records.
        7. extract by plyr's select function, relevant variables having an ending of '-mean()' or '-std()' and then 
           cbind the result with other relevant variables required to form the set MergedSet2.
        8. Using the Group_by and Summarise functions, we get the TinyDataFinal showing the results of summarizing - 
           mean by Subject by activity for each of the -mean() and -std() variables. Thus, we have a mean of means and a 
           mean of std. there are 21 columns in this data frame.
  
  IV. Codebook
  
  The TidyDataFinal data frame is a summarization of measures by subject by activity.
  
  variables (columns)
  
    Subject - Subject no (1 to 30) each subject performs various tasks
    Activity - the particular descriptive label for the activity
    Act_No - the original code number for the activity (1 to 6)
    tBodyAccMag-mean()
    tGravityAccMag-mean()
    tBodyAccJerkMag-mean()
    tBodyGyroMag-mean()
    tBodyGyroJerkMag-mean()
    fBodyAccMag-mean()
    fBodyBodyAccJerkMag-mean()
    fBodyBodyGyroMag-mean()
    fBodyBodyGyroJerkMag-mean()
    * each of these measures represent the mean of the means as categorized by Subject and Activity
    
    tBodyAccMag-std()
    tGravityAccMag-std()
    tBodyAccJerkMag-std()
    tBodyGyroMag-std()
    tBodyGyroJerkMag-std()
    fBodyAccMag-std()
    fBodyBodyAccJerkMag-std()
    fBodyBodyGyroMag-std()     
    fBodyBodyGyroJerkMag-std()" 
    * each of these measures represent the mean of the Stds as categorized by Subject and Activity
    
    
