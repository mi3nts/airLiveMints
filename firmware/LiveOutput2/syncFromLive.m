
%   Detailed explanation goes here
% strcat('rsync -avzrtu -e "ssh -p 2222"  mints@mintsdata.utdallas.edu:raw/'," " ,mintsRawDataFolder)
system(strcat('rsync -avzrtu  --exclude "*.png" -e "ssh -p 2222"  mints@mintsdata.utdallas.edu:raw/'," " ,rawFolder))  ;


% rsync -avzrtu  --exclude '*.png' -e "ssh -p 2222"