## set file paths
filePath <-"./R/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/"
ftest<-paste0(filePath,"test/")
ftrain<-paste0(filePath,"train/")

## read in features and activity files
features<-read.delim(paste0(filePath,"features.txt"), header = FALSE,stringsAsFactors = FALSE, sep=" ")
activity<-read.delim(paste0(filePath,"activity_labels.txt"), header = FALSE,stringsAsFactors = FALSE, sep=" ")

## generate list of file paths and names for the data in Test and Train
file_list <- sapply(append(ftest,ftrain),list.files,pattern="*.txt",full.names = TRUE)
file_names <- sapply(append(ftest,ftrain),list.files,pattern="*.txt")

## merge raw data from test and train files
myfiles = lapply(file_list,fread)
names(myfiles) <-file_names


## data table created with both Test and Train dataset and Activity names and subject id.  This is for requirement #1.  

          ## activity names merged with Y files
activity_data_test <-merge(myfiles$y_test.txt,activity, by.x = "V1", by.y = "V1", all.x = TRUE,sort = FALSE)
activity_data_train <-merge(myfiles$y_train.txt,activity, by.x = "V1", by.y = "V1", all.x = TRUE,sort = FALSE)
total_data <-rbind(cbind(myfiles$subject_test.txt,activity_data_test$V2,myfiles$X_test.txt),cbind(myfiles$subject_train.txt,activity_data_train$V2,myfiles$X_train.txt))


## apply descriptive column names and meaningful Activity name.  This is for requirements #3 and #4.  
##Requirement #2 will be addressed when I extract the relevant columns from this big dataset
col_names<-append(c("subject","activity_name"),features$V2)
names(total_data)<-col_names

## get dataset that is narrowed down to Mean and STD, looking for only Mean() and STD().  This addresses requirement #2
##  requirements 1 - 4 will be complete after this step.
mean_std_col <-grep("mean\\(|std\\(",col_names)
mean_std_col_names <-grep("mean\\(|std\\(",col_names,value = TRUE)
data_mean_std<-select(total_data,append(c(1:2),mean_std_col))

## this is now th final summarized dataset where the means are calculated for each measure by subject/activity.  3-68 are the measure columns.
## this completes requirement #5
aggDT_tidy <-aggregate(data_mean_std[, mean_std_col_names,with = FALSE],by=list(subject = data_mean_std$subject,activity = data_mean_std$activity_name),mean)
## exporting data
write.table(aggDT_tidy, './tidyData.txt',row.names=TRUE,sep='\t')