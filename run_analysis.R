#loading and merging the data
test_dataset <- read.table("UCI HAR Dataset//test//X_test.txt")
train_dataset <- read.table("UCI HAR Dataset//train//X_train.txt")
dataset <- rbind(train_dataset,test_dataset)

#Loading and merging activities
test_activity <- read.table("UCI HAR Dataset//test//y_test.txt")
train_activity <- read.table("UCI HAR Dataset//train//y_train.txt")
dataset_activity <- rbind(train_activity,test_activity )

#loading and merging subjects
subject_dataset <- rbind(read.table("UCI HAR Dataset//train//subject_train.txt"),read.table("UCI HAR Dataset//test//subject_test.txt"))

#loading the label, removing parenthesis and comma, replacing "-" with "." and converting to lowercase
label_dataset <- read.table("UCI HAR Dataset//features.txt")
names(dataset) <- gsub("\\,","",gsub("\\(","",gsub("\\)","",gsub("-",".",tolower(label_dataset[,2])))))

#loading activities labels
activity_label <- read.table("UCI HAR Dataset//activity_labels.txt")

#Keeping only mean and standard deviation fo each mesurement
dataset_v2 <- dataset[, grepl("mean", label_dataset[,2], ignore.case=TRUE) | grepl("std", label_dataset[,2], ignore.case=TRUE)]

#adding the subject
names(subject_dataset) <- "subject"
dataset_v3<- cbind(subject_dataset, dataset_v2)

#Adding the label of the activity

dataset_activity$activity <- activity_label[match(dataset_activity[,1],activity_label[,1]),2]
dataset_activity$activity <- as.factor(dataset_activity$activity)
dataset_v4<- cbind(dataset_activity$activity, dataset_v3)
names(dataset_v4)<- c("activity",names(dataset_v3))

#average per activity and subject
library(reshape2)
melted_dataset <- melt(dataset_v4,id=c("activity","subject"))
final_dataset <- dcast(melted_dataset, activity + subject ~variable, mean)

#output the dataset in a CSV
write.table(final_dataset,"tidy_dataset.txt")