# CodeBook 

This CodeBook describes the variables, the data, and transformations performed to clean up the original data and create tidy dataset.

## Original Dataset

Original Dataset was obtained from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The dataset is based on data collected from the accelerometers from the Samsung Galaxy S smartphone.

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope,  3-axial linear acceleration and 3-axial angular velocity were captured.

Please see full description here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  as well as in the `README.txt` included in the dataset (`/UCI HAR Dataset/README.txt`)

### Original Dataset includes the following files:

- 'README.txt': Describes original dataset and details of the experiment carried out.

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.


## Data Processing

Original Dataset was downloaded and unzipped to `UCI HAR Dataset` folder before processing.

Data processing was performed by `run_analysis.R` script, with the help of `dplyr` and `tidyr` libraries. The script performed the following steps:

1. Merged the training (`/UCI HAR Dataset/train/X_train.txt`) and the test (`/UCI HAR Dataset/test/X_test.txt`) sets to create one data set using `bind_rows`command. United dataset was named `X_full` and have 10299 rows and 563 columns.

2. Extracted only the measurements on the mean and standard deviation for each measurement. 
As names of measurements along with position of the respective columns in main dataset are stored in `/UCI HAR Dataset/features.txt` file, `grepl()` command with regex line `mean\\(\\)|std\\(\\)` was used to `filter` necessary measurements. Then respective columns were extracted from main dataset. As a result 66 measurements were used for further processing. 


3. Used descriptive activity names to name the activities in the data set. 

The script binded rows from training (`/UCI HAR Dataset/train/Y_train.txt`) and test (`/UCI HAR Dataset/test/Y_test.txt`) datasets, which store activity ids, and joins result with data from `/UCI HAR Dataset/activity_labels.txt`, which contains descriptive activity labels.
Result is binded with main dataset `X_full` using `bind_cols` command.

4. Appropriately labels the data set with descriptive variable names.

Based on `/UCI HAR Dataset/features_info.txt` codebook, included into Original Dataset, original column names `X_full` were replaced by more descriptive ones.

This task was accomplished by using gsub() command with respective regex lines.

5. From the data set in step 4, created a second, independent tidy data set with the average of each variable for each activity and each subject.
Using `dplyr`, `X_full` was grouped by Activity and Subject fields, then for each variable `mean` function was applied. Using `tidyr` variable names were gathered into one column, and dataset was transformed to narrow tidy form.

Result was exported to `tidy_dataset.txt` using write.table() with row.name=FALSE option.

It can be read to R by `read.table('tidy_dataset.txt')` command.

## Tidy Dataset 

Tidy dataset contains the average of each variable for each activity and each subject and have the following columns:

`Activity`: descriptive name of activity performed. Factor with 6 levels as follows:  

- "WALKING" 
- "WALKING_UPSTAIRS" 
- "WALKING_DOWNSTAIRS" 
- "SITTING" 
- "STANDING" 
- "LAYING" 

`Subject`: Identifier of Subject, Factor with 30 levels, represented by integer number in a range from 1 to 30. 
`Variable`: descriptive name of variable. Factor with 66 levels as follows:  

