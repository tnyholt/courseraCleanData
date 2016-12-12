This is the code book for Tracey Nyholt's coursera assignment for the 
cleaning data course as part of the data science program

The purpose of this code book is to describe variables, the data, and
any transformations or work that you performed to clean up the data 

TRANSFORMS:

I replaced all the numbers representing activities with the activity names

VARIABLES:

fullActivityType: combined activity typs is y_test and y_train

fullID: all the IDs in both files for subject_text and subject_train 

fullData: a dataframe of the fullID and the fullActivity type

avgDF: average of each variable by ID and Activity combination
