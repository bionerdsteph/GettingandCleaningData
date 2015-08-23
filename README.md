# GettingandCleaningData
Course Project

The data for this project was loaded and unzipped into my working directory in windows. Each of the relevant files 
for the training (x_train,y_train, and subject_train) and test (x_test,y_test and subject_test) were loaded into R and
then column bound into a dataframe for the training set and a data frame for the test set. These were further bound into 
1 dataframe using row bind.

Using the features file, the columns names were read into an object and the names were editted for clarity and to make
them human readable. The following changes were made using gsub:
'f' to Frequency
'BodyBody' to Body
'Acc' to Acceleration
'Mag' to Magnitude
'Gyro' to Gyroscopic
'std' to STanDev
't' to Total
Additionally the '-' and '()' were taken out of each name

These were then used with name to rename the test and train combined dataframe. This combined dataframe was then 
subsetted using grep to include and columns with "mean" but exclude those with "Freqmean". The instructions for the 
stated with include data for means and I took that to mean that the freqmeans should not be included. A seperate subset
was made for all columns including "StanDev". These were then combined with the Subject and Activity columns to form the
final dataframe that included the Subject, activity and readings for the mean and standard deviation.

Using gsub and mutate the Activty numbers were replaced with the Activity labels found in activity_labels file.

Aggregate was used to form the final table of the means of each reading by subject and activity. The mean was taken for
all variables except Subject and Activity which were used to group the data. 

Finally a text file was produced using write.table.


