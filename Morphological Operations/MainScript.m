% Name              : Kamna Yadav
% A Number          : A02048769
% File name         : MainScript.m
% File description  : Main code file with all the required functionality

close all;
clear;

%
% Question 1 Part 1 : Morphological operation application
%
city = imread('City.jpg');
strucElement = strel('square',3);
dilatedIm = imdilate(city, strucElement);
erodedIm = imerode(city, strucElement);
finalImage = dilatedIm - erodedIm;

% Plotting the output
figure(1);
imshow(finalImage), title('Final output : Dilated - Eroded image');
disp('Since we first dilated and then eroded the image, the output will have fine boundaries of the places in the image where there are transitions in high and low intensities.');
disp('------Finished Solving Problem One Part One------');
pause;

%
% Question 1 Part 2 : Morphological operation(s) to locate foreground 
% pixels that have east and north neighbors and that have 
% no north-west, west, southwest, south, or south-east neighbors
%
squares = imread('SmallSquares.tif');
nhood = [0 0 0; 1 1 0; 1 1 0];
strucElement = strel(nhood);
dilatedIm = imerode(squares, strucElement);
nhood = [1 1 1; 0 0 1; 0 0 1];
strucElement = strel(nhood);
InvertedIm = imcomplement(squares);
invertErode = imerode(InvertedIm, strucElement);
finalIm = invertErode & dilatedIm;
numOfPixels = sum(finalIm(:));
figure(2);
subplot(1,2,1), imshow(finalIm), title('Output Image');
subplot(1,2,2), imshow(squares), title('Input Image');
disp('Number of white pixels remianing in final output = ');
disp(numOfPixels);
disp('------Finished Solving Problem One Part Two------');
pause;


%
% Question 1 Part 3 : Morphological operations to get desired outputs as
% per problem statement
%
wirebond = imread('Wirebond.tif');
strucElement = strel('disk',5);
Figure1Im = imerode(wirebond, strucElement);
strucElement = strel('disk',11);
Figure2Im = imerode(wirebond, strucElement);
strucElement = strel('disk',21);
Figure3Im = imerode(wirebond, strucElement);
figure(3);
subplot(2,2,1), imshow(wirebond),title('Original Image');
subplot(2,2,2), imshow(Figure2Im),title('Desired Image 1');
subplot(2,2,3), imshow(Figure1Im),title('Desired Image 2');
subplot(2,2,4), imshow(Figure3Im),title('Desired Image 3');
disp('------Finished Solving Problem One Part Three------');
pause;


%
% Question 1 Part 4 : Morphological operations to get desired outputs as
% per problem statement
%
shapes = imread('Shapes.tif');
strucElement = strel('square', 21);
Figure1Im = imopen(shapes, strucElement);
Figure2Im = imclose(shapes, strucElement);
strucElement = strel('square', 20);
Figure3Im = imopen(shapes, strucElement);
Figure3Im = imclose(Figure3Im, strucElement);
figure(4);
subplot(2,2,1), imshow(shapes), title('Original Image');
subplot(2,2,2), imshow(Figure1Im),title('Desired Image 1');
subplot(2,2,3), imshow(Figure2Im),title('Desired Image 2');
subplot(2,2,4), imshow(Figure3Im), title('Desired Image 3');
disp('------Finished Solving Problem One Part Four------');
pause;


%
% Question 1 Part 5
%
Dowels = imread('Dowels.tif');
strucElement = strel('Disk', 5);
Figure1Im = imopen(Dowels, strucElement);
Figure1Im = imclose(Figure1Im, strucElement);
Figure2Im = imclose(Dowels, strucElement);
Figure2Im = imopen(Figure2Im, strucElement);
figure(5);
subplot(1,2,1), imshow(Figure1Im), title('Desired Image 1');
subplot(1,2,2), imshow(Figure2Im), title('Desired Image 2');
disp('The first figure, imopen is done first which tends to remove some of the foreground pixels from the edges. After that imclose is done which enlarges the boundaries of foreground regions without effecting the original boundary shape much. That is the reason why the final output tends to have some boundaries in the coins.');
disp('The second figure, imopen is done after calling imclose on the image. That is the reason why the foreground has more brighter regions and lesser details present.');

for i = 2:5
    figStrucElem = strel('Disk', i);
    if i == 2
        Figure3Im = imopen(Dowels, figStrucElem);
    else
        Figure3Im = imopen(Figure3Im, figStrucElem);
    end
    Figure3Im = imclose(Figure3Im, figStrucElem);
    if i == 2
        Figure4Im = imclose(Dowels, figStrucElem);
    else
        Figure4Im = imclose(Figure4Im, figStrucElem);
    end
    Figure4Im = imopen(Figure4Im, figStrucElem);
end
figure(6);
subplot(1,2,1), imshow(Figure3Im), title('Desired Image 3');
subplot(1,2,2), imshow(Figure4Im), title('Desired Image 4');
disp('The third figure, imopen is called before imclose and with varying radii everytime. This led to a smoothened image with lesser visible noise in the foreground and the details are almost completely lost.');
disp('The fourth figure imopen is called after imclose, with varying radii everytime. This led to a smoothened image with brighter foreground and a smoother background and no details whatsoever.');
disp('------Finished Solving Problem One Part Five------');
pause;


%
% Question 2 Part 1 : Connected component identification
%
StrucElem = strel('square', 3);
Ball = imread('Ball.tif');
[LabelledImage, numOfComponents] = FindComponentLabels(Ball, StrucElem);
disp('Number of components detected by my code = ');
disp(numOfComponents);
figure(7);
coloredLabels = label2rgb (LabelledImage, 'hsv', 'k', 'shuffle');
imshow(coloredLabels);
disp('------Finished Solving Problem Two Part One------');
pause;

%
% Question 2 Part 2 : Connected component labelling
%
CC = bwconncomp(Ball);
mat = labelmatrix(CC);
disp('Connected Component count = ');
disp(CC.NumObjects);
figure(8);
coloredLabels = label2rgb (mat, 'hsv', 'k', 'shuffle');
imshow(coloredLabels);
disp('------Finished Solving Problem Two Part Two------');
pause;


%
% Question 2 Part 3 : Find only components on border
%
nonBorderElements = imclearborder(Ball);
A = Ball - nonBorderElements;
CC1 = bwconncomp(A);
mat = labelmatrix(CC1);
figure(9);
subplot(1,2,1), imshow(Ball), title('Original Image');
subplot(1,2,2), imshow(A), title('Border Elements Only Image');
disp('Number of components detected = ');
disp(CC1.NumObjects);
disp('------Finished Solving Problem Two Part Three------');
pause;


%
% Question 2 Part 4 : Overlapping components not on the border
%
numPixels = cellfun(@numel,CC.PixelIdxList);
commonSize = mode(numPixels(:));
B = nonBorderElements;
for i = 1:CC.NumObjects
    if(numPixels(i) < commonSize * 1.1)
        B(CC.PixelIdxList{i}) = 0;
    end
end
CC2 = bwconncomp(B);
figure(10);
subplot(1,2,1), imshow(Ball), title('Original Image');
subplot(1,2,2), imshow(B), title('Non-overlapping Circles Only');
disp('Number of components detected = ');
disp(CC2.NumObjects);
disp('------Finished Solving Problem Two Part Four------');
pause;