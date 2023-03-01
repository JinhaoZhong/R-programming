install.packages("data.table")
install.packages("reshape2")
library(data.table)
library(dplyr)

## read table
activity_labels = read.table("C:/Users/ZJH_8/Desktop/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")[,2]
features = read.table("C:/Users/ZJH_8/Desktop/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")[,2]
extract_features = grepl("mean|std", features)
X_test <- read.table("C:/Users/ZJH_8/Desktop/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("C:/Users/ZJH_8/Desktop/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("C:/Users/ZJH_8/Desktop/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")


## extract mean and std for each measurement
names(X_test) = features
X_test = X_test[,extract_features]


## get activity labels
y_test[,2] = activity_labels[y_test[,1]]
names(y_test) = c("Activity_ID", "Activity_Label")
names(subject_test) = "subject"


## combind data
test_data <- cbind(as.data.table(subject_test), y_test, X_test)

## read trainning data
xtrain = read.table("C:/Users/ZJH_8/Desktop/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
ytrain = read.table("C:/Users/ZJH_8/Desktop/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
sub_train = read.table ("C:/Users/ZJH_8/Desktop/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
names(xtrain) = features

## extract mean and std for each measurement
xtrain = xtrain[,extract_features]

## load active data
ytrain[,2] = activity_labels[ytrain[,1]]
names(ytrain) = c("Activity_ID", "Activity_Label")
names(sub_train) = "subject"

## combind data
train_data <- cbind(as.data.table(sub_train), ytrain, xtrain)

# merge test and train data
data = rbind(test_data, train_data)

id_labels   = c("subject", "Activity_ID", "Activity_Label")
data_labels = setdiff(colnames(data), id_labels)
melt_data      = melt(data, id = id_labels, measure.vars = data_labels)

tidy_data   = dcast(melt_data, subject + Activity_Label ~ variable.names(mean())

write.table(tidy_data, file = "C:/Users/ZJH_8/Desktop/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/tidy_data.txt")
