run_analysis <-function(){
        ## load required packages
        library(reshape2)
        
        
        ## read in the 2 datasets and merge
        ds1<-read.table("X_test.txt", header=FALSE)
        ds2<-read.table("X_train.txt", header=FALSE)
        varlabels<-read.table("features.txt", header=FALSE, stringsAsFactors = FALSE)
        subtest<-read.table("subject_test.txt", col.names = "subjectid")
        subtrain<-read.table("subject_train.txt", col.names = "subjectid")
        labeltrain<-read.table("y_train.txt", col.names = "activityid")
        labeltest<-read.table("y_test.txt", col.names = "activityid")
        actlabels<-read.table("activity_labels.txt", col.names = c("id","activitytype"))
        
        ##merge
        fullds <- rbind(ds1,ds2)
        submerge <-rbind(subtest,subtrain)
        #submerge<-as.factor(submerge)
        labelmerge<-rbind(labeltest,labeltrain)
        labelmerge<-merge(labelmerge,actlabels, by.x ="activityid", by.y="id", all.x=TRUE)
        activitytype<-labelmerge$activitytype
        
        ## label variables
        varlabels2<-varlabels$V2
        varlabels2<-gsub("^t","timed",varlabels2)
        varlabels2<-gsub("^f","frequency",varlabels2)
        varlabels2<-gsub("Acc","acceleration",varlabels2)
        varlabels2<-gsub("Gyro","gyroscope",varlabels2)
        varlabels2<-gsub("Mag","magnitude",varlabels2)
        varlabels2<-tolower(varlabels2)
        colnames(fullds)<-varlabels2
        
        ##extract mean & sd to new dataset
        mean_sd<-grep("mean\\(\\)|std\\(\\)",varlabels2)
        reducedds<-fullds[,mean_sd]
        
        ##add particpant and activity ids
        finalds<-cbind(submerge,activitytype,reducedds)
        
        ## summarise dataset
        ## melt and dcast
        varnames <- names(finalds[c(-1,-2)])
        datamelt<- melt(finalds,id=c("subjectid","activitytype"),measure.vars=varnames)
        outdata <- dcast(datamelt, subjectid + activitytype ~ variable,mean)
        #head(outdata)
        
        ## output data
        write.table(outdata,"outputfile.txt",row.names = FALSE)
        #summary(outdata)
}