% Name              : Kamna Yadav
% A Number          : A02048769
% File name         : Butterworth.m
% File description  : Main file for the noise modelling filter for Weiner

% The method has been designed to add noise to input

% Paratmeters :
%   Input:      
%           input           : Image for processing

%   Output:
%           output          : Noisy image
function [output] = NoiseModel(input)
    [rows, cols] = size(input);
    output = zeros(size(input));
    rowHalf = rows/2;
    colHalf = cols/2;
    k = 0.0025;
    for rowLoop = 1:rows
        for colLoop = 1:cols
            Duv = sqrt((rowLoop - (rowHalf + 1))^2 + (colLoop - (colHalf + 1))^2);        
            intermedOut = k * (Duv)^(5/3);
            output(rowLoop,colLoop) = exp(-intermedOut);
        end
    end
end