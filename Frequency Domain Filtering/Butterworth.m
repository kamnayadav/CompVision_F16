% Name              : Kamna Yadav
% A Number          : A02048769
% File name         : Butterworth.m
% File description  : Main code file for Butterworth filter

% The method has been designed perform Butterworth filtering in frequency
% domain

% Paratmeters :
%   Input:      
%           sampleIm          : Image for processing

%   Output:
%           outIm             : Filtered image
%           GFilter           : Butterworth filter used
function [outIm, BFilter] = Butterworth( input )
    % Converting from spatial to frequency domain and centering it
    freqIm = fft2(input);
    shiftIm = fftshift(freqIm);
    BFilter = zeros(size(input));
    [rows, cols] = size(input);
    rowHalf = rows / 2;
    colHalf = cols / 2;
    d = 50;
    n = 2;
    
    % Creating the filter of the same size as that of image
    for rowLoop = 1:rows
        for colLoop = 1:cols
            s = 1/  (1 + (d/ (sqrt((rowLoop - (rowHalf + 1))^2 + (colLoop - (colHalf + 1))^2)))^2*n);
            BFilter(rowLoop,colLoop) = s;
        end
    end
    
    % Applying the filter and converting back to spatial domain
    filteredIm = shiftIm .* BFilter;
    iFilShift = ifftshift(filteredIm);
    outIm = abs(ifft2(iFilShift));
end

