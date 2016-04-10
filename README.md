# getting_clean_data_project
Darpan Amin

## Overview
Getting and Cleaning Data Course Project.  This project uses a collection of files downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
These files countain measurement data from sensors on wearables that 30 participants had on while performing various activities.
The data from the files is imported, merged, cleaned, and summarized to finally give you mean calculations of the Mean() and STD() measurements.  


## Script
The script (run_analysis.R) runs with the assumption that you have the datafiles unzipped with the folders in tact into a sub directory 'R'.  

You will need to modify the file path in this following command: "filePath <-"./R/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/"
to fit your local environment.  

## Data
The data output is found in tidyData.txt.  Use the Code Book file to look at the list of variables.
