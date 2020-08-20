

    % /home/teamlarylive/minstData/raw
    display("Syncing Live Results for UTD Nodes ") %#ok<DISPLAYPROG>
    for nodeIndex  = 1: length(nodeIDs)
        nodeID = nodeIDs(nodeIndex);
        eval(strcat("system('rsync -avzrtu -e ",'"ssh -p 2222"'," ",resultsFolder,nodeID,'/ mints@mintsdata.utdallas.edu:../Node_data/',nodeID,"/');"))


    end

    display("Syncing Live Results for DCCCD Node ") %#ok<DISPLAYPROG>
    for nodeIndex  = 1: length(nodeID_DCCCD)
        nodeID = nodeID_DCCCD(nodeIndex);
        eval(strcat("system('rsync -avzrtu -e ",'"ssh -p 2222"'," ",resultsFolder,nodeID,'/ mints@mintsdata.utdallas.edu:../Node_data/',nodeID,"/');"))
    end




