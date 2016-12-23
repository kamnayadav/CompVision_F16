% Name              : Kamna Yadav
% A Number          : A02048769
% File name         : EnhanceImg.m
% File description  : Main code file for Text image enhancing
function [enhancedIm] = EnhanceImg(img)
    [~, ~, colorRange] = size(img);
    if colorRange > 1
        img = rgb2gray(img);
    end
    
    tempq = imadjust(img,[0 1],[0.7 1]);
    enhancedIm = uint8(ones(size(tempq)));
    index = find(tempq < 200);
    enhancedIm(index) = 0;
    subplot(1,2,1), imshow(tempq,[min(tempq(:)) max(tempq(:))]),title('Adjusted input image');
    subplot(1,2,2), imshow(img),title('Gray input image');
end