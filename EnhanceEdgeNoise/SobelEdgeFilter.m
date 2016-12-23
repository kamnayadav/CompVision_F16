% Name              : Kamna Yadav
% A Number          : A02048769
% File name         : SobelFilter.m
% File description  : Main code file for Sobel Filter

% The method has been designed to detect edges using Sobel Edge Detector

% Paratmeters :
%   Input:      
%           inputIm           : Image for histogram equalization
%           mask              : Edge detector mask to be used

%   Output:
%           edgeIm            : Edge image

function [edgeIm] = SobelEdgeFilter(im, mask)
    % Basic processing
    [rows, cols] = size(im);
    [sizeX, sizeY] = size(mask);
    outIm = uint8(zeros(size(im)));
    maskLoopX = floor(sizeX/2);
    maskLoopY = floor(sizeY/2);
    inputIm = uint8(zeros(rows + sizeX - 1,cols + sizeY - 1));
    inputIm(maskLoopX + 1:rows + maskLoopX,maskLoopY + 1:cols + maskLoopY) = im(1:rows,1:cols);
    
    xMask = mask;
    yMask = mask';
    
    % Edge detection algorithm
    for rowNum = maskLoopX + 1:rows + maskLoopX
        for colNum = maskLoopY + 1:cols + maskLoopY
            tempArr = inputIm(rowNum - maskLoopX:rowNum + maskLoopX,colNum - maskLoopY:colNum + maskLoopY);
            gX = double(tempArr).*xMask;
            sumX = sum(gX(:));

            gY = double(tempArr).*yMask;
            sumY = sum(gY(:));

            outIm(rowNum - maskLoopX,colNum - maskLoopY) = floor(sqrt(sumX*sumX + sumY*sumY));
        end
    end
    
    % Output assignment
    edgeIm = uint8(ones(size(im)));
    index = find(outIm < (max(outIm(:)) * 0.75));
    edgeIm(index) = 0;
end