##Sets working directory & load files into objects for training set
setwd("~/data/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train")
subject_train<-read.table("subject_train.txt",stringsAsFactors = FALSE)
x_train<-read.table("x_train.txt",stringsAsFactors = FALSE)
y_train<-read.table("y_train.txt",stringsAsFactors = FALSE)
Train<-cbind(x_train,y_train,subject_train) ##forms Training dataset

##Sets working director & load files into objects for test set
setwd("~/data/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test")
subject_test<-read.table("subject_test.txt",stringsAsFactors = FALSE)
x_test<-read.table("x_test.txt",stringsAsFactors = FALSE)
y_test<-read.table("y_test.txt",stringsAsFactors = FALSE)
Test<-cbind(x_test,y_test,subject_test) ##forms Test dataset

Combined<-rbind(Train,Test)##Creates combined dataset

## Renames columns with appropriate variable names using features file and gsub
setwd("~/data/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset")
features<-read.table("features.txt")
features<-features[,2]
features<-gsub("f","Frequency",features)
features<-gsub("BodyBody","Body",features)
features<-gsub("Acc","Acceleration",features)
features<-gsub("Mag","Magnitude",features)
features<-gsub("Gyro","Gyroscopic",features)
features<-gsub("std","STanDev",features)
features<-gsub("-X","X",features)
features<-gsub("-Y","Y",features)
features<-gsub("-Z","Z",features)
features<-gsub("t","Total",features)
features<-gsub("()","",features,fixed = TRUE)
features<-gsub("-","",features)
names(Combined)<-c(features,"Activity","Subject")


##subsetting out coulumns with mean measurement
MeanCom<-Combined[,grep("mean",colnames(Combined))]
MeanCom<-MeanCom[,grep("meanFreq",colnames(MeanCom),invert = TRUE)]

##subsetting out columns with std measurement
StdCom<-Combined[,grep("STanDev",colnames(Combined))]

##subsetting out activity & subjects
AS<-Combined[,562:563]

##Form new data set with mean, std and activity/subject
FinalDS<-cbind(AS,MeanCom,StdCom)

##Create vector with activity labels
ActivityLabels<-FinalDS$Activity
ActivityLabels<-gsub("1","Walking",ActivityLabels)
ActivityLabels<-gsub("2","walking_upstairs",ActivityLabels)
ActivityLabels<-gsub("3","walking_downstairs",ActivityLabels)
ActivityLabels<-gsub("4","sitting",ActivityLabels)
ActivityLabels<-gsub("5","standing",ActivityLabels)
ActivityLabels<-gsub("6","laying",ActivityLabels)


## Add in activity labels to dataframe
FinalDS<-mutate(FinalDS,Activity=ActivityLabels)

## Form a table for mean of each reading by subject & activity
ColNames<-colnames(FinalDS[,3:35])
Test<-aggregate(cbind(ColNames)~Subject+Activity,FinalDS,mean)



