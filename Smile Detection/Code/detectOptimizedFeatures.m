% Name              : Kamna Yadav
% A Number          : A02048769
% File name         : detectOptimizedFeatures.m
% File description  : Feature extraction and pre-processing features for
% positive and negative testdata using optimized algorithm
% 
% Method : detectOptimizedFeatures
%
% Used to preprocess the input image directory and extract features (Optimized) and class labels for all
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

function [featureArr, classArr] = detectOptimizedFeatures(pathToData, dataType)
    % Build detector for facial feature extraction
    detector = buildDetector();

    % Input dataset reading
    filePattern = fullfile(pathToData, '*.jpg');
    imlist = dir(filePattern);
    
    % Feature matrix and class-label array
    featureArr = zeros(length(imlist), 36);
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
        [bbox, ~, ~, ~] = detectFaceParts(detector,rgbIm,2);
        
        % Crop the face from the input
        faceImage = imcrop(rgbIm, bbox(1:4)); 
        
        % Identifying the skew angle on the basis of eyes
        leftEyeX = bbox(5);
        leftEyeY = bbox(6);
        rightEyeX = bbox(9);
        rightEyeY = bbox(10);
        slopeN = (rightEyeY - leftEyeY) / (rightEyeX - leftEyeX);
        angleR = atand(slopeN);
        
        % Rotating image to correct skew
        rotIm = imrotate(faceImage, angleR);
        
        % Cropping rotated face
        [RowRot, ColRot] = size(rotIm);
        [Rows, Cols] = size(faceImage);
        XDiff = RowRot - Rows;
        YDiff = ColRot - Cols;
        CropIm = imcrop(faceImage,[XDiff/2 YDiff/2 Rows Cols]);

        % Resizing image to 64 X 64 dimension for better efficiency
        ResizedIm = imresize(CropIm, [64 64]);
        
        % Optimization done for Gradient of Self-similarity features
        blkResIm = mat2cell(ResizedIm, [16 16 16 16], [16 16 16 16],3);
        dehf = extractHOGFeatures(double(blkResIm{1}));
        for iVal=2:16
            ehf2 = extractHOGFeatures(double(blkResIm{iVal}));
            for kl = 1:length(ehf2)
                dehf(kl) = min(dehf(kl),ehf2(kl));
            end
        end
        
        fp = dehf;
        
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