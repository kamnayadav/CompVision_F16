% Name              : Kamna Yadav
% A Number          : A02048769
% File name         : MedianFiltering.m
% File description  : Main code file for Median Filter

% The method has been designed perform median filtering function on the input

% Paratmeters :
%   Input:      
%           im                : Image for median filtering
%           mask              : Mask to be used for median filtering

%   Output:
%           filteredIm        : Filtered image

function filteredIm = MedianFiltering(im, mask)
    
    % Basic processing and validation
    [rows, cols] = size(im);
    [sizeX, sizeY] = size(mask);
    if sizeX ~= sizeY
        disp('Not a square mask');
    elseif sizeX/2 == 0
        disp('Not an odd dimensioned mask');
    else
        % Median Filtering
        filteredIm = uint8(zeros(size(im)));
        maskReshaped=reshape(mask',sizeX*sizeY,1);
        maskLoopX = floor(sizeX/2);
        maskLoopY = floor(sizeY/2);
        inputIm = uint8(zeros(rows + sizeX - 1,cols + sizeY - 1));
        inputIm(maskLoopX + 1:rows + maskLoopX,maskLoopY + 1:cols + maskLoopY) = im(1:rows,1:cols);

        for rowNum = maskLoopX + 1:rows + maskLoopX
            for colNum = maskLoopY + 1:cols + maskLoopY
                tempInputVector = reshape(inputIm(rowNum - maskLoopX:rowNum + maskLoopX,colNum - maskLoopY:colNum + maskLoopY),sizeX*sizeY,1);
                medArray = repelem(tempInputVector,maskReshaped);
                medianVal = median(medArray(:),1);
                filteredIm(rowNum - maskLoopX,colNum - maskLoopY) = medianVal;
            end
        end
    end
end