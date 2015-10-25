#run_analysis.R
# Download the raw data to the current working directory and unzip
zipfile <- tempfile()
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,zipfile)
unzip(zipfile, files = NULL, list = FALSE, overwrite = TRUE,
      junkpaths = FALSE, exdir = ".", unzip = "internal",
      setTimes = FALSE)
unlink(zipfile)

###Load required packages
library(dplyr)

# Read subject files
subject_train <- tbl_df(read.table("./UCI HAR Dataset/train/subject_train.txt"))
subject_test  <- tbl_df(read.table("./UCI HAR Dataset/test/subject_test.txt" ))
# Read activity files
activity_train <- tbl_df(read.table("./UCI HAR Dataset/train/Y_train.txt"))
activity_test  <- tbl_df(read.table("./UCI HAR Dataset/test/Y_test.txt" ))
#Read data files
train_df <- tbl_df(read.table("./UCI HAR Dataset/train/X_train.txt" ))
test_df  <- tbl_df(read.table("./UCI HAR Dataset/test/X_test.txt" ))


## 1. Merges the training and the test sets to create one data set.
#combine the training and test data tables to one data table called dat
dat <- rbind(train_df, test_df)

# clean up active variables
rm(train_df, test_df)

# features.txt hold all the 561 feature names matching all 561 variables
# (columns) in the data table dat
# read in features.txt 561 row with 2 columns
features <- tbl_df(read.table("./UCI HAR Dataset/features.txt"))

# V2 holds the names for all activities.  Set column names to features$V2
colnames(dat) <- features$V2 

# for both Activity and Subject files this will merge the training and the test 
# sets by row binding and rename variables "subject" and "activityNum"
subj <- bind_rows(subject_train, subject_test) %>% 
        rename(subject = V1)

activ <- bind_rows(activity_train, activity_test) %>%
        rename(activitynum = V1)

# clean up active variables
rm(subject_train, subject_test, activity_train, activity_test)


## 2. Extracts only the measurements on the mean AND standard deviation for 
##    each measurement. 
dat <- dat[ , grepl("mean\\(|std\\(", features$V2)]

### 3. Uses descriptive activity names to name the activities in the data set

# Read in labels for activities from activity_labels.txt
act_labels <- tbl_df(read.table("./UCI HAR Dataset/activity_labels.txt"))
# Set names to later match up with activites data
act_labels <- rename(act_labels, activitynum = V1, activityname = V2)
# Add Labels to activ form the activity_labels text file 
activ <- inner_join(activ, act_labels)  
# combine the columns of suject, activities, and data into dat
dat <- bind_cols(subj, activ, dat)


# 4. Appropriately labels the data set with descriptive variable names. 
# To make the names tidy we will remove parenthesis and change from "-" to "_"
# To make the names more readable underscores will also be added.
# All names will be made lower case for easier data manipulation later
# f will be turned to frequency
# t will be turned to time
# Acc to acceleration
# Gyro to angular_velocity
# Mag to magnitude
# BodyBody to body
names(dat)<-gsub("yG", "y_G", names(dat))
names(dat)<-gsub("yA", "y_A", names(dat))
names(dat)<-gsub("cJ", "c_j", names(dat))
names(dat)<-gsub("oJ", "o_j", names(dat))
names(dat)<-gsub("cM", "c_M", names(dat))
names(dat)<-gsub("oM", "o_M", names(dat))
names(dat)<-gsub("kM", "k_M", names(dat))
names(dat)<-gsub("-", "_", names(dat))
names(dat)<-gsub("std\\(\\)", "standard_deviation", names(dat))
names(dat)<-gsub("mean\\(\\)", "mean", names(dat))
names(dat)<-gsub("^t", "time_", names(dat))
names(dat)<-gsub("^f", "frequency_", names(dat))
names(dat)<-gsub("Acc", "acceleration", names(dat))
names(dat)<-gsub("Gyro", "angular_velocity", names(dat))
names(dat)<-gsub("Mag", "magnitude", names(dat))
names(dat)<-gsub("BodyBody", "body", names(dat))
names(dat)<-gsub("Body", "body", names(dat))
names(dat)<-gsub("G", "g", names(dat))
names(dat)<-gsub("X", "x", names(dat))
names(dat)<-gsub("Y", "y", names(dat))
names(dat)<-gsub("Z", "z", names(dat))

# 5. From the data set in step 4, creates a second, independent tidy data set with 
# the average of each variable for each activity and each subject.

# Data is sorted by the suject first and then each activity

tidy <- dat %>%
        select (-activitynum) %>%
        group_by(subject, activityname) %>%
        summarize_each(funs(mean))


write.table(tidy, "tidy_averages.txt", row.name=FALSE)
