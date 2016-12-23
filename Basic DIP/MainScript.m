% Name              : Kamna Yadav
% A Number          : A02048769
% File name         : MainScript.m
% File description  : Main code file with all the required functionality

clear;
close all;

%
% Question 1 : Linear Scaling function implementation
%
food = imread('Food.jpg');
desiredMin=0.0;
desiredMax=0.9;
range = [desiredMin desiredMax];
[scaledFood , linearTransFunc] = Scaling(food,range);
figure(1);
plot(linearTransFunc),ylabel('Pixel Intensities'),xlabel('Index in the TransFunction');
disp('-----Finished Solving Problem 1-----');
pause;

%
% Question 2 : Matlab Linear Scaling function
%
matlabScaledFoodImage = im2uint8(imadjust(food,[0.35;0.54],[desiredMin;desiredMax]));
figure(2);
subplot(1,2,1),imshow(scaledFood),title('My function Scaled Image');
subplot(1,2,2),imshow(matlabScaledFoodImage),title('Matlab Scaled Image');
disp('-----Finished Problem Solving 2-----')
pause;

%
% Question 3 : Histogram Calculation function
% 1st Parameter : Image to be used for histogram calculation
% 2nd Parameter : Option to calculate histogram
%               0 : Regular histogram only
%               1 : Normalized histogram only
%               2 : Both normalized and the regular histogram
%

% Calculate both regular and normalized histograms
[myFunctionScaledHist, myFunctionNormScaledHist]=CalHist(scaledFood,2);

% Calculate just normalized histogram
[normMatlabScaled]=CalHist(matlabScaledFoodImage,1);

% Plotting the normalized histograms
figure(3);
subplot(1,2,1),plot(myFunctionNormScaledHist),xlabel('Pixel Intensity Values'),ylabel('Pixels count');
title('My Scaled Image Histogram');
subplot(1,2,2),plot(normMatlabScaled),xlabel('Pixel Intensity Values'),ylabel('Pixels count');
title('Matlab Scaled Image Histogram');
disp('-----Finished Problem Solving 3-----');
pause;

%
% Question 4 : Discrete Histogram Equalization
%
[equalizedFood , histEqTransFunc] = HistEqualization(food);
disp('-----Finished Solving Problem 4-----');
pause;

%
% Question 5 : Matlab Histogram Equalization
%
[matEqualizedImg, matHistEqTransFunc] = histeq(food);
matHistEqTransFunc = round(matHistEqTransFunc * 255);

% Plotting the equalized images
figure(4);
subplot(1,2,1),imshow(matEqualizedImg),title('Matlab Equalized Image');
subplot(1,2,2),imshow(equalizedFood),title('My Equalized Image');
pause;

% Plotting the transform functions
figure(5);
subplot(1,2,1),plot(matHistEqTransFunc),title('Matlab transform function');
xlabel('Input pixel value'),ylabel('Equalized Value');
subplot(1,2,2),plot(histEqTransFunc),title('My Transform Function');
xlabel('Input pixel value'),ylabel('Equalized Value');
disp('-----Finished Solving Problem 5-----');
pause;