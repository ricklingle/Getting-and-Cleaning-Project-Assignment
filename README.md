# Getting-and-Cleaning-Project-Assignment
project assignment
Readme
scripts used:

to load data sets:
  data.frame(read.table("",header=FALSE))
  
to name columns for provided info:
  colnames(testdata)

to combine the test and training datasets:
  alldata<-rbind(testdata,traindata)

to combine subject and activiy names:
  subject<-rbind(subjecttest,subjecttrain)

to name the columns:
  names(subject)<-c("subject")

to combine the dataset with the subject and activity names
  dataset<-cbind(alldata,describe)

to calculate the average for each data set respectively: grepl
  data_mean_stdev<-dataset[,grepl("mean|std|subject|activity", names(dataset))]

load to plyr functions:
  library(plyr)
  
to add the specific activity names to the data set(ie Running, walking, etc):
  data_mean_stdev<-join(data_mean_stdev,actlabel,by="activity")

to change the column names to be more readable:
  names(data_mean_stdev)<-sub("t","Time ",names(data_mean_stdev))
  names(data_mean_stdev)[80]<-"Subject"
  names(data_mean_stdev)[82]<-"Activity"
to remove a column:
  data_mean_stdev[81]<-NULL

to create subsets of the data:
  summary<-aggregate(.~Subject+Activity,data_mean_stdev,mean)

export table for use:
  write.table(summary,file="run_average.txt",row.name=FALSE)
