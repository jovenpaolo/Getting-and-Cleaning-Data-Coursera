#loads activity data sets

testactivity  <- read.table("test/Y_test.txt" , header = FALSE)
trainactivity <- read.table("train/Y_train.txt", header = FALSE)

#loads subject data sets

testsubject  <- read.table("test/subject_test.txt", header = FALSE)
trainsubject <- read.table("train/subject_train.txt", header = FALSE)

#loads features data sets

testfeatures  <- read.table("test/X_test.txt", header = FALSE)
trainfeatures <- read.table("train/X_train.txt", header = FALSE)

#Merges the training and the test sets to create one data set.

activity <- rbind(trainactivity, testactivity)
subject <- rbind(trainsubject, testsubject)
features <- rbind(trainfeatures, testfeatures)

#changes factor levels to match activity labels
labels <- read.table("activity_labels.txt", header = FALSE)
activity$V1 <- factor(activity$V1, levels = as.integer(labels$V1), labels = labels$V2)

#names activity, subject and features columns

featurestxt <- read.table("features.txt", head=FALSE)
names(activity)<- c("activity")
names(subject)<-c("subject")
names(features)<- featurestxt$V2

#chooses columns with std/mean data and subsets

meanstdev<-c(as.character(featurestxt$V2[grep("mean\\(\\)|std\\(\\)", featurestxt$V2)]))
subdata<-subset(features,select=meanstdev)

subjectactivity <- cbind(subject, activity)
finaldata <- cbind(subdata, subjectactivity)

#Clarifying time and frequency variables
names(finaldata)<-gsub("^t", "time", names(finaldata))
names(finaldata)<-gsub("^f", "frequency", names(finaldata))

#New data set for subject and activity means
suppressWarnings(cleandata <- aggregate(finaldata, by = list(finaldata$subject, finaldata$activity), FUN = mean))
colnames(cleandata)[1] <- "Subject"
names(cleandata)[2] <- "Activity"

#data cleanup for non-aggregated subject and activity columns
cleandata <- cleandata[1:68]

#Output file
write.table(cleandata, file = "Human Activity Recognition Using Smartphones Data Set.txt", row.name = FALSE)
