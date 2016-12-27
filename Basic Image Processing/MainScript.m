% Name              : Kamna Yadav
% A Number          : A02048769
% File name         : MainScript.m
% File description  : Main code file with all the required functionality

%
% Question 1 : Load an image
%
A = imread('peppers.bmp');
figure('Name','RGB Original Image','NumberTitle','off');
imshow(A);
disp('-----Finished Solving Problem 1-----');
pause;


%
% Question 2 : Bit depth conversion and transpose
%
B = rgb2gray(A);
TB = B';
% Question part : 2.3
[origRows, origCols] = size(B);
TempImg = mat2cell(B, [origRows], [origCols/2 origCols/2]);
VB = cell2mat(fliplr(TempImg));

%Question part : 2.4
FB = fliplr(B);

%displaying the results in single window
figure;
subplot(2,2,1);
imshow(B);
title('B');
subplot(2,2,2);
imshow(TB);
title('TB');
subplot(2,2,3);
imshow(VB);
title('VB');
subplot(2,2,4);
imshow(FB);
title('FB');

disp('-----Finished Solving Problem 2-----');
pause;


%
% Question 3 : Find image info using inbuilt and compare with user-defined
% function outputs
%
maximumOrig = max(B(:));
minimumOrig = min(B(:));
meanOrig = mean(B(:));
medianOrig = median(B(:));

[maximumComputed, minimumComputed, meanComputed, medianComputed] = FindInfo(B);

if maximumOrig == maximumComputed
    disp('Maximum value calculated is same');
else
    disp('Maximum value calculated is different');
end
if minimumOrig == minimumComputed
    disp('Minimum value calculated is same');
else
    disp('Minimum value calculated is different');
end
if meanOrig == meanComputed
    disp('mean value calculated is same');
else
    disp('mean value calculated is different');
end
if medianOrig == medianComputed
    disp('Median value calculated is same');
else
    disp('Median value calculated is different');
end

disp('-----Finished Solving Problem 3-----');
pause;


%
% Question 4 : Gray scale image normalization
%
C = mat2gray(B);
figure('Name','Normalized Grayscale Image','NumberTitle','off');
imshow(C);
tempMatrix = mat2cell(C, [origRows], [(origCols/4) (origCols/4) (origCols/4) (origCols/4)]);

tempMatrix{4} = tempMatrix{4}.^(1.5);
tempMatrix{1} = tempMatrix{1}.^(0.5);
D = cell2mat(tempMatrix);
figure('Name','Processed Grayscale Image','NumberTitle','off');
imshow(D);

imwrite(D,'Kamna_D.jpg');
disp('-----Finished Solving Problem 4-----');
pause;


%
% Question 5 : Global thresholding for BW conversion : different method
% comparison
%

%first method
bw1 = C;
bw1(bw1 > 0.3) = 1;
bw1(bw1 ~= 1) = 0;

%second method
bw2 = zeros(size(C));
index = find(C > 0.3);
bw2(index) = 1;

%im2bw result
bw3 = im2bw(C,0.3);

if isequal(bw1,bw3) && isequal(bw2,bw3)
    disp('Both of my methods worked');
else if isequal(bw1,bw3) && (~(isequal(bw2,bw3)))
    disp('My method 1 worked but not my mthod 2');
    else if (~isequal(bw1,bw3)) && isequal(bw2,bw3)
    disp('My method 1 worked but not my mthod 2');
        end       
    end
end

figure;
subplot(1,3,1);
imshow(bw1);
title('My first method');
subplot(1,3,2);
imshow(bw2);
title('My second method');
subplot(1,3,3);
imshow(bw3);
title('Matlab method');
disp('-----Finished Solving Problem 5-----');
pause;


%
% Question 6 : Blur image feature
%

BA = BlurImage(A);
BB = BlurImage(B);
figure('Name','Blur Image Function','NumberTitle','off');
subplot(2,2,1), imshow(A), title('A');
subplot(2,2,2), imshow(B), title('B');
subplot(2,2,3), imshow(BA), title('BA');
subplot(2,2,4), imshow(BB), title('BB');

disp('-----Finished Solving Problem 6-----');
pause;

close all;
clear;