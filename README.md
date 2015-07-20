# Getting-Cleaning-Data-Peer-Assessment-1
Course Project for the Coursera Class Getting and Cleaning Data in the Data Science Specialization.

This repository has 5 files (other than :

-  **getdata-projectfiles-UCI HAR Dataset.zip** which is the zip file containing the data used to create the tidy data set.
-  **new_tidy_data.csv** is the tidy data set created in step 5 of the instructions but is in .csv format for easy viewing.
-  **new_tidy_data.txt** is the tidy data set submitted to Coursera in .txt format.
-  **run_analysis.R** is the R script that was used to transform the raw data into a tidy data set.
-  **Codebook.md** is a markdown file describing the variables in the tidy data set.

This README.md file will describe how the *run_analysis.R* file transforms the raw data from *getdata-projectfiles-UCI HAR Dataset.zip* to create the tidy data set in *new_tidy_data.txt* and in *new_tidy_data.csv*.

So, first I read in the data to R using multiple read.table functions.  Next, I combined the train data sets and test data sets into 2 datasets, one for train and one for test, using the cbind function.  Then, I named the columns for each data set using the colnames function.  Next, I transformed the numbers 1 through 6 in the "Activity" column (column 2) to their corresponding activities as specified by the *activity_labels.txt* file.  Next I extracted only the columns that included measurements about the mean and standard deviation using the grepl function and I subsetted the Test and Train data sets to only include those columns.  Then, I merged the Train and Test data sets using the rbind function and I arranged the data set according to the "Subject Identifier" column.  Next, I used the aggregate function to take the mean of each measurement according to the subject identifier and the activity name.  This creates a messy data set with a few unneeded columns, so I subsetted the new data set using cbind to create a tidy data set.  I renamed the columns using the colnames function and I arranged the new tidy data set according to the subject identifier and the activity name.  Then I used the write.table and write.csv function to create the data files that are in this repository.
