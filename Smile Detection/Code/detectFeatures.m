% Name              : Kamna Yadav
% A Number          : A02048769
% File name         : features.m
% File description  : Feature extraction and pre-processing features for
% positive and negative testdata
% 
% Method : detectFeatures
%
% Used to preprocess the input image directory and extract features and class labels for all
% the images present in the directory
% 
% Input:
% pathToData : Directory path for the images
% dataType   : Type of input data. Can have following values
%         1  : Positive Training Data
%         2  : Negative Training Data
%         3  : Testing Data
%
%
% Output:
% featureArr : HOG Feature array for all images in the directory
% classArr   : Class label array for all images in the directory
%         -1 : For negative training samples
%          1 : For positive training samples
%          0 : For testing samples

function [featureArr, classArr] = detectFeatures(pathToData, dataType)
    % Build detector for facial feature extraction

    % Input dataset reading
    filePattern = fullfile(pathToData, '*.jpg');
    imlist = dir(filePattern);
    
    % Feature matrix and class-label array
    featureArr = zeros(length(imlist), 1764);
    classArr = zeros(length(imlist),1);
    
    % Identifying class label as per input parameter value
    if dataType == 1
            classLabel = 1;
        else
            if dataType == 2
                classLabel = -1;
            else
                classLabel = 0;
            end
    end
        
    for i = 1:length(imlist)
        % Reading the input file
        baseFileName = imlist(i).name;
        fullFileName = fullfile(pathToData, baseFileName);
        rgbIm = imread(fullFileName);
        
        % Detecting the facial features
 
        % Extracting HOG features from the resized image
        fp = extractHOGFeatures(double(rgbIm));
        
        % Normalizing the data to lie in range of 0 to 255
        minfp = min(fp(:));
        maxfp = max(fp(:));
        origRange = maxfp - minfp;
        desMin = 0;
        desMax = 255;
        desRange = desMax - desMin;
        fp1 = desRange * (fp - minfp) / origRange + desMin;
        
        % Assigning output features and class-labels
        featureArr(i,:) = uint8(fp1);
        classArr(i) = classLabel;
        
    end
end