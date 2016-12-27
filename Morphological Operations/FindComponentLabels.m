% Name              : Kamna Yadav
% A Number          : A02048769
% File name         : FindComponentLabels.m
% File description  : Code file for connected component handling

% The method has been designed to identify connected components

% Paratmeters :
%   Input:      
%           im                : Input image
%           se                : Structuring element to be used

%   Output:
%           labelIm           : Labelled image
%           counter           : Number of identified components
function [labelIm, counter] = FindComponentLabels(im, se)
    [rows, cols] = size(im);
    counter = 0;
    labelIm = zeros(rows, cols);
    for i = 1:rows
        for j = 1:cols
            if im(i, j) == 1
                counter = counter + 1;
                X0 = zeros(rows, cols);
                X0(i, j) = 1;
                while(true)
                    X1 = imdilate(X0, se) & im;             
                    if X1 == X0
                        index = X1==1;
                        im(index) = 0;
                        labelIm(index) = counter;
                        break
                    else
                        X0 = X1;
                    end
                end
            end
        end
    end
end
