require(dplyr)

splitonspace <- function(v) {
    strsplit(v," ")[[1]][2]
}

if(!file.exists("./data.zip")) {
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "./data.zip")
}
unzip("./data.zip")
#colLabels <- read.table("./UCI HAR Dataset/features.txt",quote="",stringsAsFactors=FALSE)$V2
colLabels <- readLines("./UCI HAR Dataset/features.txt") # use readLines to preserve row numbers as there are duplicate variable names
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
names(activityLabels) <- c("y","activity")

# build train table
## read in files
xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt")  # activity code column
subject.train <- read.table("./UCI HAR Dataset/train/subject_train.txt") # subject id column

# assign column names
names(xtrain) <- colLabels
names(ytrain) <- "y"
names(subject.train) <- "subject"

# join files
train <- cbind(ytrain,xtrain) # add activity code column
train <- cbind(train,subject.train) # add subject id column
train <- merge(train,activityLabels) # join activity code to activity string

# build test table
## read in files
xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt") # activity code column
subject.test <- read.table("./UCI HAR Dataset/test/subject_test.txt") # subject id column

## assign column names
names(xtest) <- colLabels
names(ytest) <- "y"
names(subject.test) <- "subject"

# join files
test <- cbind(ytest,xtest) # add activity code column
test <- cbind(test,subject.test) # add subject id column
test <- merge(test,activityLabels) # join activity code to activity string



data <- rbind(train,test) # join train and tests into one data set
# data <- select(data, c(subject,activity,grep("mean[^F]|std",names(data)))) # same results as next line
data <- select(data, c(subject,activity,grep("mean\\(\\)|std\\(\\)",names(data))))
names(data)[3:length(names(data))] <- sapply(names(data)[3:length(names(data))],splitonspace) # get rid of row numbers now that there are no longer any duplicate row names
data.g <- group_by(data, subject,activity)
clean <- summarise_each(data.g, funs(mean))

write.table(clean,"./tidy.txt",row.names=FALSE)