% Name              : Kamna Yadav
% A Number          : A02048769
% File name         : MainScript.m
% File description  : Main code file for Histogram calculation

% The method has been designed to calculate both Normalized or regular
% Histograms for input image.

% Paratmeters :
%   Input:      
%           inputIm           : Image for histogram calculation
%           selectionVariable : Option to calculate histogram
%                           0 : Regular histogram only
%                           1 : Normalized histogram only
%                           2 : Both normalized and the regular histogram
%

%   Output:
%           varargout         : Array of output histograms
function [varargout]=CalHist(inputIm,selectionVariable)
    hist = zeros(1,256);
    normArray=zeros(1,256);
    [row,col] = size(inputIm);
    for rowNum = 1:row
        for colNum = 1:col
            hist(inputIm(rowNum,colNum) + 1) = hist(inputIm(rowNum,colNum) + 1) + 1;
        end 
    end
    
    switch(selectionVariable)
        case 0
            %return Histogram
            varargout{1} = hist;
        case 1
            %return Normalized Histogram
            for loopCount = 1:256
                normArray(loopCount) = hist(loopCount) / (row*col);
            end
            varargout{1} = normArray;
        case 2
            %return both Histograms
            varargout{1} = hist;
            for loopCount = 1:256
                normArray(loopCount) = hist(loopCount)/(row*col);
            end
            varargout{2} = normArray;
    end
end