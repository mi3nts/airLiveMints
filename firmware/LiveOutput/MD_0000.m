
clc
clear all
close all

addpath("../functions/")

MD_001e06305a12_Definitions

MD_001e06305a12_Loader

MD_001e06323a06_Definitions

MD_001e06323a06_Loader


while(true)
    tic
    %syncFrom 
    plotterOn = minute(datetime('now'))<1
      try
       MD_001e06305a12_Definitions
       MD_001e06305a12_main
      catch
         warning('Redoing Loop');
      end
        
        try
        MD_001e06323a06_Definitions
        MD_001e06323a06_main
        catch
           warning('Redoing Loop');
        end

    %syncTo 
    toc
end
