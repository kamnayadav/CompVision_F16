% Name              : Kamna Yadav
% A Number          : A02048769
% File name         : CalEdgeHist.m
% File description  : Main code file for calculating Edge Histogram

% The method has been designed to calculate edge orientation histogram for
% input

% Paratmeters :
%   Input:      
%           im                : Image for edge histogram calculation
%           bins              : Number of bins to be created

%   Output:
%           edgeHist          : Edge histogram

function [ edgeHist ] = CalEdgeHist(im, bins)
    im = double(im);
    gX = [-1,-2,-1;0,0,0;1,2,1];
    filteredGX = imfilter(im, gX);
    gY = gX'; 
    filteredGY = imfilter(im, gY);
    arcTanArray = atan2d(filteredGX(:), filteredGY(:)) + 360 * (filteredGX(:) < 0);
    
    edgeHist = zeros(1,bins);
    for countVal = 1:length(arcTanArray)
        indexVal = floor(arcTanArray(countVal)/(bins - 2)) + 1;
        edgeHist(1,indexVal) = edgeHist(1,indexVal) + 1;
    end
end

