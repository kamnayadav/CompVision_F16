% Name              : Kamna Yadav
% A Number          : A02048769
% File name         : MainScript.m
% File description  : Main code file for Histogram Equalization

% The method has been designed to perform discrete Histogram equalization

% Paratmeters :
%   Input:      
%           inputIm           : Image for histogram equalization

%   Output:
%           enhancedIm        : Histogram equalized (enhanced) image
%           transFunc         : Transfunction used for calculating new
%                               intensity values

function[enhancedIm , transFunc] = HistEqualization(inputIm)
    [rows,cols] = size(inputIm);
    enhancedIm = uint8(zeros(rows,cols));
    totalNumPixels = rows * cols;

    histogramRegular = zeros(256,1);
    normalizedHist=zeros(256,1);
    transFunc=zeros(256,1);

    %calculating histogram and normalized histogram
    for rowNum = 1:rows
        for colNum = 1:cols
            value = inputIm(rowNum,colNum);
            histogramRegular(value+1) = histogramRegular(value+1)+1;
            normalizedHist(value+1)=histogramRegular(value+1)/totalNumPixels;
        end
    end

    %calculating the cumulative normalized histogram and transformed intensity
    cumulativeHist=zeros(256,1);
    sum=0;
    for rowNum=1:size(normalizedHist)
        sum = sum + histogramRegular(rowNum);
        cumulativeHist(rowNum) = sum / totalNumPixels;
        transFunc(rowNum) = round(cumulativeHist(rowNum) * 255);
    end

    %calculating the final enhanced image
    for rowNum = 1:rows
        for colNum = 1:cols
            enhancedIm(rowNum,colNum) = transFunc(inputIm(rowNum,colNum) + 1);
        end
    end
end