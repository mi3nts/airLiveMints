function [checkedPalasData] = palasChecker(palasData)
%PALASCHECKER Summary of this function goes here
%   Detailed explanation goes here
    checkedPalasData = palasData;
    
    if(checkedPalasData.PM1>checkedPalasData.PM2_5)
        checkedPalasData.PM1 = checkedPalasData.PM2_5;
    end
    
    if(checkedPalasData.PM2_5>checkedPalasData.PM4)
        checkedPalasData.PM2_5 = checkedPalasData.PM4;
    end
    
    if(checkedPalasData.PM4>checkedPalasData.PM10)
        checkedPalasData.PM4 = checkedPalasData.PM10;
    end    
            
end

