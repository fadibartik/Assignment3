##PART 1
##Unzip the dataset

unzip("Dataset_Wearable_Computing.zip")


## Read all the data that is required for merge
##test
X_Test<- read.table("UCI HAR Dataset/test/X_test.txt")
Y_Test<- read.table("UCI HAR Dataset/test/Y_test.txt")
Subject_Test <-read.table("UCI HAR Dataset/test/subject_test.txt")
##Train
X_Train<- read.table("UCI HAR Dataset/train/X_train.txt")
Y_Train<- read.table("UCI HAR Dataset/train/Y_train.txt")
Subject_Train <-read.table("UCI HAR Dataset/train/subject_train.txt")

##merging the data

X_TT<-rbind(X_Test, X_Train)
Y_TT<-rbind(Y_Test, Y_Train)
Subject_TT<-rbind(Subject_Test, Subject_Train)

##PART 2
## Read the features
Features <- read.table("UCI HAR Dataset/features.txt")

##obtain all the features that have mean() or std() in them
M_S <- grep ( "mean\\(\\)|std\\(\\)",Features$V2) ##double \\ to escape the parenthesis
## 66 variables found
X_TT <- X_TT[M_S]

##PART 3
## Read the features
Activity <- read.table("UCI HAR Dataset/activity_labels.txt")
## obtain the activity label
Y_TT[,1]<-Activity[Y_TT[,1],2] 

##PART 4
## obtain the names of all variables
names <- Features[M_S,2]
names(X_TT) <- names ##updating the column names of X_TT
names(Subject_TT) <-"Subject_ID"
names(Y_TT) <- "Activity_Name"

Finished_Data_Clean <- cbind(Subject_TT, Y_TT, X_TT) ##merging the data together 

##PART 5

Finished_Data_Clean <- data.table(Finished_Data_Clean)
Finished_Data_Average <- Finished_Data_Clean[, lapply (.SD, mean), by ='Subject_ID,Activity_Name'] ##obtain mean and standard deviation
write.table(Finished_Data_Average, file = "Finished_Data.txt", row.names = FALSE)
