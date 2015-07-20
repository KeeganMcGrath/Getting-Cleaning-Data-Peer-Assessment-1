library(plyr)
library(dplyr)
setwd("~/Getting:Cleaning Data/UCI HAR Dataset/")
Activity_Labels <- read.table("activity_labels.txt")
features <- read.table("features.txt")

setwd("~/Getting:Cleaning Data/UCI HAR Dataset/test/")
X_Test <- read.table("X_test.txt")
Y_Test <-read.table("y_test.txt")
Subject_Test <- read.table("subject_test.txt")

setwd("~/Getting:Cleaning Data/UCI HAR Dataset/train/")
X_Train <- read.table("X_train.txt")
Y_Train <- read.table("y_train.txt")
Subject_Train <- read.table("subject_train.txt")

Test_Set<- cbind(Subject_Test,Y_Test,X_Test)
Train_Set <- cbind(Subject_Train,Y_Train,X_Train)

features[ ,2] <- as.character(features[ ,2])
column_names <- c("Subject Identifier", "Activity", features[,2])
colnames(Train_Set) <- column_names
colnames(Test_Set) <- column_names

for (i in 1:nrow(Test_Set)) {
      if (Test_Set[i,2]==1){
            Test_Set[i,2] <- "WALKING"
      }
      else if (Test_Set[i,2]==2) {
            Test_Set[i,2] <- "WALKING_UPSTAIRS"
      }
      else if (Test_Set[i,2]==3) {
            Test_Set[i,2] <- "WALKING_DOWNSTAIRS"
      }
      else if (Test_Set[i,2]==4) {
            Test_Set[i,2] <- "SITTING"
      }
      else if (Test_Set[i,2]==5) {
            Test_Set[i,2] <- "STANDING"
      }
      else if (Test_Set[i,2]==6) {
            Test_Set[i,2] <- "LAYING"
      }
}


for (i in 1:nrow(Train_Set)) {
      if (Train_Set[i,2]==1){
            Train_Set[i,2] <- "WALKING"
      }
      else if (Train_Set[i,2]==2) {
            Train_Set[i,2] <- "WALKING_UPSTAIRS"
      }
      else if (Train_Set[i,2]==3) {
            Train_Set[i,2] <- "WALKING_DOWNSTAIRS"
      }
      else if (Train_Set[i,2]==4) {
            Train_Set[i,2] <- "SITTING"
      }
      else if (Train_Set[i,2]==5) {
            Train_Set[i,2] <- "STANDING"
      }
      else if (Train_Set[i,2]==6) {
            Train_Set[i,2] <- "LAYING"
      }
}

mean_measurements <- which(grepl("mean()",features[,2]))
std_measurements <- which(grepl("std",features[,2]))
mean_std_measurements <- sort(c(mean_measurements,std_measurements) +2)
Test_Mean_Std_Set <- Test_Set[,c(1,2,mean_std_measurements)]
Train_Mean_Std_Set <- Train_Set[,c(1,2,mean_std_measurements)]

merged_test_train <- rbind(Test_Mean_Std_Set,Train_Mean_Std_Set)
merged_test_train <- arrange(merged_test_train,merged_test_train[ ,1])
avg_set <- aggregate(merged_test_train,
            list(merged_test_train$`Subject Identifier`,merged_test_train$Activity),mean)

tidy_set <- cbind(avg_set$`Subject Identifier`,avg_set$Group.2,avg_set[ ,5:ncol(avg_set)])
colnames(tidy_set)[1:2] <- c("Subject Identifier", "Activity")
new_tidy_set <- arrange(tidy_set,tidy_set[,1],tidy_set[,2])

setwd("~/Getting:Cleaning Data/")
write.table(new_tidy_set,file = "new_tidy_data.txt",row.names = FALSE)