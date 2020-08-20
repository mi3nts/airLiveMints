


% clc
close all


%% Loading Models 

for nodeIndex =1 : length(nodeID_DCCCD)
    
    nodeID = nodeID_DCCCD(nodeIndex)  ;
    display("Models for Node ID: " + nodeID)
    eval(strcat("nodeStruct = mintsNode_",nodeID,";"))  
    
    for targetIndex = 1:length(nodeStruct)
        version = nodeStruct(targetIndex).modelVersion;
        target  = nodeStruct(targetIndex).target;
        mdlName = strcat("modelVersion_",version,"_",nodeID,"_",target);
        loadString = strcat(modelsFolder,nodeID,"/",mdlName,".mat");
        load(loadString)
        display("loading: "+ mdlName)
        eval(strcat(mdlName,"=Mdl;"))
    end
    display(newline)
end