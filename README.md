
The course project for Getting and Cleanning Data. 

There are two files submitted for the course. <run_analysis.R and Codebook>

run_analysis.R
=====================

The file 'run_analysis.R' recorded the completed process to clean the data set from step 1 to step 6

    step 1. read test and train data respectively
            read subject and activity data for train data and test data as well
    step 2. merg test data and train data together to generate the 'DT' data set with 10299 observations
            2.1 cbind activity/subject to trian/test respectively
            2.2 rbind train and test data together
    step 3. select the measurements on mean or std only, so there are 66 measurements were selected in
    step 4. use descriptive names to rename the activity variable 
    step 5. label 66 meansures with proper features name
    step 6. create (by melting /casting) a new tidy data (180 rows x 68 columns) set upon the request to have the average of each 66 measurements by each activity x each subject
    
    In order to include more meaningful data for further analyses, I included data source which was labeled as "source" variable to identify whether train data or test data in 'DT'. Therefore, 'DT' was a dataset with 10299 observations and 69 variables from step 1 to step 5
    
    
Codebook 
==========================
Codebook described the variables in the tidy data set. Please go the codebook for the details
