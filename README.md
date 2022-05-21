# Getting and Cleaning Data Project
### Final project for the Coursera course Getting and Cleaning Data

The goal is to extract the mean of several accelerometer measurements taken from a Samsung Galaxy S II smartphone. These measurements were taken from experiments in which 30 volunteers performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing the smartphone. The source of the data is the [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). Two datasets were processed, a training data set and a testing data set.

Here, the analysis performed in `run_analysis.R` is described.

## Reading data from the files
The data were read from the following files, each one for the testing and training data sets:
- `x_train.txt` or `x_test.txt` contain the raw variable datasets
- `y_train.txt` or `y_test.txt` contain the activity performed from which the variables were measured
- `subject_train.txt` or `subject_test.txt` contain the ID of the volunteer performing the test
These files were read using the function `fread()` from the data.table package, since the files have fixed width columns.

Additionally, the following files were parsed:
- `activity_labels.txt` contains the activity labels
- `features.txt` contains the name of the measurements in `x_train.txt`

For the `features.txt` file, as required by the assignment, only those variables that included "mean" or "std" were selected.

## Selecting variables and merging data sets
The columns corresponding to the filtered features from the `features.txt` file were selected according to the correct indices. The activities from the `y_train.txt` files were factored and assigned a descriptive name, instead of just a number. Data from the `subject_train.txt` and `subject_test.txt` were joined using `cbind()` with the y_train and x_train data. Finally, the final data set is created by merging the `train_data` and `test_data` using `rbind()`. A tibble is created with this `data_set`.

## Tidying data set, grouping and summarizing
The `data_set` was processed into a tidy data format using `gather()` from the tidyr library, creating a column "measurement" which specifies the feature in the "value" column. This tidy data set is grouped by "subject", "activity" and "measurement" using `group_by()`. Finally, the grouped data set is summarized using `summrize()`, in order to calculate the "avg" column which contains the `mean()` for each measurement taken from a particular subject and activity.

## Source

Jorge L. Reyes-Ortiz(1,2), Davide Anguita(1), Alessandro Ghio(1), Luca Oneto(1) and Xavier Parra(2)
1 - Smartlab - Non-Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova, Genoa (I-16145), Italy.
2 - CETpD - Technical Research Centre for Dependency Care and Autonomous Living
Universitat Politècnica de Catalunya (BarcelonaTech). Vilanova i la Geltrú (08800), Spain
activityrecognition '@' smartlab.ws
