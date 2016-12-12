# Tracey Nyholt Assignement Data cleaning course
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement.
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names.
# From the data set in step 4, creates a second, independent tidy data 
# set with the average of each variable for each activity and each subject.

# All the wide format files are space delimeted but in a unintelligent manner/
# There are two spaces at the beginning of lines but only one between other fields
# Thus, we must import using readLines and make the spacing consistent

setwd('~/workspace/CouresraCleanD/Assignment/')

# First thing we should do is build mappings for activity label number to
# actual activity name
activity = read.csv('UCI HAR Dataset/activity_labels.txt',header = FALSE,sep=' ')

# Column/feature names
columnNames = read.csv('UCI HAR Dataset/features.txt',header = FALSE,sep=' ')

# We start with bringing in all the subject IDs
idDftest = read.csv('UCI HAR Dataset/test/subject_test.txt',header=FALSE,col.names = 'ID')
idDftrain = read.csv('UCI HAR Dataset/train/subject_train.txt',header=FALSE,col.names = 'ID')
fullID = rbind(idDftest,idDftrain)

# Next we will bring in all the response (y) variables
yDftest = read.csv('UCI HAR Dataset/test/y_test.txt',header=FALSE,col.names = 'activityType')
yDftrain = read.csv('UCI HAR Dataset/train/y_train.txt',header=FALSE,col.names = 'activityType')
fullActivityType = rbind(yDftest,yDftrain)

# The following function maps values from a data frame, map, column 1
# to new values in the mapping data frame.
# e.g. map has a row 1,Value. In each value of data = 1, this function
# will place instead the entry "Value". However, the function will do so
# for all the rows in the mapping data frame.
mapper = function(map,data){
  for (i in seq(1,length(map$V1))){
    data[data==map[i,1]] = as.character(map[i,2])
  }
  return(data)
}

# Transform activity data
fullActivityType = mapper(activity,fullActivityType)

# The algorithm to process the bad signal input data is simple:
# 1. Read data using readLines, i.e. just as text
# 2. Replace all single spaces with _
# 3. Replace all double _ with a single _
# 4. Write to file
# 5. Read as a dataframe with sep = '_'
# 6. Drop first column if it is all NAs
# 7. Rename all the columns with new names (required by the assignment)

# Process the test variables
X_test = readLines('UCI HAR Dataset/test/X_test.txt')
test2 = gsub(' ','_',X_test,useBytes = TRUE)
test3 = gsub("__",'_',test2,useBytes = TRUE)
writeLines(test3,'UCI HAR Dataset/test/X_test_processed.csv')

# Process the train variables
X_train = readLines('UCI HAR Dataset/train/X_train.txt')
train2 = gsub(' ','_',X_train,useBytes = TRUE)
train3 = gsub("__",'_',train2,useBytes = TRUE)
writeLines(train3,'UCI HAR Dataset/train/X_train_processed.csv')

# Import test data
dfTest = read.csv('UCI HAR Dataset/test/X_test_processed.csv',sep='_',header = FALSE)
dfTest = dfTest[-1]
colnames(dfTest) = columnNames$V2

# Import train data
dfTrain = read.csv('UCI HAR Dataset/train/X_train_processed.csv',sep='_',header = FALSE)
dfTrain = dfTrain[-1]
colnames(dfTrain) = columnNames$V2

# Combine data
df = rbind(dfTest,dfTrain)

# Combine all the data
fullData = cbind(fullID,fullActivityType,df)

# Finally, create average of each variable by ID, Activity combination
avgDf = aggregate(fullData[,c(-1,-2)],FUN=function(x) mean(x,na.rm=TRUE),by=fullData[,c(1,2)])