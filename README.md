
Getting and Cleaning Data Course Project
<br>
<br>
POST SUBMISSION EDIT:  To the peer reviewers of this assignment,<br>
I'll save you some time and tell you that lines 218 & 222<br>
are where things went wrong -- I failed to realize/notice the<br>
merge command re-orders the rows of the resulting table...<br>
<br>
D'OH!!!!
<br>
<br>
Purpose:
<br>
Demonstrate your ability to collect, work with, and clean a data set. 
<br>
The goal is to prepare tidy data that can be used for later analysis.
<br>
<br>
Acquire data for the assignment here:  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
<br>
<br>
Objectives
<br>
Write a script called run_analysis.R which satsifies 5 requirements:
<br>
1.Merges the training and the test sets to create one data set.
<br>
2.Extracts only the measurements on the mean and standard deviation for each measurement. 
<br>
3.Uses descriptive activity names to name the activities in the data set
<br>
4.Appropriately labels the data set with descriptive activity names. 
<br>
5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
<br>
<br>
Per the assignment instructions:
<br>
The code should run as long as the Samsung data is in your working directory.
<br>
<br>
My version of run_analysis.R contains a combination of verbose comments and sceen output
<br>
in order to facilitate the initial analysis.  Comments contain functional statements
<br>
to explain commands in the script, and also thought-process statements to
<br>
explain the analysis process that was followed during script development.  The
<br>
screen output is paired with the script comments and designed to verify each step of 
<br>
the analysis along the way.
<br>
Read CodeBook.md and the run_analysis.R for further details.



