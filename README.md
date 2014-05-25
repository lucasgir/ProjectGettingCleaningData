ProjectGettingCleaningData
==========================
##What the script does
* loads the data from both training and test sets and merge them together with rbind function
    * measure (X_test.txt, X_train.txt)
    * activities (y_test.txt, y_train.txt) and activities labels (activity_labels.txt)
    * subjects (subject_train.txt, subject_test.txt)
* loads the label of the measurement from features.txt, and cleans them (remove sprecial char and upper case)
* keeps only the measurement containing the string mean or std
* Adds the subject to the main dataset
* Adds activity number to the main dataset and replace them with their labels
* Melts the dataset by activity and subject
* Cast the dataset in a new tidy dataset using the mean
