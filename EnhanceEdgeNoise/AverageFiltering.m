% Name              : Kamna Yadav
% A Number          : A02048769
% File name         : AverageFiltering.m
% File description  : Main code file for Averaging Filter

% The method has been designed perform average filtering function on the input

% Paratmeters :
%   Input:      
%           im                : Image for averaging
%           mask              : Mask to be used for image averaging

%   Output:
%           filteredIm        : Filtered image

function [filteredIm] = AverageFiltering (im, mask)
    
    % Basic processing and validation
    [rows, cols] = size(im);
    [sizeX, sizeY] = size(mask);
    maskT = mask';
    if sizeX ~= sizeY
        disp('Not a square mask');
    elseif sizeX/2 == 0
        disp('Not an odd dimensioned mask');
    elseif maskT ~= mask
        disp('Not symmetrical');
    else
        
        % Image averaging
        totalSize = sum(mask(:));
        filteredIm = uint8(zeros(size(im)));
        maskLoopX = floor(sizeX/2);
        maskLoopY = floor(sizeY/2);
        inputIm = uint8(zeros(rows + sizeX - 1,cols + sizeY - 1));
        inputIm(maskLoopX + 1:rows + maskLoopX,maskLoopY + 1:cols + maskLoopY) = im(1:rows,1:cols);
        for rowNum = maskLoopX + 1:rows + maskLoopX
            for colNum = maskLoopY + 1:cols + maskLoopY
                A = double(inputIm(rowNum - maskLoopX:rowNum + maskLoopX,colNum - maskLoopY:colNum + maskLoopY)).*mask(1:sizeX,1:sizeY);
                sumV = sum(A(:));
                filteredIm(rowNum - maskLoopX,colNum - maskLoopY) = floor(sumV / totalSize);
            end
        end
    end
end