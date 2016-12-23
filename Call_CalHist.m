% Name              : Kamna Yadav
% A Number          : A02048769
% File name         : MainScript.m

%
% Histogram Calculation function
% 1st Parameter : Image to be used for histogram calculation
% 2nd Parameter : Option to calculate histogram
%               0 : Regular histogram only
%               1 : Normalized histogram only
%               2 : Both normalized and the regular histogram
%

% calculate both normalized and regular histograms
[myFunctionScaledHist, myFunctionNormScaledHist] = CalHist(scaledFood, 2);

% calculate just the normalized histogram
[normMatlabScaled] = CalHist(matlabScaledFoodImage, 1);

% Plotting the normalized histograms
figure(3);
subplot(1,2,1),plot(myFunctionNormScaledHist),xlabel('Pixel Intensity Values'),ylabel('Pixels count');
title('My Scaled Image Histogram');
subplot(1,2,2),plot(normMatlabScaled),xlabel('Pixel Intensity Values'),ylabel('Pixels count');
title('Matlab Scaled Image Histogram');
disp('-----Finished Problem Solving 3-----');
pause;