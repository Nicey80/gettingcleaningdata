# gettingcleaningdata
Coursera Getting &amp; Cleaning Data Assignment

Script run_analysis undertakes the follwoing steps

1. Load relevant packages into memory  
* reshape2

2. Read in the relvant datasets into memory  
* Test and training versions of  
        + Dataset  
        + Subject Ids  
        + Activity IDs  
* Variable Names  
* Activity Mapping  
        
3. Merge the relevant datasets using rbind to form full set of  
* Dataset  
* Subjectids  
* ActivityId's  

4. Transform variable names and add to dataset

5. Subset dataset to only include variables with mean() and sd() in them

6. Using cbind merge all the activity & subject data with the main dataset

7. Melt & dcast the data to create the required output format using mean 
function

8. Output file with write.table
