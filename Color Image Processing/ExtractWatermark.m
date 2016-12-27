% Name              : Kamna Yadav
% A Number          : A02048769
% File name         : ExtractWatermark.m
% File description  : To extract watermark from an image

% The method has been designed to extract embedded watermark from image

% Paratmeters :
%   Input:      
%           inputIm           : Input Image
%           betaVal           : Threshold value to be used for watermark
%                               extraction
%
%   Output:
%           extB              : Extracted watermark matrix
function[extB] = ExtractWatermark(inputIm, betaVal)
    dwtmode('per');
    [c3,s3] = wavedec2(inputIm, 3, 'db9');
    sizeOfThirdLevel = s3(1);
    H = c3(1:sizeOfThirdLevel * sizeOfThirdLevel);
    extB = zeros(size(H));
    for i = 1:sizeOfThirdLevel * sizeOfThirdLevel
        if(mod(H(i),betaVal) > (betaVal / 2))
            extB(i) = 1;
        end
    end
end