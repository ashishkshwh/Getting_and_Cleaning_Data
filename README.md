# Getting_and_Cleaning_Data
This is a repository for the course project in "Getting and Cleaning Data" course on Coursera 

Please note that the folder containing source files has been renamed for this script.
(The originally downloaded folder was *"getdata-projectfiles-UCI HAR Dataset"* and renamed to *"UCI HAR Dataset"*)

The project statement has five steps:

You should create one R script called run_analysis.R that does the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Since the project statement is described in five steps, the *run_analysis.R* generates five text files as the output.

Just to keep everything together, all five files are saved in the *"Processed Activity Data"* folder and is named "Processed Activity Data-X.txt", where X is the step number for that file. (For example "Processed Activity Data-2.txt" is the text file generated after the Step 2).

For evaluation, please look at the final file *"Processed Activity Data-5.txt"*, and you can ignore the other files.

For the variable description, please look at the codebook *"Activity_Data_Codebook.pdf"*.