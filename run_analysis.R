#per assignment instructions this script:  "can be run as long as the Samsung data is in your working directory"
#this could mean any of several things...but I'll assume if the root directory of the unzipped data exists
#then all the data is there...also I'll just download the data if needed.


#this data was downloaded multiple times, and on several occasions the file was corrupted,
#this helper function makes immediately following code a bit cleaner
unzipfunction <- function(zipfile){
  print(paste("attempting to extract data from: ", zipfile))
  tryCatch(unzip(datafilename), 
           warning = function(w) {print(w);}, 
           error = function(e) {print(e);}
  )
  if(!file.exists(dirname)){stop(paste("could not unzip: ", zipfile))}
}


datafilename <- "getdata-projectfiles-UCI HAR Dataset.zip"
wd <- getwd()
dirname <- "UCI HAR Dataset"   #root directory of unzipped dataset
if(substr(wd, nchar(wd)-(nchar(dirname)-1), nchar(wd)) == dirname){
  
  #take no action, working directory already set to the directory of uzipped data
  
} else if(file.exists(dirname)) {
  
  #current working directory is the parent of the unzipped data
  print(paste("setting working directory to: ", getwd(), "/", dirname, sep = ""))
  setwd(dirname)
  
} else if(file.exists(datafilename)) {
  
  #the data is here  but needs to be unzipped
  unzipfunction(datafilename)
  
  print(paste("setting working directory to: ", getwd(), "/", dirname, sep = ""))
  setwd(dirname)
  
} else {
  
  #download and extract the data
  download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                destfile = datafilename)
  unzipfunction(datafilename)
  setwd(dirname)
}


print("data directory found, start processing")

#go exploring!

#README.txt explains:
# 30 subjects @ 70% (21/30) in train and 30% (9/30) in test
# 561 measurements were recorded while each of 30 subjects performed 6 different activities

#start reading and analyzing data to figure out how the pieces fit together


#README.txt explains:
#'activity_labels.txt': Links the class labels with their activity name
  activity_labels <- read.table("activity_labels.txt")
  head(activity_labels)
  #appears to be a mapping from integers to the strings which descibe the 6 activities

#README.txt explains:
# 'features.txt': List of all features.
  features <- read.table("features.txt")
  dim(features)  #[1] 561   2,  I'm guessing "features" are the "measurements" described in the README
  head(features)   #yes, features$V2 is what the README/features_info.txt calls "measurements" -- our variable names



#README.txt explains:
# - 'train/y_train.txt': Training labels.
# - 'test/y_test.txt': Test labels.

# why name files with a "y"?  maybe to associate with Y-axis,
#so maybe these are row labels of some sort...
  y_train <- read.table("train/y_train.txt")
  y_test <- read.table("test/y_test.txt")
  dim(y_train)  #[1] 7352  561
  dim(y_test)   #[1] 2947  561
  head(y_train)
  head(y_test)
  #hhhhmmmm....looks like numbers mapped to numbers...let's take a better look
  table(y_train)
  table(y_test)
  #aha -- looks like this corresponds wtih the variable activity_labels
  #plus 2947/(2947 + 7352) is approximately 30%
  #and 7352/(2947 + 7352) is approximately 70%
  #which matches the distribution of subjects and activities described in the README.txt
  

  #y_train and y_test make terrible variable names for scripting,
  #switching to descriptive names
  activity_ids_train <- y_train
  activity_ids_test <- y_test
  
  rm(y_train)
  rm(y_test)


#README.txt explains:
# - 'train/subject_train.txt': Each row identifies the subject who 
#    performed the activity for each window sample. Its range is from 1 to 30.

  #ah, subject IDs -- a clear instruction for once!  LOL
  subject_train <- read.table("train/subject_train.txt")
  subject_test <- read.table("test/subject_test.txt")
  dim(subject_train)  # [1] 7352    1
  dim(subject_test)   # [1] 2947    1
  #dimensions are correct for matching activity_ids_train and activity_ids_test...so we've got that going for us!
  
  table(subject_train)
  table(subject_test)
  #numbers 1-30 to identify the 30 test subjects
  
  dim(table(subject_train)) # 21
  dim(table(subject_test))  # 9
  #subjects properly distributed as described in README.txt
  
  intersect(names(table(subject_train)), names(table(subject_test)))  # character(0)
  #train and test subject groups are disjoint as described by README.txt
  #(so far this data looks pretty clean...nice!)


#README.txt explains:
# - 'train/X_train.txt': Training set.
# - 'test/X_test.txt': Test set.

