

clc
clear all
close all

display("------ MINTS ------")

addpath("../functions/")
startDate  = datetime('today','TimeZone','utc')-day(1) ;
endDate    = datetime('today','TimeZone','utc')  ;

%modelsFolder = "/media/teamlary/teamlary3/air930/mintsData/modelsMats/";



period     = endDate:-day(1):startDate;

dataFolder         =  "/nfs/MINTS/data/mintsData";
modelsFolder = dataFolder + "/modelsMats/";
rawFolder          =  dataFolder + "/raw";
rawDotMatsFolder   =  dataFolder + "/rawMats";
liveResultsFolder  =  dataFolder + "/liveUpdate/results" ;

stringIn = "mintsDailyRetimed";
stringInLive = "calibrated_UTC";

currentHour = 25;
doPlots = false ; 

display(newline)
display("Data Folder Located @: "+ dataFolder)
display("Raw Data Located @: "+ dataFolder)
display("Raw DotMat Data Located @: "+ rawDotMatsFolder)
display("Models Located @: "+ modelsFolder)
display("Live Data Located @: "+ liveResultsFolder)
display(newline)
 
LO_0001_CreatingmasterStruct
LO_0001_CreatingmasterStruct_DCCCD

LO_0002_mdlLoader
LO_0002_mdlLoader_DCCCD

while true 
   try 
       LO_0003_getCalibratedResults
       LO_0003_getCalibratedResults_DCCCD 
   catch exception
       fprintf(1,'There was an error! The message was:\n%s',exception.message);
   end% Try Catch     
   
end
