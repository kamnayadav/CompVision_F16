% Name              : Kamna Yadav
% A Number          : A02048769
% File name         : BlurImage.m
% File description  : Main code file for BlurImage function

%
% Function to blur the image using a 4X4 matrix
%
function [blurredIm] = BlurImage(oriIm)
    blurredIm = oriIm;

    %check the bit depth of the input    
    [rows,cols,numberOfColorChannels]=size(oriIm);
    
    %Run loop to calculate the mean for the 4X4 submatrices and then
    %assign them to the output image for blurring effect
    for rowNum=1:4:rows
        for colNum=1:4:cols
            %for Grayscale images
            if numberOfColorChannels == 1
                tempArray = oriIm(rowNum:rowNum+4-1, colNum:colNum+4-1); %temp 4X4 submatrix
                meanVal = mean(tempArray(:)); %mean value for the pixels in the selected region
                blurredIm(rowNum:rowNum+4-1,colNum:colNum+4-1) = meanVal; %assigning the mean to pixels in output
            end
            %For Color images
            if numberOfColorChannels == 3
                %create a 4X4 submatrix for each color space
                tempRArray = oriIm(rowNum:rowNum+4-1, colNum:colNum+4-1,1);
                tempGArray = oriIm(rowNum:rowNum+4-1, colNum:colNum+4-1,2);
                tempBArray = oriIm(rowNum:rowNum+4-1, colNum:colNum+4-1,3);
                
                %calculate the mean values for the three color space arrays
                meanRVal = mean(tempRArray(:));
                meanGVal = mean(tempGArray(:));
                meanBVal = mean(tempBArray(:));
                
                %Assign calculated mean value to respective colorspace pixels
                blurredIm(rowNum:rowNum+4-1,colNum:colNum+4-1,1) = meanRVal;
                blurredIm(rowNum:rowNum+4-1,colNum:colNum+4-1,2) = meanGVal;
                blurredIm(rowNum:rowNum+4-1,colNum:colNum+4-1,3) = meanBVal;
            end
        end
    end
end