# "set" of what, data?
  x_train <- read.table("train/x_train.txt")
  x_test <- read.table("test/x_test.txt")
  dim(x_train)  #[1] 7352  561
  dim(x_test)   #[1] 2947  561
  summary(x_train)
  summary(x_test)
  #yes, it's the data -- with width of 561 to match the variable features
  #and the row counts that match activity_ids_train and activity_ids_test
  
  #x_train and x_test make terrible names for scripting,
  #switching to descriptive names
  data_train <- x_train
  data_test <- x_test
  
  rm(x_train)
  rm(x_test)


#README.txt explains:
# # - 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the 
# # smartphone accelerometer X axis in standard gravity units 'g'. 
# # Every row shows a 128 element vector. 
# # The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' 
# # files for the Y and Z axis. 
# # - 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal 
# # obtained by subtracting the gravity from the total acceleration. 
# # - 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector 
# # measured by the gyroscope for each window sample. The units are radians/second. 

  # # another 18 files to read?  not sure if this is more data, raw data, or just subsets
  # # of what appears in the tables loaded above...
  # # so...let's read everything in train/Inertial Signals and take a look,
  # # if the data looks interesting then we look at test/Inertial Signals.
  # 
  # trainfilepath <- "train/Inertial Signals/"
  # 
  # #read filenames and include the path   (using full.names=TRUE)
  # filesWithPath <- as.list(list.files(path=trainfilepath, pattern = ".txt", full.names=TRUE, recursive = FALSE))
  # 
  # #remove path and extension from each filename and use remaining string to name the elements in filesWithPath
  # filesWithPath <- setNames(filesWithPath, lapply(filesWithPath, function(x){sub(trainfilepath, "", sub(".txt", "", x))}))
  # filesWithPath
  #
  # #now that filesWithPath is a named list lapply() will automatically name the return value of each function call with
  # #the name of the input parameter -- so the resulting list from lapply() will contain a list of named elements, in this
  # #case dataframes with each dataframe named by the file it came from
  # dataframelist <- lapply(filesWithPath, function(x){read.table(x);})
  # 
  # names(dataframelist)
  # #a named list of dataframes!  cool trick for reading multiple files, huh?
  # 
  # #I was certainly wondering if I could programatically move the dataframes out of the list
  # #and into an environment...so I had to try!
  # #This code does the trick:
  # invisible(mapply(function(list.element, names){assign(names, list.element, envir=.GlobalEnv)}, list.element=dataframelist, names = names(dataframelist)))
  # #wrap with invisible() to prevent data.frames from printing
  # 
  # rm(list=ls(pattern = "body|total"))  #very handy command if you play with above code...
  # 
  # lapply(dataframelist, dim)
  # # #all tables return [1] 7352  128 -- this matches the subject_train, x_train, and activity_ids_train
  # # #variables created earlier...but still not sure if this is the raw data or subsets that can be ignored...
  # # #research pays off...the description in the README file appears to explain them as raw data...
  # # discussion here says we don't need them:  https://class.coursera.org/getdata-031/forum/thread?thread_id=28
  # # 
  # # rm(dataframelist)
  # # rm(filesWithPath)
  # # rm(trainfilepath)
  


#well...let's tidy-up our data a little bit and along the way we'll
#glue together some of these table and see what happens...

#rename the columns in activity_labels
colnames(activity_labels) <- c("activity_id", "activity_name")
colnames(activity_labels)

#rename the column of activity_ids_train and activity_ids_test to "activity_id"
colnames(activity_ids_train) <- c("activity_id")
colnames(activity_ids_train)
colnames(activity_ids_test) <- c("activity_id")
colnames(activity_ids_test)

#merge activity_label with each activity_ids_train and activity_ids_test 
train_table <- merge(activity_ids_train, activity_labels, on="activity_id")
head(train_table)
table(train_table)

test_table <- merge(activity_ids_test, activity_labels, on="activity_id")
head(test_table)
table(test_table)

#continue building on train_table and test_table
#in order to preserve our other data ojbects
#in an unaltered state for future use if needed


#give a sensible name to the variable in subject_test and subject_train
colnames(subject_test) <- c("subject_id")
colnames(subject_train) <- c("subject_id")
head(subject_test)
head(subject_train)

#bind subject to activty_id and activity_name                                     ******create factors for activity and subject???
#we may not need both activity columns, but it will be nice to have them if needed
#and it's easy to drop them when it's time to make tidy data
train_table <- cbind(subject_train, train_table)
test_table <- cbind(subject_test, test_table)
head(train_table)
head(test_table)

#rename the columns of data_train and data_test using the descriptions in feature
colnames(data_train) <- features$V2
colnames(data_test) <- features$V2
head(data_train)
head(data_test)


