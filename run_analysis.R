# WORKING On STEP 1
#Reading the training datasets
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt",
                            header = FALSE)
train_x <- read.table("UCI HAR Dataset/train/X_train.txt",
                      header = FALSE)
train_y <- read.table("UCI HAR Dataset/train/y_train.txt",
                      header = FALSE)

#Reading the test datasets
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt",
                      header = FALSE)
test_x <- read.table("UCI HAR Dataset/test/X_test.txt",
                           header = FALSE)
test_y <- read.table("UCI HAR Dataset/test/y_test.txt",
                     header = FALSE)

#combining all the training data
train_whole <- cbind(train_subject,train_y,train_x)
#combining all the test data
test_whole <- cbind(test_subject,test_y,test_x)

#combining the test and training data
whole_data <- rbind(train_whole,test_whole)

#Step 1: Create one dataset
dir.create("Processed Activity Data")
write.table(whole_data,
            "Processed Activity Data/Processed Activity Data-1.txt",
            row.names = FALSE,
            col.names = FALSE)

#--------------------
#WORKING ON STEP 2 TO PUT COLUMN NAMES FROM feature.txt

#Reading the features to use as column names
features <- read.table("UCI HAR Dataset/features.txt")
features <- features[,2]
features <- as.character(features)

#modifying col names and adding to dataframe
features <- c("subject", "activity", features)
names(whole_data) <- features

#removing parantheses from names for
#searching only mean() and std()

features <- gsub("[][!#$%()*,.:;<=>@^_`|~.{}]", "-",features)
names(whole_data) <- features

#making a logic table for the columns with "mean" in them
mean_index <- grepl("-mean-",names(whole_data))
#making a logic table for the columns with "std" in them
std_index <- grepl("-std-",names(whole_data))
#Taking the union of both indices will give useful indices
useful_index <- mean_index | std_index
#still need to make first two indices TRUE
#as they are subject and activity
useful_index[1:2] = TRUE

#Step 2: Extract mean and std
whole_data_extract <- whole_data[,useful_index]
write.table(whole_data_extract,
            "Processed Activity Data/Processed Activity Data-2.txt",
            row.names = FALSE,
            col.names = FALSE)

#--------------------
#WORKING ON STEP 3 TO PUT COLUMN NAMES FROM feature.txt

#Reading activity labels from activity_labels
exer <- read.table("UCI HAR Dataset/activity_labels.txt")
exer$V2 <- as.character(exer$V2)

#mutate the activity column from number to names
whole_data_extract$activity <- exer$V2[whole_data_extract$activity]

#Step3: put activity names
write.table(whole_data_extract,
            "Processed Activity Data/Processed Activity Data-3.txt",
            row.names = FALSE,
            col.names = FALSE,
            quote = FALSE)

#--------------------
#WORKING ON STEP 4 TO PUT COLUMN NAMES FROM feature.txt
#read column names again
col_title <- names(whole_data_extract)
col_title <- gsub("-", "", col_title)
names(whole_data_extract) <- col_title
write.table(whole_data_extract,
            "Processed Activity Data/Processed Activity Data-4.txt",
            row.names = FALSE,
            col.names = TRUE,
            quote = FALSE)


#--------------------
#WORKING ON STEP 5 TO PUT COLUMN NAMES FROM feature.txt
#read column names and remove hyphens
features <- names(whole_data_extract)
features <- gsub("-","",features)
names(whole_data_extract) <- features

#reading total number of features
tot_feat <- ncol(whole_data_extract)

#preparing a new data frame for averages
x <- c(1:30)
x <- rep(x,each=6)
x <- as.data.frame(x)
exer <- exer$V2
exer <- as.data.frame(exer)
final_fr <- cbind(x,exer)
final_fr$exer <- as.character(final_fr$exer)

blank_vec <- c()

for (i in 1:nrow(final_fr)) {
    row_ind <- 
        which((whole_data_extract$subject==final_fr$x[i])
          &(whole_data_extract$activity==final_fr$exer[i]))
    

    temp_var <- sapply(whole_data_extract[row_ind,3:tot_feat],mean)
    blank_vec <- rbind(blank_vec,temp_var)
}
blank_vec <- as.data.frame(blank_vec)
final_dat <- cbind(final_fr,blank_vec)
names(final_dat) <- features

write.table(final_dat,
            "Processed Activity Data/Processed Activity Data-5.txt",
            row.names = FALSE)