# Getting-and-Cleaning-Data-Course-Project
Repository for assignment of "Getting and Cleaning Data" Course Project

1. The script will run only if you have downloaded and unzip files from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
to your working directory.
2. Before using the script please set in R your working directory:
f.ex:
`setwd("/Users/xxxx/MyWorkingDirectory")`
3. Firstly in 'data preparation' part there are loaded column names and activity labels.
4. Then it is loaded and prepared TEST dataset.
5. After that TRAIN set [the same way as it was in case TEST data].
6. Both datasets are merged to 'BigData'.
7. After that there are proper measures (mean and std) substracted.
8. In the last step it is created dataset with aggregates by activity and subject.
9. Further details are in script comments. 
