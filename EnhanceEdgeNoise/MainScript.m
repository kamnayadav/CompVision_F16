% Name              : Kamna Yadav
% A Number          : A02048769
% File name         : MainScript.m
% File description  : Main code file with all the required functionality

clear;
close all;

% Question 1 Part 1 : Average Filtering
% Average filtering using a weighted mask
CircuitIm = imread('Circuit.jpg');
weightedMask = [1 2 1; 2 4 2; 1 2 1];
weightedFilteredIm = AverageFiltering(CircuitIm, weightedMask);

% Average filtering using a standard mask
standardMask = ones(5,5);
standardFilteredIm = AverageFiltering(CircuitIm, standardMask);

% Plotting the outputs
figure(1);
subplot(1,3,1),imshow(CircuitIm),title('Input Image');
subplot(1,3,2),imshow(standardFilteredIm),title('Standard Averaging Filter');
subplot(1,3,3),imshow(weightedFilteredIm),title('Weighted Averaging Filter');
disp('Finished solving problem 1.1');
pause;

%
% Question 1 Part 2 : Median Filtering
% Median filtering using a weighted mask
weightedMask = [1 2 1; 2 4 2; 1 2 1];
[weightedFilteredIm] = MedianFiltering(CircuitIm, weightedMask);

% Median filtering using a standard mask
standardMask = ones(5,5);
[standardFilteredIm] = MedianFiltering(CircuitIm, standardMask);

% Plotting the outputs
figure(2);
subplot(1,3,1),imshow(CircuitIm),title('Input Image');
subplot(1,3,2),imshow(standardFilteredIm),title('Standard Median Filter');
subplot(1,3,3),imshow(weightedFilteredIm),title('Weighted Median Filter');
disp('Finished solving problem 1.2');
pause;

%
% Question 1 Part 3
% Image filtering using a Strong Laplacian Mask
moon = imread('moon.jpg');
strongLaplacianMask = [1,1,1;1,-8,1;1,1,1];
FilteredImage = imfilter(double(moon),strongLaplacianMask);
EnhancedImage = uint8(double(moon) - FilteredImage);

% Plotting the desired outputs
figure(3);
subplot(2,2,1), imshow(moon), title('Original');
subplot(2,2,2), imshow(FilteredImage,[0 255]), title('Filtered');
subplot(2,2,3), imshow(FilteredImage,[]), title('Scaled');
subplot(2,2,4), imshow(EnhancedImage), title('Enhanced');
disp('Finished solving problem 1.3');
pause;

%
% Question 2 Part 1 : Sobel Edge detection
% Sobel Edge detection algorithm
inputImage = imread('Rice.jpg');
mask = [-1,-2,-1;0,0,0;1,2,1];
outputEdge = SobelEdgeFilter(inputImage,mask);

% Plotting the desired outputs
figure(4);
subplot(1,2,1), imshow(inputImage), title('Original');
subplot(1,2,2), imshow(outputEdge, []), title('Edge Image');
disp('Finished solving problem 2.1');
pause;

%
% Question 2 Part 2 : Edge histogram calculator
% Edge histogram algorithm
angleHist = CalEdgeHist(inputImage, 20);

% Plotting the desired outputs
figure(5);
bar(angleHist);
subplot(1,3,1), imshow(inputImage), title('Input Image');
subplot(1,3,2), imshow(outputEdge,[0 1]), title('Edge Image');
subplot(1,3,3), bar(angleHist, 'hist'), title('Histogram');
pause;

%
% Question 3
% Image enhancement and text extraction
img = imread('Text1.gif');
ep = EnhanceImg(img);

% Plotting the desired outputs
figure(6);
imshow(ep,[0 1]),title('Enhanced Output Image');
disp('Finished solving problem 3');
pause;