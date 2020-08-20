% clc
close all

%% Saving raw Mints Data as Daily Tables 


for nodeIndex = 1: length(nodeIDs)
    if nodeIndex == 1 
        if currentHour ~= hour(datetime('now'))
            doPlots = true ;
            currentHour = hour(datetime('now'));
        else 
            doPlots = false;
        end
   end
    
    display("Plot state set to : " + doPlots)
    

    nodeID = nodeIDs(nodeIndex) ; 
    eval(strcat("nodeStruct = mintsNode_",nodeID,";"))
    for dateIndex = 1:length(period)
        currentDateStr = char(period(dateIndex));
        dateStr = currentDateStr(1:11);
        
%         try           
%            tic
           %% Get Current File 
           display("Save Daily Data for Node : " + nodeID + " & Date: " + dateStr)         
           [mintsDailyRetimed,currentFileName,status] = ...
                    getMintsFileNameStrLive(period,dateIndex,rawDotMatsFolder,nodeIDs,nodeIndex,stringIn);
                status
                currentFileName
            if(status)
                mintsDailyRetimed.Properties.VariableNames  = ...
                                            strrep(strrep(strrep(mintsDailyRetimed.Properties.VariableNames,...
                                                                        'pm1_OPCN2','PM10_OPCN2'),...
                                                                        'pm10_OPCN2','PM2_5_OPCN2'),...
                                                                        'pm2_5_OPCN2','PM1_OPCN2');
                mintsDailyRetimedT = timetable2table(mintsDailyRetimed);
                
               display("Running Models for Node : " + nodeID  + " & Date: " + dateStr)   
                %% Run All The Models for the current Node     
                for targetIndex = 1:length(nodeStruct)
                    version = nodeStruct(targetIndex).modelVersion;
                    target  = nodeStruct(targetIndex).target;
                    mdlName = strcat("modelVersion_",version,"_",nodeID,"_",target);
                    eval(strcat("mintsDailyRetimed.",target, "_Predicted= ", mdlName,".predict(mintsDailyRetimedT);"))
                end

                %% Creating CSV File 
                display("Saving CSVs for Node : " + nodeID  + " & Date: " + dateStr)  
                outCalibrated = printCSVDailyLive(mintsDailyRetimed,...
                                    wantedVariables,wantedVariableLabels,...
                                        liveResultsFolder,nodeID,period,dateIndex,stringInLive);
%                 toc
                %% Creating Data Plots
                if(doPlots)
                    display("Plotting Data for Node : " + nodeID  + " & Date: " + dateStr)                                      
                    drawAllTimeSeriesPlotsLive(outCalibrated,...
                                                 nodeID,...
                                                    period,dateIndex,...
                                                        liveResultsFolder,...
                                                            "UTC");
                    %% Creating CSV File 
                    display("Plotting Histogram Data for Node : " + nodeID  + " & Date: " + dateStr)  

                    outCalibrated.dateTime.TimeZone = 'utc';
                    drawContourPlotLive(outCalibrated,nodeID,{"UTC Time(hours)"; dateStr},...
                                                                   "Particle Diametors(\mum)",...
                                                                   "Particle Size Distribution",...
                                                                   period,dateIndex,...
                                                                   liveResultsFolder,...
                                                                   "Contour_UTC_Time"...
                                                                   );
                end % Do Plots 


            end % Status
            display(newline)
            
%         catch exception
%             display("No data For the current File") %#ok<DISPLAYPROG>
%         end% Try Catch 
    end % Dates 
end % Node ID

