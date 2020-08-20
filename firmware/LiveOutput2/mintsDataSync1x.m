function [] = mintsDataSync1x(dataFolder)
%MINTSDATASYNC Summary of this function goes here
%   Detailed explanation goes here
    while true 
        
        rawFolder        = dataFolder + "/raw"
        rawDotMatsFolder = dataFolder + "/rawMats"
        resultsFolder    = dataFolder + "/liveUpdate/results/"
        % Sync From Virtual Machine 
        syncFromLive

        display("--------MINTS--------")
        % commented to be ran from matlab coder      
        % addpath("/home/teamlarylive/gitHubRepos/Lakitha/airLive/firmware/functions/")

        nodeIDs   = {...
            '001e06305a12',...
            '001e06323a12',...
            '001e06318cd1',...
            '001e06305a61',...
            '001e06323a05',...
            '001e06305a57',...
            '001e063059c2',...
            '001e06318c28',...
            '001e06305a6b',...
            '001e063239e3',...
            '001e06305a6c'...
            };
        
        nodeID_DCCCD   = {...
                 '001e06305a12',...
                };

        startDate  = datetime('today','TimeZone','utc')-day(1) ;
        endDate    = datetime('today','TimeZone','utc')  ;

        period     = endDate : -day(1) :startDate;

        % dataFolder       = "/home/teamlarylive/minstData";
%         rawFolder        = dataFolder + "/raw";
%         rawDotMatsFolder = dataFolder + "/rawMats";
        stringIn = "mintsDailyRetimed";
        timeStep  = seconds(30);

        for dateIndex = 1:length(period)
            for nodeIndex = 1: length(nodeIDs)
                   % Going through Each Date ;
                    try
                    nodeDataFiles = getMintsFileNames(period,dateIndex,rawFolder,nodeIDs,nodeIndex);
                    saveAsDataStoreRawMatsLive(nodeDataFiles)  

                    fileName = getMintsFileNamesStr(period,dateIndex,rawDotMatsFolder,nodeIDs,nodeIndex,stringIn);
                    saveDailyRetimedLive(fileName,period,dateIndex,rawDotMatsFolder,nodeIDs,nodeIndex,timeStep); 

                    catch exception %#ok<NASGU>
                       display("No data For Current Node") %#ok<DISPLAYPROG>

                    end % Try Catch 
                end % Dates 
            end % Node ID

        % Sync to Virtual Machine 
        syncToLive
    end
end

