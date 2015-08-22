The goal is to prepare tidy data that can be used for later analysis.
<br>
<br>
Basic algorithm for this project script (run_analysis.R):
<br>
1. get the data
<br>
2. read data into tables, analysing each table along the way
<br>
3. merge/bind various tables to satisfy objectives of the final dataset
<br>
<br>
Obtain data for the project here:
<br>
(https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
<br>
<br>
The data for this project conceptually contains TWO datasets, which was not easy to figure out.
<br>
The first dataset contains the raw measurement data collected during the test/train phases.
<br>
This raw dataset is stored in the directories train/Inertial Signals and test/Inertial Signals.
<br>
The second dataset represents the product of processing the raw data as described in features_info.txt.
<br>
The second dataset is stored in the train and test directories.
<br>
This second dataset provides the basis for this project.

Otherwise the data is aptly described in the README.txt and features_info.txt files,
<br>
refer to these files for further details.
<br>
<br>
The run_analysis.R scipt is embeddd with verbose comments paired with screen outputs
<br>
to identify thought processes used to develop the code, analyze the data,
<br>
and assist with verification of each step.  Script variables are descriptivley
<br>
named and all processes clearly described.
<br>
My first programming teacher in college always said:
<br>
"Comment your code well enough so you can read it 6 months from now and understand
<br>
both what you do and why you did it!  If you can't figure out 6 months from now, then nobody can."
<br>
Refer to run_analysis.R for further details.






