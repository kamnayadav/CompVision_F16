% Name              : Kamna Yadav
% A Number          : A02048769
% File name         : EmbedWatermark.m
% File description  : To embed watermark into an image

% The method has been designed to embed watermark into an image
% A 3-level “db9” wavelet decomposition on input and embed a watermark.

% Watermark would be a random sequence of 0’s and 1’s whose length equals to the 
% size of the approximation image (i.e., the top left subband LL3). Make sure 
% that this random sequence will be the same each time you re-run the program. 
% Sequentially embed each value of b into the approximation subband H in a 
% raster scanning order (from the left to the right and from the top to the bottom).

% Paratmeters :
%   Input:      
%           im                : Input Image
%           betaVal           : Threshold value to be used for watermark embedding

%   Output:
%           imnew             : Output watermarked image
%           b                 : Watermark matrix
function[imnew, b] = EmbedWatermark(im, betaVal)
    % Getting the appropriate wavelet subband
    dwtmode('per');
    [c,s] = wavedec2(im, 3, 'db9');
    sizeOfThirdLevel = s(1);
    
    % Watermark matrix
    rng default;
    b = round(rand(sizeOfThirdLevel, sizeOfThirdLevel));
 	H = c(1:sizeOfThirdLevel * sizeOfThirdLevel);
    newC3 = c;
    
    % Watermark embed part
    for i = 1:sizeOfThirdLevel * sizeOfThirdLevel
        condition1 = mod(H(i), betaVal);
        if(b(i) == 1)
            if(condition1 >= 0.25 * betaVal)
                newC3(i) = H(i) - mod(H(i), betaVal) + (0.75 * betaVal);
            else
                newC3(i) = (H(i) - (0.25*betaVal)) - (mod((H(i) - 0.25 * betaVal), betaVal)) + (0.75 * betaVal);
            end
        else
            if(condition1 <= 0.75 * betaVal)
                newC3(i) = H(i) - (mod(H(i), betaVal)) + (0.25 * betaVal);
            else
                newC3(i) = (H(i) + (0.5*betaVal)) - (mod((H(i) - 0.5 * betaVal), betaVal)) + (0.25 * betaVal);
            end
        end
    end
    
    % Assigning the output
    imnew = waverec2(newC3, s, 'db9');
    imnew = uint8(imnew);
end