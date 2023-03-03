# Read data from files
x_train <- read.table("C:/Users/ZJH_8/Desktop/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
x_test <- read.table("C:/Users/ZJH_8/Desktop/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
y_train <- read.table("C:/Users/ZJH_8/Desktop/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("C:/Users/ZJH_8/Desktop/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
subject_train <- read.table("C:/Users/ZJH_8/Desktop/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("C:/Users/ZJH_8/Desktop/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
features <- read.table("C:/Users/ZJH_8/Desktop/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt")
activity_labels <- read.table("C:/Users/ZJH_8/Desktop/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")

# Find mean and std 
filter <- grep("-mean|-std", features$V2)
features_filtered <- features[filter,]

# Combine training and testing data sets
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
x_filtered <- x[,filter]
subject <- rbind(subject_train, subject_test)

# Combine columns of subject and y
subject_y = cbind(subject, y)

# Create an extra column for merging
subject_y$id  <- 1:nrow(subject_y)
colnames(subject_y) <- c("subject id", "activity id", "id")

# Merge subject_y and activity_labels
merged <- merge(subject_y, activity_labels, by.x = "activity id", by.y = "V1")
activity <- merged[order(merged$id),][,-3]

# Combine columns of activity and x_filtered
df <- cbind(activity, x_filtered)

# Reorder first and second columns
df <- df[,c(2,1,3:ncol(df))]

# Create descriptive names
colnames(df) <- c("subject id", "activity id", "activity", features_filtered$V2)

# Calculate the mean of each filtered feature
df_aggregated <- aggregate(df[4:ncol(df)], df[1:3], FUN = mean)

# Order result by subject id and activity id
result <- df_aggregated[order(df_aggregated$`subject id`, df_aggregated$`activity id`),]

# Create a tidy data set file
write.table(result, "result.txt", row.names = FALSE)
