# Getting and Cleaning Data Course Project
_based on Samsung Human Activity Recognition Using Smartphones Dataset_ 

This `README` explains how all of the scripts work and how files in this repository are connected.

## Original Data Source
This Project is based on data collected from the accelerometers from the Samsung Galaxy S smartphone.
Please see full description here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Original Dataset was obtained from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


## Files in this Repository:

- `UCI HAR Dataset` folder
- `run_analysis.R`
- `tidy_dataset.txt`
- `CodeBook.md`

### `USI HAR Dataset` folder
downloaded and unzipped archive, containing original data and its description.

### `run_analysis.R`
R script, which processes original UCI HAR Dataset and creates tidy output file - tidy_dataset.txt. 
This script can be downloaded and executed in your R environment (e.g with `source(run_analysis.R)` command) as long as the original Samsung data (unzipped `USI HAR Dataset` folder) is present in the working directory.

### `tidy_dataset.txt`
tidy output file (in the _long_ form, as permitted by Course Project Requirements). This is UTF-8 tab delimited file, which can be imported to R by read.table("tidy_dataset.txt")

### `CodeBook.md`
describes the variables, the data, and transformations performed to clean up the original data and create tidy_dataset.txt.


