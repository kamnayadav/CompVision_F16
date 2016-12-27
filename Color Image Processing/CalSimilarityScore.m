% Name              : Kamna Yadav
% A Number          : A02048769
% File name         : CalSimilarityScore.m
% File description  : To calculate Similarity Score of two histograms

% The method has been designed to calculate a similarity score for two
% images using their normalized HSV histograms

% Paratmeters :
%   Input:      
%           histH             : Histogram of first image
%           histG             : Histogram of second image
%           rowH              : # Rows in first image
%           colH              : # Columns in first image
%           rowG              : # Rows in second image
%           colG              : # Columns in second image

%   Output:
%           score             : Similarity score identified for the images
function [score] = CalSimilarityScore(histH, histG, rowH, colH, rowG, colG)
    h = rowH * colH;
    g = rowG * colG;
    den = min(h, g);

    num = 0;
    for i = 1:length(histH)
        num = num + min(histH(i) * h, histG(i) * g);
    end
    score = num/den;
end