#almost ready to bind activty and subject ids with the actual data...but
#we may manipulate this data later need to differentiate between train and test data,
#so adding a column called "datasource" to each table...
train_table$datasource <- "train"
test_table$datasource <- "test"
head(train_table)
head(test_table)

#also...add a sequence column to train and test tables in order to sort the
#each table to it's original order if needed...
train_table$ordering <- seq(from=1, to=nrow(train_table))
test_table$ordering <- seq(from=nrow(train_table)+1, to=nrow(train_table)+nrow(test_table))
summary(train_table$ordering)
summary(test_table$ordering)


#wait...WHAT?
summary(test_table$ordering)

#something seems wrong....that Max. value look fishy to you???
nrow(train_table)
nrow(test_table)
nrow(train_table) + nrow(test_table)
max(test_table$ordering)

#research pays off again...summary() has an interesting "feature":  http://tolstoy.newcastle.edu.au/R/e15/help/11/10/8980.html
summary(test_table$ordering, digits=5)
#ok...now the numbers look correct...and we gained valuable knowledge about the summary() function


#bind subject and activity variables to the data
train_table <- cbind(train_table, data_train)
test_table <- cbind(test_table, data_test)


#test data and train data now complete and ready to be combined...
#bind rows of train_table and test_table
tt_table <- rbind(train_table, test_table)
head(tt_table)

#this completes assignment task 1:
#Merges the training and the test sets to create one data set.

#moving on to task 2:  Extracts only the measurements on the mean and standard deviation for each measurement.

#all right...lets look for varible names that contain "mean"
meansearch <- grep("mean", colnames(tt_table))
meanvariables <- colnames(tt_table)[meansearch]
meanvariables

#hhhmmm....this shows that variable names can contain mean() or meanFreq()
#a search of features_info.txt verifies the existence of both,
#but the instructions say we should extract measurements on mean and standard deviation, so meanFreq
#should be omitted.
meansearch <- grep("mean\\(\\)", colnames(tt_table))
meanvariables <- colnames(tt_table)[meansearch]
meanvariables

#okay...next look for standard deviation variables,
#features_info.txt only mentions one:  std()
stdsearch <- grep("std\\(\\)", colnames(tt_table))
stdvariables <- colnames(tt_table)[stdsearch]
stdvariables

#looks like our grep works correctly...and 
#just realizing these mean* and std* names sound funny...  LOL
#so combine the two into the funniest variable name yet
meanstdvarsearch <- grep("mean\\(\\)|std\\(\\)", colnames(tt_table))

#subset the tt_table and give it yet another funny name
#make sure to keep our variables for subject_id and activity_labels
#at this point it seems safe to drop the origin and ordering columns as well,
#all that info will remain in tt_table if we need it
meanstdtable <- tt_table[, c(1,3, meanstdvarsearch)]


#this completes assignment task 2:  Extracts only the measurements on the mean and standard deviation for each measurement.
head(meanstdtable)

#moving on to task 3: Uses descriptive activity names to name the activities in the data set
#already complete -- activity labels are in column 3, 
#the variable is named "activity_name"
head(meanstdtable[1:10, 1:5])
table(meanstdtable$activity_name)

#moving on to task 4: Appropriately labels the data set with descriptive variable names. 
#already complete -- variable names applied as described in features.txt
colnames(meanstdtable)

#moving on to task 5: From the data set in step 4, creates a second, independent tidy 
#data set with the average of each variable for each activity and each subject.

#convert to using data.table functionality
if(!is.element("data.table", installed.packages()[,1])){install.packages("data.table")}
library(data.table)
dt <- as.data.table(meanstdtable)

#compute means grouped by activity and subject
meansbyactsub <- dt[, lapply(.SD, mean), by=.(activity_name,subject_id)]
head(meansbyactsub)

#order rows by activity and subject
meansbyactsub <- meansbyactsub[order(activity_name, subject_id)]
head(meansbyactsub)

#update variable names (column headers) for the grouped dataset to provide
#accurate description of the grouped data
#avoid renaming data.table columns using the form:  colnames(DT) <- list()
#http://stackoverflow.com/questions/10655438/rename-one-named-column-in-r
setnames(meansbyactsub, 
         names(meansbyactsub)[3:length(meansbyactsub)], 
         paste("Mean of", names(meansbyactsub)[3:length(meansbyactsub)], "Grouped by activity,subject")
        )

#meansbyactsub is now in tidy form with well named columns, one variable per column,
#and one observation per row
#output the tidy table
write.table(meansbyactsub, "tidy_data_set.txt",  row.name=FALSE)

print(paste("tidy dataset stored here:", getwd(), "/", "tidy_data_set.txt"))

rm(list=ls())

print("DONE ------------------------------------------------------------------------------------")
