% Name              : Kamna Yadav
% A Number          : A02048769
% File name         : DemoOriginal.m
% File description  : Demo file for the original algorithm

clear;

% Set path for the testdata
pathPos = 'D:\Assignments\ComputerVision\Project\Deliverables\Code\Images\SMILEs\Pos';
pathNeg = 'D:\Assignments\ComputerVision\Project\Deliverables\Code\Images\SMILEs\Neg';
pathTest = 'D:\Assignments\ComputerVision\Project\Deliverables\Code\Images\SMILEs\Test';

% Extract HOG feature data after pre-processing training images
disp('Positive training');
tic
[featurePos, classPos] = detectFeatures(pathPos, 1);
toc
disp('Negative training');
tic
[featureNeg, classNeg] = detectFeatures(pathNeg, 2);
toc
% Concatenate the Positive and Negative test set data
ftotal = vertcat(featurePos, featureNeg);
ctotal = vertcat(classPos, classNeg);

% Create the classification model for the training data
disp('SVM training');
tic
SVMModel = fitcsvm(ftotal,ctotal);
toc

% Extract HOG feature data after pre-processing testing images
disp('Testing');
tic
[featureTest, classTest] = detectFeatures(pathTest, 3);
toc

% Predict class labels for testing data
disp('Prediction');
tic
label = predict(SVMModel, featureTest);
toc