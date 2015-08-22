The goal is to prepare tidy data that can be used for later analysis.

Basic algorithm for this project script (run_analysis.R):
1. get the data
2. read data into tables, analysing each table along the way
3. merge/bind various tables to satisfy objectives of the final dataset

Obtain data for the project here:
(https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

The data for this project conceptually contains TWO datasets, which was not easy to figure out.
The first dataset contains the raw measurement data collected during the test/train phases.
This raw dataset is stored in the directories train/Inertial Signals and test/Inertial Signals.
The second dataset represents the product of processing the raw data as described in features_info.txt.
The second dataset is stored in the train and test directories.
This second dataset provides the basis for this project.

Otherwise the data is aptly described in the README.txt and features_info.txt files,
refer to these files for further details.

The run_analysis.R scipt is embeddd with verbose comments paired with screen outputs
to identify thought processes used to develop the code, analyze the data,
and assist with verification of each step.  Script variables are descriptivley
named and all processes clearly described.
My first programming teacher in college always said:
"Comment your code well enough so you can read it 6 months from now and understand
both what you do and why you did it!  If you can't figure out 6 months from now, then nobody can."

Refer to run_analysis.R for further details.






