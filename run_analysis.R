setpw("C:/Users/IBM_ADMIN/Documents/data clean job")

library(plyr)
library(data.table)
library(sqldf)
library(reshape2)

## read data ##

testData<-read.table("X_test.txt",sep="") ## read test data##
trainData<-read.table("X_train.txt",sep="") ## read train data##

testSubject<-read.table("subject_test.txt",sep="",col.names="Subject") ## read subject data for test data ##
testActivity<-read.table("y_test.txt",sep="",col.names="Activity") ## read activity data for test data ##

trainSubject<-read.table("subject_train.txt",sep="",col.names="Subject") ## read subject data for train data ##
trainActivity<-read.table("y_train.txt",sep="",col.names="Activity") ## read activity data for train data ##

##merge data##

testDT<-cbind(testActivity,testSubject,testData) ## merge activity, subject and test data ##
testDT$source="test" ## mark the data source as test ##

trainDT<-cbind(trainActivity,trainSubject,trainData) ## merge activity, subject and train data ##
trainDT$source="train" ## mark the data source as train ##

DT<-rbind(testDT,trainDT) ## merge test and train data together ##

## Exact measures on the mean and std##
DT<-DT[,c("Activity","Subject","source","V1","V2","V3","V4","V5","V6","V41","V42","V43","V44","V45","V46","V81","V82","V83","V84","V85","V86","V121","V122","V123","V124","V125","V126","V161","V162","V163","V164","V165","V166","V201","V202","V214","V215","V227","V228","V240","V241","V253","V254","V266","V267","V268","V269","V270","V271","V345","V346","V347","V348","V349","V350","V424","V425","V426","V427","V428","V429","V503","V504","V516","V517","V529","V530","V542","V543")]


## name activity variable##
DT$Activity[DT$Activity == 1] <- "WALKING"
DT$Activity[DT$Activity == 2] <- "WALKING_UPSTAIRS"
DT$Activity[DT$Activity == 3] <- "WALKING_DOWNSTAIRS"
DT$Activity[DT$Activity == 4] <- "SITTING"
DT$Activity[DT$Activity == 5] <- "STANDING"
DT$Activity[DT$Activity == 6] <- "LAYING"


## label other variables ##

label<-read.table("features.txt",sep="") ## read feature data in ##
label<-sqldf("select * from label where (v2 like '%mean()%' or v2 like '%std()%')") ## label feaures to variables ##

names(DT)[4:69]<-as.character(label$V2) 
    ## clean data to the data frame of 10299X69. 66 variables for mean and std measurement. Activity, subject and source are the other three ##

## Tidy data set with average of each variable by each activity x each subject ##
DTMelt<-melt(DT,var.ids=c("Activity","Subject"),measure.vars=c(4:69)) ## Melt DT ##
tidyDT<-dcast(DTMelt,Activity+Subject~variable,mean) ## summarise DT by Activity X subject upon the request ##
Str(tidyDT)
head(tidyDT,10)

## write the tidy data to txt file ##

write.table(tidyDT,file="C:/Users/IBM_ADMIN/Documents/data clean job/tidyDT.txt",row.name=FALSE,sep="\t")





