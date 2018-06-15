library(dplyr)
library(tidyr)


######## read in the data tables
#########
train_x <- read.table("~/train/X_train.txt", header = F)
train_y <- read.table("~/train/y_train.txt", header = F)
train_subject <- read.table("~/train/subject_train.txt", header = F)

test_x <- read.table("~/test/X_test.txt", header = F)
test_y <- read.table("~/test/y_test.txt", header = F)
test_subject <- read.table("~/test/subject_test.txt", header = F)

features <- read.table("~/features.txt", header = F)
activity <- read.table("~/activity_labels.txt", header = F)


##########  add column names to the ClassLabels table (the _y tables) and the _x tables using the features file
##########
names(train_x) <- features[,2]
names(test_x) <- features[,2]
names(test_y) <- "label"
names(train_y) <- "label"
names(activity) <- c("label", "activity")
names(test_subject) <- "subject"
names(train_subject) <- "subject"


#########create a vector of column numbers which contain "mean" or "std" by grepping the features data table
meanvect <- grep("mean\\(\\)", features[,2])
stdvect <- grep("std\\(\\)", features[,2])
datavect <- sort(c(meanvect, stdvect))


###########create subsets of _x files which only contain columns with "mean" or "std"
trainx <- train_x[datavect]
testx <- test_x[datavect]



############combine all tables into 1
############
labeleda <- left_join(test_y,activity, by = "label")
labeledb <- left_join(train_y,activity, by = "label")

testdata <- cbind(test_subject, labeleda[2],testx)
traindata <- cbind(train_subject, labeledb[2],trainx)


alldata <- rbind(traindata,testdata)


#################summarise data and write to .txt file
summdata <- alldata %>%
          group_by(subject,activity) %>%
          summarise_all(mean)

write.table(summdata, "tidydata.txt", row.name = FALSE)
