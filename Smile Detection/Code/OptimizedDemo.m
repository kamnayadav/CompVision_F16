% Name              : Kamna Yadav
% A Number          : A02048769
% File name         : OptimizedDemo.m
% File description  : Demo file for the optimized algorithm

clear;

% Set path for the testdata
pathPos = 'D:\Assignments\ComputerVision\Project\Deliverables\Code\Images\Genki\Pos';
pathNeg = 'D:\Assignments\ComputerVision\Project\Deliverables\Code\Images\Genki\Neg';
pathTest = 'D:\Assignments\ComputerVision\Project\Deliverables\Code\Images\Genki\Test';

% Extract HOG feature data after pre-processing training images
disp('Positive training');
tic
[featurePos, classPos] = detectOptimizedFeatures(pathPos, 1);
toc;

disp('Negative training');
tic
[featureNeg, classNeg] = detectOptimizedFeatures(pathNeg, 2);
toc;

% Concatenate the Positive and Negative test set data
ftotal = vertcat(featurePos, featureNeg);
ctotal = vertcat(classPos, classNeg);

% Create the classification model for the training data
disp('SVM training');
tic
SVMModel = fitcsvm(ftotal,ctotal);
toc;

% Extract HOG feature data after pre-processing testing images
disp('Testing');
tic
[featureTest, classTest] = detectOptimizedFeatures(pathTest, 3);
toc;

% Predict class labels for testing data
disp('Prediction');
tic
label = predict(SVMModel, featureTest);
toc;