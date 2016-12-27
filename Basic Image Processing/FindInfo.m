% Name              : Kamna Yadav
% A Number          : A02048769
% File name         : FindInfo.m
% File description  : Main code file for FindInfo function

%
% Function to calculate and return Minimum, maximum, mean and median value
% for an image
%

function [maxValue, minValue, meanValue, medianValue] = FindInfo(oriIm)
    maxValue = 0;
    minValue = 255;
    sum = 0;
    doubleImg = double(oriIm);
    [rows, cols] = size(doubleImg);
    for rowNum=1:rows
        for colNum=1:cols
            if(doubleImg(rowNum,colNum) > maxValue)
                maxValue = doubleImg(rowNum,colNum); % Maximum value calculation
            end
            if(doubleImg(rowNum,colNum) < minValue)
                minValue = doubleImg(rowNum,colNum); % Minimum value calculation
            end
            sum = sum + doubleImg(rowNum,colNum);
        end
    end
    meanValue = sum / (rows * cols); % Mean value calculation

    %median calculation
    MedSortedArray = oriIm(:);
    MedSortedArray = sort(MedSortedArray);
    TotalPixelCount = rows*cols;
    if mod(TotalPixelCount,2) == 0
        medianValue = (MedSortedArray(TotalPixelCount/2)+MedSortedArray((TotalPixelCount/2)+1))/2;
    else
        medianValue = (MedSortedArray((TotalPixelCount/2)+1));
    end
end
