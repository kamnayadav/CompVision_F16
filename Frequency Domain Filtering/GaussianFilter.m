% Name              : Kamna Yadav
% A Number          : A02048769
% File name         : Gaussian.m
% File description  : Main code file for Gaussiam filter

% The method has been designed perform Gaussian filtering in frequency
% domain

% Paratmeters :
%   Input:      
%           sampleIm          : Image for processing

%   Output:
%           outIm             : Filtered image
%           GFilter           : Gaussian filter used
function [ outIm, GFilter ] = GaussianFilter( sampleIm)
    % Converting from spatial to frequency domain and centering it
    [rows, cols] = size(sampleIm);
    freqIm = fft2(sampleIm);
    shiftIm = fftshift(freqIm);
    GFilter = zeros(rows, cols);
    xSigma = 50;
    ySigma = 25;

    % Creating the filter of the same size as that of image
    for rowLoop = 1:rows
        for colLoop = 1:cols
            intermedOut = ((rowLoop - floor(rows/2 + 1)) ^ 2 / ((2 * xSigma) ^ 2)) + ((colLoop - floor(cols/2 + 1)) ^ 2 / ((2 * ySigma) ^ 2));
            GFilter(rowLoop,colLoop) = exp(-intermedOut);
        end
    end
    
    % Applying the filter and converting back to spatial domain
    filteredIm = shiftIm .* GFilter;
    iFilShift = ifftshift(filteredIm);
    outIm = abs(ifft2(iFilShift));
end