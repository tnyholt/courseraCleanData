# This is the readme file for coursera cleaning data course assignment for Tracey Nyholt

The algorithm to process the bad signal input data is simple:
1. Read data using readLines, i.e. just as text
2. Replace all single spaces with _
3. Replace all double _ with a single _ (to eliminate the double space issue)
4. Write to file
5. Read as a dataframe with sep = '_'
6. Drop first column if it is all NAs
7. Rename all the columns with new names (required by the assignment)
8. Process the test variables