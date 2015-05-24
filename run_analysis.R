run_analysis
  ##1
  ##load features and data sets
  
  testn<-data.frame(read.table("~/data/UCI HAR Dataset/features.txt",header=FALSE))
  testdata<-data.frame(read.table("~/data/UCI HAR Dataset/test/X_test.txt")) 
  traindata<-data.frame(read.table("~/data/UCI HAR Dataset/train/X_train.txt"))
  
  ##add column names to data set from features file
  colnames(testdata)<-testn[,2]
  colnames(traindata)<-testn[,2]

  ##combine data sets
  alldata<-rbind(testdata,traindata)

  ##load activity and subject names & combine to data set
  activitytest<-read.table("~/data/UCI HAR Dataset/test/y_test.txt",header=FALSE)
  subjecttest<-read.table("~/data/UCI HAR Dataset/test/subject_test.txt",header=FALSE)
  activitytrain<-read.table("~/data/UCI HAR Dataset/train/y_train.txt",header=FALSE)
  subjecttrain<-read.table("~/data/UCI HAR Dataset/train/subject_train.txt",header=FALSE)

  subject<-rbind(subjecttest,subjecttrain)
  activity<-rbind(activitytest,activitytrain)

  names(subject)<-c("subject")
  names(activity)<-c("activity")

  ##create full dataset with names
  describe<-cbind(subject,activity)
  dataset<-cbind(alldata,describe)

  
  ##2
  ##create mean and stdev dataset

  data_mean_stdev<-dataset[,grepl("mean|std|subject|activity", names(dataset))]


  ##3
  ##load activity label names, join to dataset by index number

  actlabel<-read.table("./data/UCI HAR Dataset/activity_labels.txt",header=FALSE)
  colnames(actlabel)<-c("activity","activity label")

  library(plyr)
  
  data_mean_stdev<-join(data_mean_stdev,actlabel,by="activity")


  ##4
  ##re-label variable names ie. time, acceleration, etc.

  names(data_mean_stdev)<-sub("t","Time ",names(data_mean_stdev))
  names(data_mean_stdev)<-sub("f","Freq ",names(data_mean_stdev))
  names(data_mean_stdev)<-sub("Mag"," Magnitude",names(data_mean_stdev))
  names(data_mean_stdev)<-sub("BodyGyroJerk","Body Angular Acceleration",names(data_mean_stdev))
  names(data_mean_stdev)<-sub("BodyAccJerk","Body Linear Acceleration",names(data_mean_stdev))
  names(data_mean_stdev)<-sub("BodyGyro","Body Angular Velocity",names(data_mean_stdev))
  names(data_mean_stdev)<-sub("BodyAcc","Body Acceleration",names(data_mean_stdev))
  names(data_mean_stdev)<-sub("GravityAcc","Gravity Acceleration",names(data_mean_stdev))
  names(data_mean_stdev)[80]<-"Subject"
  names(data_mean_stdev)[82]<-"Activity"
  data_mean_stdev[81]<-NULL


  ##5
  ##create new table for export

  summary<-aggregate(.~Subject+Activity,data_mean_stdev,mean)
  write.table(summary,file="run_average.txt",row.name=FALSE)


