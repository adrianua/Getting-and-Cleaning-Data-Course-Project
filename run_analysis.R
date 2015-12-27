library(dplyr)
library(tidyr)

list.files('./UCI HAR Dataset/test')

#----Merge----
#1. Merges the training and the test sets to create one data set.
X_test<-read.table('./UCI HAR Dataset/test/X_test.txt')
X_train<-read.table('./UCI HAR Dataset/train/X_train.txt')
X_full<-bind_rows(X_test, X_train)

#----Extracts----
#2. Extracts only the measurements on the mean and standard deviation for each measurement.
features<-read.table('./UCI HAR Dataset/features.txt')
colnames(features)<-c('col_number','col_name')

cols_to_filter<-
  features%>%
  filter(grepl('mean\\(\\)|std\\(\\)', col_name))

#select only needed columns
X_full<-select(X_full, cols_to_filter$col_number)
#...and add names
colnames(X_full)<-cols_to_filter$col_name

#check whether colnames are unique
length(unique(colnames(X_full)))==length(colnames(X_full))

#----Activity names----
#3. Uses descriptive activity names to name the activities in the data set
#bind activity ids from test and train
Y_test<-read.table('./UCI HAR Dataset/test/Y_test.txt')
Y_train<-read.table('./UCI HAR Dataset/train/Y_train.txt')
Y_full<-bind_rows(Y_test, Y_train)
colnames(Y_full)<-c('activity_id')
#read labels
activity_labels<-read.table('./UCI HAR Dataset/activity_labels.txt')
colnames(activity_labels)<-c('activity_id', 'Activity')
#join labels
Y_full_labeled<-inner_join(Y_full,activity_labels)
#bind to X_full
X_full<-bind_cols(Y_full_labeled, X_full)
X_full<-select(X_full, -activity_id)

#----Label variables----
#4. Appropriately labels the data set with descriptive variable names.

#use filtered features names 
cn<-cols_to_filter$col_name

#use regex to rename col names
cn <- gsub('^t', 'Time domain', cn)# t to Time domain
cn <- gsub('^f', 'Frequency domain', cn)# f to Frequency domain
cn <- gsub('BodyBody|Body', ' Body', cn)
cn <- gsub('Mag', ' Magnitude', cn)
cn <- gsub('Acc', ' Acceleration signal', cn)
cn <- gsub('Gyro', ' Gyroscope signal', cn)
cn <- gsub('Gravity', ' Gravity', cn)
cn <- gsub('Jerk', ' Jerk', cn)
cn <- gsub('\\-X', ' in X direction', cn)
cn <- gsub('\\-Y', ' in Y direction', cn)
cn <- gsub('\\-Z', ' in Z direction', cn)
cn <- gsub('(.*)\\-std\\(\\)(.*)', 'Standard deviation of \\1\\2', cn) #replace '-std()'  with 'Standard deviation of ' at at the start of the string
cn <- gsub('(.*)\\-mean\\(\\)', 'Mean value of \\1\\2', cn)#replace '-mean()'  with 'Mean value of ' at at the start of the string
colnames(X_full)<- c('Activity', cn)

#----Create Sumary---- 
#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#bind subject ids
subject_test<-read.table('./UCI HAR Dataset/test/subject_test.txt')
subject_train<-read.table('./UCI HAR Dataset/train/subject_train.txt')
subject_full<-bind_rows(subject_test,subject_train)
colnames(subject_full)<- c('Subject')

#add subject id to df
X_full<-bind_cols(subject_full,X_full)

#group by subject and activity, calculate average and transform to narrow tidy form
tidy<-X_full%>%
  group_by(Subject, Activity)%>%
  summarise_each(funs(mean))%>%
  gather(`Variable`, `Average of Variable Value`, -Activity, -Subject)

#export to tidy_dataset
write.table(tidy, 'tidy_dataset.txt', row.names = FALSE)

