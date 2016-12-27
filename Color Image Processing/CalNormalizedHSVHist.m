% Name              : Kamna Yadav
% A Number          : A02048769
% File name         : CalNormalizedHSVHist.m
% File description  : To calculate normalized HSV histogram

% The method has been designed to calculate normalized HSV histogram

% Paratmeters :
%   Input:      
%           Im                : Input image
%           HbinNum           : # bins required in Hue colorspace
%           SbinNum           : # bins required in Saturation colorspace
%           VbinNum           : # bins required in Value colorspace

%   Output:
%           Hist              : Output normalized HSV histogram
function [Hist] = CalNormalizedHSVHist(Im, HbinNum, SbinNum, VbinNum)
    hsvImage = rgb2hsv(Im);
    H = hsvImage(:,:,1);
    S = hsvImage(:,:,2);
    V = hsvImage(:,:,3);
    Hist = zeros(1, HbinNum * SbinNum * VbinNum);
    [rows,cols,~] = size(hsvImage);
    for i = 1:rows
        for j = 1:cols
            hBinVal = floor(H(i,j) * HbinNum) + 1;
            if(hBinVal > HbinNum)
                hBinVal = HbinNum;
            end
            sBinVal = floor(S(i,j) * SbinNum) + 1;
            if(sBinVal > SbinNum)
                sBinVal = SbinNum;
            end
            vBinVal = floor(V(i,j) * VbinNum) + 1;
            if(vBinVal > VbinNum)
                vBinVal = VbinNum;
            end
            index = SbinNum * VbinNum * (hBinVal - 1) + VbinNum * (sBinVal - 1) + vBinVal;
            Hist(index) = Hist(index) + 1;
        end
    end
    
	Hist = Hist ./ (rows*cols);
end