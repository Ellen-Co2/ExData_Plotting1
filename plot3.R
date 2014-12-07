#reading data of 2007-2-1~2007-2-3 into subdata
subdata<-read.table("household_power_consumption.txt",sep=";",na.strings="?",colClasses=c(rep("character",2),rep("numeric",7)),nrows=2880,skip=66638)
names(subdata)<-c("Date","Time","Global Active Power","Global_reactive_power","Voltage","Global Intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

#convert the character into POSIXlt with "strptime()"
origin_time<-paste(subdata$Date,subdata$Time)
origin_time<-strptime(origin_time,"%d/%m/%Y %H:%M:%S",tz="GMT")
subdata$Time<-origin_time
subdata$Date<-strptime(subdata$Date,"%d/%m/%Y",tz="GMT")

##check the inside of the new subdata after conversion of time
#str(subdata)
#'data.frame':  2880 obs. of  9 variables:
#$ Date                 : POSIXlt, format: "2007-02-01" "2007-02-01" ...
#$ Time                 : POSIXlt, format: "2007-02-01 00:01:00" "2007-02-01 00:02:00" ...
#$ Global Active Power  : num  0.326 0.324 0.324 0.322 0.32 0.32 0.32 0.32 0.236 0.226 ...
#$ Global_reactive_power: num  0.13 0.132 0.134 0.13 0.126 0.126 0.126 0.128 0 0 ...
#$ Voltage              : num  243 244 244 243 242 ...
#$ Global Intensity     : num  1.4 1.4 1.4 1.4 1.4 1.4 1.4 1.4 1 1 ...
#$ Sub_metering_1       : num  0 0 0 0 0 0 0 0 0 0 ...
#$ Sub_metering_2       : num  0 0 0 0 0 0 0 0 0 0 ...
#$ Sub_metering_3       : num  0 0 0 0 0 0 0 0 0 0 ...

png(file = "plot3.png", bg = "transparent",width = 480, height = 480,units = "px")
plot(subdata$Time,subdata$"Sub_metering_1",ylab="Energy sub metering",xlab="",xaxt='n',type="n")
#plot the axis without data
lines(subdata$Time,subdata$"Sub_metering_1",type="l",xlab="",xaxt='n',col="black")
lines(subdata$Time,subdata$"Sub_metering_2",type="l",xlab="",xaxt='n',col="red")
lines(subdata$Time,subdata$"Sub_metering_3",type="l",xlab="",xaxt='n',col="blue")
#plot the three variables in the coordinate with different colors
legend("topright",legend=expression("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lwd=1,seg.len=3)
#draw the legend in the topright
axis(1,labels=c("Thu","Fri","Sat"),at=c(as.POSIXct("2007-02-01",tz="GMT"),as.POSIXct("2007-02-02",tz="GMT"),as.POSIXct("2007-02-03",tz="GMT")))
#revise the x axis labels
dev.off()