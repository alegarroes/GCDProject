library(data.table)

# folder in which dataset is stored
data_folder <- "UCI HAR Dataset"

# TRAINING DATA
y_train_data_file <- file.path(getwd(), data_folder, "train", "y_train.txt")
x_train_data_file <- file.path(getwd(), data_folder, "train", "X_train.txt")
subject_train_data_file <- file.path(getwd(), data_folder, "train", "subject_train.txt")
activities_file <- file.path(getwd(), data_folder, "activity_labels.txt")

# contains features
x_train <- fread(x_train_data_file)
# contains activities
y_train <- fread(y_train_data_file)
# contains activity factors
activities <- readLines(activities_file)
# clean activity factor data
activities <- gsub("[0-9]+ ", "", activities)
# contains subject
subject_train <- fread(subject_train_data_file)

# name factors on activity vector
y_train <- factor(y_train[,V1])
y_train <- factor(y_train, labels = activities)

# read features file
features_file <- file.path(getwd(), data_folder, "features.txt")
variables <- readLines(features_file)
# leave only the feature values, eliminate line number
variables <- gsub("[0-9]+ ", "", variables)
# look for the indices of the mean and std features only
variable_names <- grep("mean|std", variables, value = TRUE)
variable_indices <- grep("mean|std", variables)

# select only columns that contain variables of interest
x_train <- x_train %>% select(all_of(variable_indices))
# name columns properly
names(x_train) <- variable_names
names(subject_train) <- "subject"

# MERGE TRAIN DATA SET
train_data <- cbind(subject_train, y_train, x_train)
# name column 2 as "activity"
names(train_data)[2] <- "activity"


# TEST DATA
y_test_data_file <- file.path(getwd(), data_folder, "test", "y_test.txt")
x_test_data_file <- file.path(getwd(), data_folder, "test", "X_test.txt")
subject_test_data_file <- file.path(getwd(), data_folder, "test", "subject_test.txt")

# contains features
x_test <- fread(x_test_data_file)
# contains activities
y_test <- fread(y_test_data_file)
# contains subject
subject_test <- fread(subject_test_data_file)

# name factors on activity vector
y_test <- factor(y_test[,V1])
y_test <- factor(y_test, labels = activities)

# select only columns that contain variables of interest
x_test <- x_test %>% select(all_of(variable_indices))
# name columns properly
names(x_test) <- variable_names
names(subject_test) <- "subject"

# MERGE TEST DATA SET
test_data <- cbind(subject_test, y_test, x_test)
# name column 2 as "activity"
names(test_data)[2] <- "activity"


# MERGE TRAIN AND TEST DATA SETS
data_set <- rbind(train_data, test_data)

# group data set by subject and activity
data_set_grouped <- group_by(data_set, subject, activity)

