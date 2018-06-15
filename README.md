# TidyDataProject
Jared's TidyDataProject
R Script "finalproject.R" 
This script reads in data tables from the UCI HAR Dataset and outputs a .txt file consisting of a tidy data table.
The data table produced contains data on the subject, the action they were performing, and the mean and standard 
deviation of the measurements performed while they were performing these actions.

Steps:
1.  Read in data tables
  a. training set and training set labels
  b. test set and test set labels
  c. test and training set subjects
  d. features, describing the columns of data
  e. activity, which translates labels to actual activities
2. Add header names to data tables
  a. features data table is used to populate columns of test and training set.
  b. activity and subject are given column headers
3. Create a vector of column numbers that pertain to columns in the test and training set which contain mean() and std() data
4. Create a subset of test and training tables which only contain the columns signified by the vector from step 3.
5. Combine all data into one data table
  a. subject data (using cbind)
  b. activity data (using cbind)
  c. test and training mean() and std() data (using rbind)
6. Create a summary of this most recent data table by taking the mean of each variable, grouped by subject and activity
7. Write this summary data table to a file "tidydata.txt"