- "Mean value of Time domain Body Acceleration signal in X direction"
- "Mean value of Time domain Body Acceleration signal in Y direction"
- "Mean value of Time domain Body Acceleration signal in Z direction"
- "Standard deviation of Time domain Body Acceleration signal in X direction"
- "Standard deviation of Time domain Body Acceleration signal in Y direction"
- "Standard deviation of Time domain Body Acceleration signal in Z direction"
- "Mean value of Time domain Gravity Acceleration signal in X direction"
- "Mean value of Time domain Gravity Acceleration signal in Y direction"
- "Mean value of Time domain Gravity Acceleration signal in Z direction"
- "Standard deviation of Time domain Gravity Acceleration signal in X direction"
- "Standard deviation of Time domain Gravity Acceleration signal in Y direction"
- "Standard deviation of Time domain Gravity Acceleration signal in Z direction"
- "Mean value of Time domain Body Acceleration signal Jerk in X direction"
- "Mean value of Time domain Body Acceleration signal Jerk in Y direction"
- "Mean value of Time domain Body Acceleration signal Jerk in Z direction"
- "Standard deviation of Time domain Body Acceleration signal Jerk in X direction"
- "Standard deviation of Time domain Body Acceleration signal Jerk in Y direction"
- "Standard deviation of Time domain Body Acceleration signal Jerk in Z direction"
- "Mean value of Time domain Body Gyroscope signal in X direction"
- "Mean value of Time domain Body Gyroscope signal in Y direction"
- "Mean value of Time domain Body Gyroscope signal in Z direction"
- "Standard deviation of Time domain Body Gyroscope signal in X direction"
- "Standard deviation of Time domain Body Gyroscope signal in Y direction"
- "Standard deviation of Time domain Body Gyroscope signal in Z direction"
- "Mean value of Time domain Body Gyroscope signal Jerk in X direction"
- "Mean value of Time domain Body Gyroscope signal Jerk in Y direction"
- "Mean value of Time domain Body Gyroscope signal Jerk in Z direction"
- "Standard deviation of Time domain Body Gyroscope signal Jerk in X direction"
- "Standard deviation of Time domain Body Gyroscope signal Jerk in Y direction"
- "Standard deviation of Time domain Body Gyroscope signal Jerk in Z direction"
- "Mean value of Time domain Body Acceleration signal Magnitude"
- "Standard deviation of Time domain Body Acceleration signal Magnitude"
- "Mean value of Time domain Gravity Acceleration signal Magnitude"
- "Standard deviation of Time domain Gravity Acceleration signal Magnitude"
- "Mean value of Time domain Body Acceleration signal Jerk Magnitude"
- "Standard deviation of Time domain Body Acceleration signal Jerk Magnitude"
- "Mean value of Time domain Body Gyroscope signal Magnitude"
- "Standard deviation of Time domain Body Gyroscope signal Magnitude"
- "Mean value of Time domain Body Gyroscope signal Jerk Magnitude"
- "Standard deviation of Time domain Body Gyroscope signal Jerk Magnitude"
- "Mean value of Frequency domain Body Acceleration signal in X direction"
- "Mean value of Frequency domain Body Acceleration signal in Y direction"
- "Mean value of Frequency domain Body Acceleration signal in Z direction"
- "Standard deviation of Frequency domain Body Acceleration signal in X direction"
- "Standard deviation of Frequency domain Body Acceleration signal in Y direction"
- "Standard deviation of Frequency domain Body Acceleration signal in Z direction"
- "Mean value of Frequency domain Body Acceleration signal Jerk in X direction"
- "Mean value of Frequency domain Body Acceleration signal Jerk in Y direction"
- "Mean value of Frequency domain Body Acceleration signal Jerk in Z direction"
- "Standard deviation of Frequency domain Body Acceleration signal Jerk in X direction"
- "Standard deviation of Frequency domain Body Acceleration signal Jerk in Y direction"
- "Standard deviation of Frequency domain Body Acceleration signal Jerk in Z direction"
- "Mean value of Frequency domain Body Gyroscope signal in X direction"
- "Mean value of Frequency domain Body Gyroscope signal in Y direction"
- "Mean value of Frequency domain Body Gyroscope signal in Z direction"
- "Standard deviation of Frequency domain Body Gyroscope signal in X direction"
- "Standard deviation of Frequency domain Body Gyroscope signal in Y direction"
- "Standard deviation of Frequency domain Body Gyroscope signal in Z direction"
- "Mean value of Frequency domain Body Acceleration signal Magnitude"
- "Standard deviation of Frequency domain Body Acceleration signal Magnitude"
- "Mean value of Frequency domain Body Acceleration signal Jerk Magnitude"
- "Standard deviation of Frequency domain Body Acceleration signal Jerk Magnitude"
- "Mean value of Frequency domain Body Gyroscope signal Magnitude"
- "Standard deviation of Frequency domain Body Gyroscope signal Magnitude"
- "Mean value of Frequency domain Body Gyroscope signal Jerk Magnitude"
- "Standard deviation of Frequency domain Body Gyroscope signal Jerk Magnitude"

`Average of Variable Value`: average of respective Variable value by Subject and Activity. Numeric value (dbl) in the rage from -1 to 1.
