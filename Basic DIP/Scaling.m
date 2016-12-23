% Name              : Kamna Yadav
% A Number          : A02048769
% File name         : MainScript.m
% File description  : Main code file for Linear Scaling
function [scaledIm,transFunc] = Scaling(inputIm,range) 
    minRequired = range(1)*255.0;
    maxRequired = range(2)*255.0;
    requiredRange=double(maxRequired-minRequired);
    inputIm = double(inputIm);
    
    % Check for boundary value conditions
    if(minRequired >= maxRequired || minRequired < 0 || maxRequired > 255)
        disp('-----Range is not correct-----');
        return;
    end
    minOrig = double(min(inputIm(:)));
    maxOrig = double(max(inputIm(:)));
    oldRange = double(maxOrig-minOrig);
    
    % Trans function calculation
    slopeValue=requiredRange/oldRange;
    transFunc=[minOrig:maxOrig]';
    for i = 1:oldRange + 1
       transFunc(i) = uint8(((double(transFunc(i) - minOrig) * slopeValue) + minRequired));
    end
    
    % Scaling the image
    scaledIm = uint8((((inputIm - minOrig) * requiredRange) / oldRange) + minRequired);      
end